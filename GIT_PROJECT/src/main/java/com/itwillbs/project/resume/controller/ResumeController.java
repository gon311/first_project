package com.itwillbs.project.resume.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.core.appender.rewrite.MapRewritePolicy.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String resumeRegist(HttpSession session) {
		// int userIdx = Integer.parseInt( session.getAttribute("userIdx").toString());
	    if ( session.getAttribute("userIdx") == null ) {
	        // 세션 정보가 없으면 로그인 페이지로 이동
	        return "redirect:/user/login";
	    }
		
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
//	        System.out.println(name + " = " + value);
	    }   
	    
		return "resume/resumeRegist2";
	}
	
	// resume/resumeSave
	// 이력서를 저장.
	@PostMapping("/resumeSave") 
	public String resumeSave(ResumeDTO resumeDTO, HttpSession session
								, HttpServletRequest request) {
		
		// 세션에서 sId 꺼내오기(유저아디 - bigint)
	    int userIdx = Integer.parseInt( session.getAttribute("userIdx").toString());
	    	    
	    // DTO에 세션 값 추가
	    resumeDTO.setUserId(userIdx);   

	    // 저장 로직.
		int resumeId = resumeService.registResume(resumeDTO);
		
		// 저장 성공 시 -> 내 이력서 상세 페이지로 redirect.
//		return "/resume/resumeRegist2";
		return "redirect:/resume/resumeView?resumeId=" + resumeId;
	}
	
	// 이력서 상세정보.
	@GetMapping("/resumeView")
	public String resumeView(@RequestParam("resumeId") Integer resumeId
								,HttpSession session
								,Model model) {
		
		 if (resumeId == null) {
		        return "redirect:/resume/list";
		 }
		 ResumeDTO resume = resumeService.getResumeInfo(resumeId);

		 if (resume == null) {
	        return "redirect:/resume/list";
		 }
		 model.addAttribute("resume", resume);
		 return "resume/resumeView";
		    
	} // 이력서 상세정보 끝.
	
	// 수정페이지
	@PostMapping("/resumeModify")
	public String resumeModify(ResumeDTO resumeDTO, RedirectAttributes ra
	                            ,HttpSession session ) {

	    int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
	    resumeDTO.setUserId(userIdx);

	    int resultCount = resumeService.modifyResume(resumeDTO);
	    log.info("resultCount : "+ resultCount);

	    ra.addAttribute("resumeId", resumeDTO.getResumeId());

	    return "redirect:/resume/resumeView";
	}
	
	// 내 이력서 리스트 
	@GetMapping("/resumeList")
	public String resumeList(HttpSession session, Model model) {
		// 세션에서 sId 꺼내오기(유저아디 - bigint)
//	    int userIdx = Integer.parseInt( session.getAttribute("userIdx").toString()) ;
//	    log.info("userIdx : " + userIdx);
		int userIdx = Integer.parseInt( session.getAttribute("userIdx").toString()) ;
		
		List<ResumeDTO> resumeList = resumeService.getResumeList(userIdx);
//		System.out.println("이력서 리스트 : "+ resumeList);
		model.addAttribute("resumeList", resumeList );
		
	    return "resume/resumeList"; // 
	}

//	List<ProductDTO> productList = productService.getProductList();
//	System.out.println("상품정보 리스트 : "+ productList);
//	model.addAttribute("productList", productList);	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
