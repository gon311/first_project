package com.itwillbs.project.user.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.user.dto.RequestCorrectionDTO;
import com.itwillbs.project.user.service.BizService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequiredArgsConstructor
@RequestMapping("biz")
@Log4j2
public class BizController {
	private final BizService bizService;
	
	@ResponseBody
	@PostMapping(value = "/correctionContent", produces = "application/json; charset=UTF-8")
	public String correctionContent(@RequestBody RequestCorrectionDTO requestDTO) throws IOException {
		System.out.println(">>>>>>>>>> requestDTO : " + requestDTO);
		String response = bizService.correction(requestDTO.getB_no());
		System.out.println(">>>>>>>>>> 교정 결과 : " + response);
		return response;
	}
}
