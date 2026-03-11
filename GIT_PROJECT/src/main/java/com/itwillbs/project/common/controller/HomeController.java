package com.itwillbs.project.common.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class HomeController {
	
	@GetMapping("/")
	public String main(HttpSession session) {
		session.setAttribute("memberType", "user");
	    return "/mainUser";
	}
	
	@GetMapping("/mainCom")
	public String mainCom(HttpSession session) {
		session.setAttribute("memberType", "company");
		return "/mainCom";
	}
	
	// 임시) 
	@GetMapping("/admin/main")
	public String adminMain() {
		
		return "admin/common/main";
	}
	
	
	
}
