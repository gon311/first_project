package com.itwillbs.project.job.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.comMy.dto.ComJobRowDTO;
import com.itwillbs.project.comMy.dto.ComMyDTO;
import com.itwillbs.project.comMy.dto.JobCond;
import com.itwillbs.project.comMy.service.ComMyService;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.util.FileUtils;
import com.itwillbs.project.common.exception.BackwardException;
import com.itwillbs.project.common.paging.PageReq;
import com.itwillbs.project.common.paging.PageRes;
import com.itwillbs.project.job.dto.JobApplicationDTO;
import com.itwillbs.project.job.dto.JobDTO;
import com.itwillbs.project.job.dto.JobPageDTO;
import com.itwillbs.project.job.service.JobService;
import com.itwillbs.project.resume.dto.ResumeDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/job")
@RequiredArgsConstructor
@Log4j2
public class JobController {
	
	@Autowired
	private JobService jobService;
	@Autowired
	private ComMyService comMyService;
	
	@GetMapping("/JobPosting")
	public String jobInsert(HttpSession session, Model model, RedirectAttributes rt) {
	    Long userIdx = (Long) session.getAttribute("userIdx");
	    String userType = (String) session.getAttribute("userType");

	    if (userIdx == null || !"C".equals(userType)) {
	        return "redirect:/user/login";
	    }

	    boolean isActive = jobService.isActiveProduct(userIdx);
	    
	    // 만약 이용권이 없으면 페이지 로딩 전에 알림창을 띄우고 돌려보냄
	    if (!isActive) {
	    	rt.addFlashAttribute("msg", "이용권이 만료되었습니다. 이용권 결제 후 공고 등록이 가능합니다.");
	    	return "redirect:/job/JobList"; // 뒤로가기를 시키거나 구매페이지로 리다이렉트
	    }
	    model.addAttribute("isActive", isActive);
	    
	    return "job/job_posting";
	}
	
	@PostMapping("/JobProcess")
	public String posting(JobDTO jobDTO, HttpSession session,
			List<MultipartFile> files) throws IOException {
		String sId = "/" + session.getAttribute("userIdx");
		
		jobService.jobInsert(jobDTO, files, sId);
		return "redirect:/comMy/info";
	}
	
	@GetMapping("/edit")
	public String edit(HttpSession session, Model model,
			@RequestParam("jobId") Long jobId) {
		String sId = (String) session.getAttribute("userType");
//		System.out.println(sId);
	    if (sId == null || "P".equals(sId)) return "redirect:/user/login";
		
	    JobDTO jobDTO = jobService.getJobListDetail(jobId);
	    List<FileDTO> fileList = jobService.getFileList(jobId);
	    model.addAttribute("job", jobDTO);
	    model.addAttribute("fileList", fileList);
	    
		return "/job/job_correction";
	}
	
	@PostMapping("/jobCorrection")
	public String jobCorrection(JobDTO jobDTO, 
	                           @RequestParam("jobId") Long jobId, 
	                           @RequestParam(value="deleteFiles", required=false) List<Integer> deleteFiles,
	                           List<MultipartFile> files,
	                           HttpSession session, 
	                           RedirectAttributes rt) throws IOException {
	    
	    Long userIdx = (Long) session.getAttribute("userIdx");
	    String userType = (String) session.getAttribute("userType");
	    String sId = "/" + session.getAttribute("userIdx");
	    
	    if (userIdx == null || "P".equals(userType)) return "redirect:/user/login";

	    // 2. DTO에 필요한 정보 세팅 (누락 방지)
	    jobDTO.setJobId(jobId);
	    jobDTO.setCompId(userIdx); // 자신의 공고만 수정할 수 있도록 조건으로 사용

	    // 3. 서비스 호출하여 업데이트 수행
	    // (여기서는 업데이트 대상 컬럼만 XML에서 처리할 예정입니다)
	    boolean isUpdateSuccess = jobService.modifyJob(jobDTO, files, deleteFiles, sId);

	    if (isUpdateSuccess) {
	        rt.addFlashAttribute("msg", "공고 수정이 완료되었습니다.");
	    } else {
	        rt.addFlashAttribute("msg", "공고 수정에 실패하였습니다. 권한을 확인하세요.");
	    }

	    return "redirect:/job/JobList"; 
	}
	
