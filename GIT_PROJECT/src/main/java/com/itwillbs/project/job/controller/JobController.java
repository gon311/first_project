package com.itwillbs.project.job.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.project.job.dto.JobDTO;
import com.itwillbs.project.job.service.JobService;

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
		
		System.out.println(jobDTO.getAddress());
		jobService.jobInsert(jobDTO);
		System.out.println(jobDTO);
		return "redirect:/job/JobList";
	}
	
	@GetMapping("/JobList")
	public String list(Model model) {
	    // 1. DB에서 리스트를 가져온다
	    List<JobDTO> jobList = jobService.getJobList();
	    
	    // 2. "jobList"라는 이름으로 JSP에 전달한다 (매우 중요!)
	    model.addAttribute("jobList", jobList);
	    
	    log.info("조회된 공고 개수: " + (jobList != null ? jobList.size() : 0));
	    
	    return "/job/job_list";
	}
	
	
}
