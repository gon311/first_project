package com.itwillbs.project.gpt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.itwillbs.project.gpt.dto.GptGenerateDTO;
import com.itwillbs.project.gpt.dto.PassCheckDTO;
import com.itwillbs.project.gpt.service.GptGenerateService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/gpt")
@Log4j2
public class GptGenerateController {
	
	@Autowired
	private GptGenerateService generateService;
	
	@ResponseBody
	@PostMapping(value = "/generateContent", produces = "application/json; charset=UTF-8")
	public String generateContent(@RequestBody GptGenerateDTO gptGenerateDTO) throws JsonProcessingException {
		
		String response = generateService.generateContent(gptGenerateDTO);
		
		return response;
	}
	
	@ResponseBody
	@PostMapping(value = "/checkAndDeductPass", produces = "application/json; charset=UTF-8")
	public Map<String, Object> checkAndDeductPass(HttpSession session) {
		Map<String, Object> response = new HashMap<String, Object>();
		
		// 로그인 정보 가져오기 
		Long userId = (Long)session.getAttribute("userIdx");
		
		// 패스권 체크 및 차감 
		Boolean isDeducted = generateService.deductUserPass(userId);
		
		if(isDeducted) {
			response.put("success", true);
		} else {
			response.put("success", false);
			response.put("message", "이용권이 없거나 모두 소진되었습니다. 충전 후 사용해 주세요.");
		}
		
		return response;
	}
	
	
	
	
	@ResponseBody
	@PostMapping(value = "/spellCheck", produces = "application/json; charset=UTF-8")
	public String spellCheck(@RequestBody Map<String, String> requests) throws JsonProcessingException {
		String inputText = requests.get("inputText");
		String response = generateService.spellCheck(inputText);
		
		return response;
	}
	
	@ResponseBody
	@PostMapping(value = "/copyCheck", produces = "application/json; charset=UTF-8")
	public String copyCheck(@RequestBody Map<String, String> requests) throws JsonProcessingException {
		String inputText = requests.get("inputText");
		String response = generateService.copyCheck(inputText);
		
		return response;
	}
}
