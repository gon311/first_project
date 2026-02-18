package com.itwillbs.project.job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/job")
@RequiredArgsConstructor
@Log4j2
public class JobController {
	
	@GetMapping("/JobPosting")
	public String posting() {
		
		
		
		return "/job/job_posting";
	}
	
	@GetMapping("/JobList")
	public String list() {
		
		return "/job/job_list";
	}
	
	
}
