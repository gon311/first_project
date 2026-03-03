package com.itwillbs.project.resume.controller;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.core.appender.rewrite.MapRewritePolicy.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.project.resume.dto.ResumeDTO;
import com.itwillbs.project.resume.service.ResumeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/resume")
@RequiredArgsConstructor
@Log4j2
public class ResumeController {

	@Autowired
	private ResumeService resumeService;
	
	// resume/regist
	// 이력서 등록페이지 - 1.으로 이동 
	@GetMapping("/regist")
	public String resumeRegist() {
		
		return "resume/resumeForm";
	}
	
	// 이력서 등록페이지 - 2 (기본정보/사회적/병력/등등...)
	@PostMapping("/regist2")
	public String resumeRegist2(ResumeDTO resumeDTO, HttpServletRequest request) {
		// 이전 페이지에서 넘어온 파라미터 첵크
		Enumeration<String> paramNames = request.getParameterNames();
	    while (paramNames.hasMoreElements()) {
	        String name = paramNames.nextElement();
	        String value = request.getParameter(name);
	        System.out.println(name + " = " + value);
	    }
		    
	    
		return "resume/resumeRegist2";
	}
	
	// resume/resumeSave
	// 이력서를 저장.
	@PostMapping("/resumeSave") 
	public String resumeSave(ResumeDTO resumeDTO, HttpSession session
								, HttpServletRequest request) {
		
		// 세션에서 sId 꺼내오기(유저아디 - bigint)
	    int userIdx = Integer.parseInt( session.getAttribute("userIdx").toString()) ;

	    log.info(userIdx);
	    // DTO에 세션 값 추가
	    resumeDTO.setUser_id(userIdx);   
	
//	    log.info("resumeDTO : ",resumeDTO);
		// 저장 로직.
		resumeService.registResume(resumeDTO);
		
		// 저장 성공 시 -> 내 이력서 상세 페이지로 redirect.
//		return "";
		return "redirect:/resume/resumeView";
	}
	
	// 이력서 상세정보.
	@GetMapping("/resumeView")
	public String resumeView(ResumeDTO resumeDTO,Mode model) {
		
		// db에서 받아온 DTO
		ResumeDTO dbResumeDTO = resumeService.getResumeInfo(resumeDTO.getResume_id());
		
		//
		
		return "/resume/resumeView";
	}
}