	@GetMapping("/JobDetail")
	public String jobDetail(@RequestParam("jobId") Long jobId, Model model,
			HttpSession session, ResumeDTO resume) {
		
		JobDTO post = jobService.getJobListDetail(jobId);
		Long userIdx = (Long)session.getAttribute("userIdx");
		
		List<ResumeDTO> resumeList = jobService.getMyResume(userIdx);
		List<FileDTO> detailFile = jobService.getFileList(jobId);
		
		model.addAttribute("post", post);
		model.addAttribute("resumeList", resumeList);
		model.addAttribute("detailFile", detailFile);
		
		return "/job/job_detail";
	}
	
	@PostMapping("/ApplyAction")
	public String applyAction(
			HttpSession session,
			JobApplicationDTO applicationDTO,
			@RequestParam("resumeId") Integer resumeId,
			@RequestParam("jobId") Long jobId,
			RedirectAttributes rt) {
		
		String sId = (String) session.getAttribute("userType");
		Long userId = (Long)session.getAttribute("userIdx");
		applicationDTO.setUserId(userId);
//		System.out.println(sId);
		if (sId == null || "C".equals(sId)) return "redirect:/user/login";
		
		if(resumeId == null) {
			throw new BackwardException("잘못된 접근입니다!");
		}
		
		int applyCount = jobService.checkAlreadyApplied(applicationDTO);
		
		if(applyCount > 0) {
	        throw new BackwardException("이미 이 공고에 지원하신 내역이 존재합니다.");
	    }
	    
	    jobService.insertApplication(applicationDTO);
	    
	    rt.addFlashAttribute("msg", "지원이 완료되었습니다.");
	    
	    return "redirect:/job/JobList";
	}
	
	@ResponseBody
	@PostMapping("/toggleBookmark")
	public String toggleBookmark(@RequestParam("jobId") Long jobId, 
	                             @RequestParam("status") String status, 
	                             HttpSession session) {
	    // 1. 세션에서 로그인한 사용자 정보 가져오기
		Long userIdx = (Long)session.getAttribute("userIdx");
	    
	    if (userIdx == null) {
	        return "login_required"; // 로그인이 안 된 경우
	    }
	    
	    // 2. 서비스 호출 (성공 시 "success" 반환)
	    try {
	        jobService.updateBookmark(userIdx, jobId, status);
	        return "success";
	    } catch (Exception e) {
	        return "error";
	    }
	}
	
	// 지원자 전형 상태 업데이트 (서류대기 -> 면접진행 등)
	@ResponseBody
	@PostMapping("/updateAppStatus")
	public String updateAppStatus(@RequestParam("appId") int appId, 
	                              @RequestParam("appStep") String appStep) {
	    try {
	        jobService.updateApplicationStatus(appId, appStep);
	        return "success";
	    } catch (Exception e) {
	        return "error";
	    }
	}

	// 관심 지원자(별표) 토글
	@ResponseBody
	@PostMapping("/toggleAppFavorite")
	public String toggleAppFavorite(@RequestParam("appId") int appId, 
	                                @RequestParam("isFavorite") String isFavorite) {
	    try {
	        jobService.updateApplicationFavorite(appId, isFavorite);
	        return "success";
	    } catch (Exception e) {
	        return "error";
	    }
	}
	
