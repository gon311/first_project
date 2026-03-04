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
	public String posting(HttpSession session) {
		
		String sId = (String) session.getAttribute("userType");
		System.out.println(sId);
	    if (sId == null || "P".equals(sId)) return "redirect:/user/login";
		
		return "/job/job_posting";
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
		System.out.println(sId);
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
	    String sId = (String) session.getAttribute("userType");
	    
	    if (userIdx == null || "P".equals(sId)) return "redirect:/user/login";

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
//		System.out.println("! = " + post.getCompanyName());
//		System.out.println(post.getExpYear());
//		System.out.println(resumeList);
		model.addAttribute("post", post);
		model.addAttribute("resumeList", resumeList);
//		System.out.println(resumeList);
		
		return "/job/job_detail";
	}
	
	@GetMapping("/JobManagement")
	public String management(HttpSession session) {
		
		String sId = (String) session.getAttribute("userType");
//		System.out.println(sId);
	    if (sId == null || "P".equals(sId)) return "redirect:/user/login";
		
		return "/job/job_management";
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
	
}
