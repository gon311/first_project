package com.itwillbs.project.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/")
	public String main() {
	    
	    return "/admin/common/main";
	}
	
	
}
