package com.itwillbs.project.job.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	@PostMapping("/job_process")
	public String posting(JobDTO jobDTO) {
		
		jobService.jobInsert(jobDTO);
		System.out.println(jobDTO);
		return "redirect:/job_posting";
	}
	
	@GetMapping("/JobList")
	public String list() {
		
		return "/job/job_list";
	}
	
	
}
