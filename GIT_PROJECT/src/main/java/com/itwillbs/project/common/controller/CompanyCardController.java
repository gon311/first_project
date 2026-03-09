package com.itwillbs.project.common.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.common.dto.CompanyCardDTO;
import com.itwillbs.project.common.service.CompanyCardService;

@Controller
@RequestMapping("/card")
public class CompanyCardController {
	@Autowired
	private CompanyCardService companyCardService;
	
	@GetMapping("/list")
	@ResponseBody
	public List<CompanyCardDTO> getCardList(@RequestParam String type, 
											HttpSession session) {
		
		Long userIdx = (Long)session.getAttribute("userIdx"); 
		List<CompanyCardDTO> List = companyCardService.getCardList(type, userIdx);
		 
		return List;
	}
		
}
