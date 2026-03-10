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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.util.FileUtils;
import com.itwillbs.project.common.exception.BackwardException;
import com.itwillbs.project.job.dto.JobApplicationDTO;
import com.itwillbs.project.job.dto.JobDTO;
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
		
//		System.out.println(jobDTO.getAddress());
		jobService.jobInsert(jobDTO, files, sId);
//		System.out.println(jobDTO);
		return "redirect:/job/JobList";
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
	
	@GetMapping("/JobList")
	public String list(Model model, HttpSession session,
	                   @RequestParam(value="expType", required=false) String expType,
	                   @RequestParam(value="eduType", required=false) String eduType, 
					   @RequestParam(value="selected_items", required=false) List<String> selectedItems) { 
	    
		Long userIdx = (Long) session.getAttribute("userIdx");
	    // 두 필터 조건을 모두 서비스에 전달
	    List<JobDTO> jobList = jobService.getJobList(expType, eduType, userIdx, selectedItems);
	    List<Map<String, String>> existRegions = jobService.getExistingRegions();
//	    System.out.println(jobList);
	    model.addAttribute("jobList", jobList);
	    model.addAttribute("existRegions", existRegions);
	    
	    return "/job/job_list";
	}
	
	@GetMapping("/JobDetail")
	public String jobDetail(@RequestParam("jobId") Long jobId, Model model,
			HttpSession session, ResumeDTO resume) {
		
//		System.out.println(userId);
		JobDTO post = jobService.getJobListDetail(jobId);
		Long userIdx = (Long)session.getAttribute("userIdx");
//		System.out.println(userIdx);
		
		List<ResumeDTO> resumeList = jobService.getMyResume(userIdx);
		List<FileDTO> detailFile = jobService.getFileList(jobId);
//		System.out.println("! = " + post.getCompanyName());
//		System.out.println(post.getExpYear());
//		for (FileDTO file : detailFile) {
//		    System.out.println("파일명: " + file.getOriginName());
//		    System.out.println("확장자: " + file.getFileExt());
//		}
		
		model.addAttribute("post", post);
		model.addAttribute("resumeList", resumeList);
		model.addAttribute("detailFile", detailFile);
//		System.out.println(resumeList);
		
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
//	    System.out.println("ResumeId : "+applicationDTO.getResumeId());
//	    System.out.println("JobId : "+applicationDTO.getJobId());
//	    System.out.println("UserId : "+userId);
	    
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
	
	// ===================================================
	// 지원자 관리
	
	@GetMapping("/comApplicants")
	public String management(HttpSession session, Model model, 
	                         @RequestParam(value = "jobId", required = false) Long jobId) {
	    
	    String userType = (String) session.getAttribute("userType");
	    Long compId = (Long) session.getAttribute("userIdx");

	    // 기업 회원이 아니면 접근 불가
	    if (compId == null || !"C".equals(userType)) return "redirect:/user/login";

	    // 1. 해당 기업의 모든 공고 리스트 (필터용)
	    // 2. 특정 공고(jobId)의 지원자 리스트 조회
	    // 아래 서비스 메서드들은 필요에 따라 JobService에 추가 구현이 필요합니다.
	    List<JobApplicationDTO> applicantList = jobService.getApplicantList(jobId, compId);
	    String postingTitle = jobService.getPostingTitle(jobId);
	    
	    model.addAttribute("applicantList", applicantList);
	    model.addAttribute("selectedJobId", jobId);
	    model.addAttribute("postingTitle", postingTitle);
	    
	    return "/job/job_management";
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
	
}
