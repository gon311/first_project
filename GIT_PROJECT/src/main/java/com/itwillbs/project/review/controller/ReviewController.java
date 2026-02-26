package com.itwillbs.project.review.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.review.dto.CoverLetterDTO;
import com.itwillbs.project.review.service.ReviewService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/review")
@Log4j2
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("/registForm")
	public String registForm() {
		
		return "/review/reviewForm";
	}
	
	@GetMapping("/spellCheck")
	public String spellCheck() {
		
		return "/review/reviewSpellCheck";
	}
	
	@GetMapping("/copyCheck")
	public String copyCheck() {
		
		return "/review/reviewCopyCheck";
	}
	
	// 1단계 임시저장 
	@PostMapping("/draftSave")
	@ResponseBody
	public Map<String, Object> draftSave(@ModelAttribute CoverLetterDTO coverLetterDTO, HttpSession session) {
		Long userId = (Long)session.getAttribute("userIdx");
		coverLetterDTO.setUserId(userId);
		reviewService.registForm(coverLetterDTO); 
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		result.put("message", "임시저장이 완료되었습니다.");
		return result;
	}
	
	// 1단계 저장 후 coverLetterIdx를 주소에 넣어서 redirect
	@PostMapping("/registText")
	public String registText(CoverLetterDTO coverLetterDTO, HttpSession session) {
		Long userId = (Long)session.getAttribute("userIdx");
		coverLetterDTO.setUserId(userId);
		reviewService.registForm(coverLetterDTO);  
		Integer coverLetterIdx = coverLetterDTO.getCoverLetterIdx();
		
	    return "redirect:/review/" + coverLetterIdx + "/registText";
	}
	
	// 2단계 작성 
	@GetMapping("/{coverLetterIdx}/registText")
	public String registText(@PathVariable Integer coverLetterIdx) {
		
		return "/review/registText";
		
	}
	
	
	
	
	@PostMapping("/save")
	public String reviewSave(CoverLetterDTO coverLetterDTO) {
		log.info(">>>>>>>>>>>>>> coverLetterDTO: " + coverLetterDTO);
		
		
		return "/review/reviewSave";
	}

}
