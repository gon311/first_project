package com.itwillbs.project.review.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/review")

public class ReviewController {
	
	@GetMapping("/registForm")
	public String registForm() {
		return "/review/reviewRegistForm";
	}
	
	@GetMapping("/spellCheck")
	public String spellCheck() {
		return "/review/reviewSpellCheck";
	}
	
	@GetMapping("/copyCheck")
	public String copyCheck() {
		return "/review/reviewCopyCheck";
	}

}
