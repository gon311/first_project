package com.itwillbs.project.job.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String posting() {
		
		return "/job/job_posting";
	}
	
	@PostMapping("/JobProcess")
	public String posting(JobDTO jobDTO, HttpSession session) {
		
//		System.out.println(jobDTO.getAddress());
		jobService.jobInsert(jobDTO);
//		System.out.println(jobDTO);
		return "redirect:/job/JobList";
	}
	
	@GetMapping("/JobList")
	public String list(Model model, 
	                   @RequestParam(value="expType", required=false) String expType,
	                   @RequestParam(value="eduType", required=false) String eduType, 
					   @RequestParam(value="selected_items", required=false) List<String> selectedItems) { 
	    
	    // 두 필터 조건을 모두 서비스에 전달
	    List<JobDTO> jobList = jobService.getJobList(expType, eduType, selectedItems);
	    List<Map<String, String>> existRegions = jobService.getExistingRegions();
	    
	    model.addAttribute("jobList", jobList);
	    model.addAttribute("existRegions", existRegions);
	    
	    return "/job/job_list";
	}
	
	@GetMapping("/JobDetail")
	public String jobDetail(@RequestParam("jobId") Long jobId, Model model) {
		
//		System.out.println(jobId);
		JobDTO post = jobService.getJobListDetail(jobId);
		
		List<ResumeDTO> resumeList = jobService.getMyResume();
//		System.out.println("! = " + post.getCompanyName());
//		System.out.println(post.getExpYear());
		model.addAttribute("post", post);
		model.addAttribute("resumeList", resumeList);
		
		return "/job/job_detail";
	}
	
	@GetMapping("/JobManagement")
	public String management() {
		
		return "/job/job_management";
	}
	
	
	
}
