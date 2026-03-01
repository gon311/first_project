package com.itwillbs.project.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.user.dto.RequestCorrectionDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequiredArgsConstructor
@RequestMapping("biz")
@Log4j2
public class BizController {
	@ResponseBody
	@PostMapping(value = "/correctionContent", produces = "application/json; charset=UTF-8")
	public String correctionContent(@RequestBody RequestCorrectionDTO requestDTO) {
		log.info(">>>>>>>>>> requestDTO : " + requestDTO);
		
		return null;
	}
}
