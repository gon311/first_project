package com.itwillbs.project.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.user.dto.RequestCorrectionDTO;
import com.itwillbs.project.user.service.ApiService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequiredArgsConstructor
@RequestMapping("api")
@Log4j2
public class ApiController {
	private final ApiService apiService;
	
	//사업자등록
	@ResponseBody
	@PostMapping(value = "/correctionContent", produces = "application/json; charset=UTF-8")
	public String correctionContent(@RequestBody RequestCorrectionDTO requestDTO) throws IOException {
		String response = apiService.correction(requestDTO.getB_no());
		return response;
	}
	
	//메일발송
	@ResponseBody
	@PostMapping(value = "/sendCode", produces = "application/json; charset=UTF-8")
	public String sendCode(@RequestBody RequestCorrectionDTO requestDTO, HttpSession session) throws IOException {
		String authCode = UUID.randomUUID().toString().substring(30);
		session.setAttribute("authCode", authCode);
		session.setMaxInactiveInterval(60 * 5);
		
		if(requestDTO.getType().equals("email")) {
			apiService.sendWelcomeEmail(requestDTO.getValue(), authCode);
		} else {
			
		}
		
		return "{\"authCode\" : \"" + authCode + "\"}";
	}
	
	// 인증번호 확인
	@ResponseBody
	@PostMapping(value = "/verifyCode", produces = "application/json; charset=UTF-8")
	public String verifyCode(@RequestBody Map<String, String> request, HttpSession session) {
	    String inputCode = request.get("code");
	    String savedCode = (String) session.getAttribute("authCode");

	    if (savedCode != null && savedCode.equals(inputCode)) {
	        return "{\"success\": true}";
	    } else {
	        return "{\"success\": false}";
	    }
	}
}
