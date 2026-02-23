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
	public String list(Model model, String expType) { // expType 파라미터 추가
	    List<JobDTO> jobList = jobService.getJobList(expType); // 서비스에 전달
	    model.addAttribute("jobList", jobList);
	    model.addAttribute("selectedExp", expType); // JSP에서 선택 상태 유지를 위해 추가
	    return "/job/job_list";
	}
	
	@GetMapping("/JobRelay")
	public String relay() {
		
		return "/job/job_relay";
	}
	
	@GetMapping("/JobManagement")
	public String management() {
		
		return "/job/job_management";
	}
	
}
