package com.itwillbs.project.common.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.project.common.DTO.CompanyCardDTO;

@Controller
public class CompanyCardController {
	
	@GetMapping("/card/list")
	public List<CompanyCardDTO> getCardList() {
		return null;
	}
		
}
