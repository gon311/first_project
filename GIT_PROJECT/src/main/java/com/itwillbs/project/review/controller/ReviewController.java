package com.itwillbs.project.review.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@PostMapping("/registText")
	public String registText(CoverLetterDTO coverLetterDTO, HttpSession session, Model model) {
		Long userId = (Long)session.getAttribute("userIdx");
		
		coverLetterDTO.setUserId(userId);
		
		reviewService.registForm(coverLetterDTO);  
		
		model.addAttribute(coverLetterDTO);
		
	    return "/review/reviewText";
	}
	
	
	
	
	@PostMapping("/save")
	public String reviewSave(CoverLetterDTO coverLetterDTO) {
		log.info(">>>>>>>>>>>>>> coverLetterDTO: " + coverLetterDTO);
		
		
		return "/review/reviewSave";
	}

}
