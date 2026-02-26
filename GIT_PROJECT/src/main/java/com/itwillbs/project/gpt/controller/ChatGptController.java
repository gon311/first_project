package com.itwillbs.project.gpt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/gpt")
@Log4j2
public class ChatGptController {
	
	@ResponseBody
	@PostMapping(value = "/generateContent", produces = "application/json; charset=UTF-8")
	public String generateContent() {
		return null;
	}
}
