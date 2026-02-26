package com.itwillbs.project.resume.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/resume")
@RequiredArgsConstructor
public class ResumeController {

	// resume/regist
	// 이력서 등록페이지 - 1.으로 이동 
	@GetMapping("/regist")
	public String resumeRegist() {
		
		return "/resume/resumeForm";
	}
	
	// 이력서 등록페이지 - 2 (기본정보/사회적/병력/등등...)
	@PostMapping("/regist2")
	public String resumeRegist2() {
		
		return "/resume/resumeRegist2";
	}
}
