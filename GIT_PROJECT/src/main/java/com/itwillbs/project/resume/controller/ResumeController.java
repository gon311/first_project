package com.itwillbs.project.resume.controller;

import org.apache.logging.log4j.core.appender.rewrite.MapRewritePolicy.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.resume.dto.ResumeDTO;
import com.itwillbs.project.resume.services.ResumeService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/resume")
@Log4j2
public class ResumeController {

	// 서비스 등록
	@Autowired
	private ResumeService resumeService;
	
	//	이력서 작성 1번으로 이동( 업종/ 직종/ 기업형태/ 지원분야/ 지원기업명/ 경력.신입.인턴 )
	@GetMapping("/regist")
	public String resumeRegist() {

		return "/resume/resumeForm";
	}

	// 이력서 작성 2번으로 이동 : 기본정보/ 사회적/ 병역정보/ 학력정보/ 
	@PostMapping("/regist2")
	public String resumeRegist2() {
		
		return "resume/resumeRegist2";
	}
		
	@PostMapping("/resumeRegist") // 저장 버튼 클릭 : 저장후 상세페이지 이동
	public String resumeRegist2(ResumeDTO resumeDTO) {
		// 이력서 저장.
		// resumeService.registResume(resumeDTO);
	
		
		return "redirect:/resume/resumeView";
	}
	
	@GetMapping("/resumeView") // 이력서 상세페이지
	public String resumeInfo(ResumeDTO resumeDTO, Model model ) {
		
		return "redirect:/";
	}
	
	// 내 이력서 목록 페이지로 이동.
	@GetMapping("/list")
	public String resumeList(Model model) {
								
		return "resume/resumeList";
	}
	
	// 이력서 상세 페이지(이력서 id 포함)로 이동
	@GetMapping("/view")
	public String resumeView(ResumeDTO resumeDTO, Model model) {
		
		return "resume/resumeView";
	}
}
