package com.itwillbs.project.user.controller;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.common.service.MailService;
import com.itwillbs.project.common.util.RandomCodeGenerator;
import com.itwillbs.project.user.dto.MailAuthInfo;
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
	@Autowired
	private MailService mailService;
	
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
		// 인증메일에 포함시킬 인증코드(난수) 생성
		String authCode = RandomCodeGenerator.getRandomCode(6);
		
		if(requestDTO.getType().equals("email")) {
			MailAuthInfo mailAuthInfo = mailService.sendAuthMail(requestDTO.getValue(), authCode);
			System.out.println(">>>>>>>> 인증메일 정보 : " + mailAuthInfo);
			session.setAttribute("authCodeE", authCode);
		} else {
			session.setAttribute("authCodeP", authCode);
		}
		session.setAttribute("authCode", authCode);
		session.setMaxInactiveInterval(60 * 5);
		
		System.out.println(authCode);
		return "{\"authCode\" : \"" + authCode + "\"}";
	}
	
	// 인증번호 확인
	@ResponseBody
	@PostMapping(value = "/verifyCode", produces = "application/json; charset=UTF-8")
	public String verifyCode(@RequestBody Map<String, String> request, HttpSession session) {
	    String inputCode = request.get("code");
	    String inputType = request.get("type");
	    String savedCodeE = (String) session.getAttribute("authCodeE");
	    String savedCodeP = (String) session.getAttribute("authCodeP");
	    
	    if(inputType.equals("email")) {
	    	if (savedCodeE != null && savedCodeE.equals(inputCode)) {
	    		return "{\"success\": true}";
	    	} else {
	    		return "{\"success\": false}";
	    	}
	    } else {
	    	if (savedCodeP != null && savedCodeP.equals(inputCode)) {
	    		return "{\"success\": true}";
	    	} else {
	    		return "{\"success\": false}";
	    	}
	    }
	    
	}
}
