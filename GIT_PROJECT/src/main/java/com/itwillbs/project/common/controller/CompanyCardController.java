package com.itwillbs.project.common.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.common.DTO.CompanyCardDTO;
import com.itwillbs.project.common.service.CompanyCardService;

@Controller
public class CompanyCardController {
	@Autowired
	private CompanyCardService companyCardService;
	
	@GetMapping("/card/list")
	public List<CompanyCardDTO> getCardList(@RequestParam String type) {
		 List<CompanyCardDTO> List = companyCardService.getCardList(type);
		 
		return List;
	}
		
}
