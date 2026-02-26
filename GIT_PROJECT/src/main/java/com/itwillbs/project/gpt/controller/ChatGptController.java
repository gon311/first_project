package com.itwillbs.project.gpt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.gpt.dto.GptGenerateDTO;
import com.itwillbs.project.gpt.service.GptGenerateService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/gpt")
@Log4j2
public class ChatGptController {
	
	private GptGenerateService generateService;
	
	@ResponseBody
	@PostMapping(value = "/generateContent", produces = "application/json; charset=UTF-8")
	public String generateContent(@RequestBody GptGenerateDTO gptGenerateDTO) {
		
		String response = generateService.generateContent(gptGenerateDTO);
		
		return response;
	}
}
