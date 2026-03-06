package com.itwillbs.project.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class HomeController {
	
	@GetMapping("/")
	public String main() {
	    
	    return "/mainUser";
	}
	
	@GetMapping("/mainCom")
	public String mainCom() {
		
		return "/mainCom";
	}
	
	@GetMapping("/admin/main")
	public String adminMain() {
		
		return "admin/common/main";
	}
	
	
	
}