	@GetMapping("/JobList")
	public String list(Model model, HttpSession session,
	                    @RequestParam(value = "q", required = false) String q,           // 검색어: 'q'로 통일
	                    @RequestParam(defaultValue = "all") String status,
	                    @RequestParam(value="page", defaultValue = "1") int page,       
	                    @RequestParam(defaultValue = "10") int size,                     // 공고 목록은 보통 12개씩(4배수) 많이 봅니다
	                    @RequestParam(value="expType", required=false) String expType,
	                    @RequestParam(value="eduType", required=false) String eduType, 
	                    @RequestParam(value="selected_items", required=false) List<String> selectedItems) {
	    
	    Long userIdx = (Long) session.getAttribute("userIdx");
	    String sId = (String) session.getAttribute("sId"); 

	    // ✅ 핵심 수정 1: jobService에 검색어 'q'를 반드시 같이 보내야 합니다.
	    // 기존 코드에는 q가 빠져 있어서 검색어를 입력해도 로직에 반영되지 않았습니다.
	    List<JobDTO> jobList = jobService.getJobListPaging(expType, eduType, userIdx, selectedItems, q, page, size);
	    
	    // ✅ 핵심 수정 2: 전체 공고 개수(total)도 검색어와 필터가 적용된 결과로 가져와야 페이징이 정확합니다.
	    // (현재는 comMyService의 관리자용 카운트를 쓰고 있는데, 이를 jobService용으로 분리 권장)
	    int total = jobService.getJobListCount(expType, eduType, userIdx, selectedItems, q);
	    
	    // 페이징 객체 생성 (PageReq 대신 직접 전달하거나 PageReq 활용)
	    PageReq pageReq = new PageReq();
	    pageReq.setPage(page);
	    pageReq.setSize(size);
	    PageRes pager = PageRes.of(pageReq, total);
	    
	    // 데이터 바인딩
	    model.addAttribute("jobList", jobList);  
	    model.addAttribute("pager", pager);
	    model.addAttribute("q", q);             // 검색어 유지
	    model.addAttribute("expType", expType);
	    model.addAttribute("eduType", eduType);
	    model.addAttribute("selectedItems", selectedItems);
	    
	    // 기타 정보
	    List<Map<String, String>> existRegions = jobService.getExistingRegions();
	    model.addAttribute("existRegions", existRegions);
	    
	    return "/job/job_list";
	}
	
	@GetMapping("/ApplicantManage")
	public String applicantManage(
	        @ModelAttribute("cond") JobCond cond, 
	        BindingResult bindingResult, 
	        @RequestParam(value = "page", defaultValue = "1") int pageVal, 
	        @RequestParam(value = "size", defaultValue = "10") int sizeVal, 
	        HttpSession session, Model model) {

	    // 세션 체크
	    Long compId = (Long) session.getAttribute("userIdx");
	    String userType = (String) session.getAttribute("userType");
	    if (compId == null || !"C".equals(userType)) return "redirect:/user/login";

	    // [핵심 로직]
	    // 스프링이 'page'라는 파라미터를 cond.page(객체)에 담으려다 실패했더라도,
	    // 우리가 @RequestParam으로 가로챈 숫자(pageVal)를 수동으로 꽂아넣습니다.
	    cond.setUserId(compId);
	    cond.getPage().setPage(pageVal);
	    cond.getPage().setSize(sizeVal);

	    // 서비스 호출
	    List<JobApplicationDTO> applicantList = jobService.getApplicantListPaging(cond);
	    int totalCount = jobService.getApplicantCount(cond);
	    Map<String, Integer> statusCounts = jobService.getApplicantStatusCounts(cond);
	    
	    // 페이징 결과 생성
	    PageRes pager = PageRes.of(cond.getPage(), totalCount);
	    
	    // 모델 전송
	    model.addAttribute("applicantList", applicantList);
	    model.addAttribute("pager", pager);
	    model.addAttribute("statusCounts", statusCounts);
	    model.addAttribute("postingTitle", jobService.getPostingTitle(cond.getJobId()));

	    return "job/job_management";
	}
	
}
