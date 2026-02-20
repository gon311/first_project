package com.itwillbs.project.review.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/review")
@Log4j2
public class ReviewController {
	
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
	public String registText() {
		
		return "/review/reviewText";
	}
	// registForm 의 입력값은 따로 DB에 저장되어야, 내 자소서에서 문서를 불러올때 그 값이 유지.
	// 단계값(step)을 줘서 1단계값, 2단계, 완성 표시 
	// text 페이지의 입력값과 함께 챗GPT에 파라미터로 전달

}
