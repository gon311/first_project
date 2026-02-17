package com.itwillbs.project.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/user")
@Log4j2
public class UserController {
	
	@GetMapping("/login")
	public String login() {
		
		return "/user/login_form";
	}
	
	@GetMapping("/regist")
	public String regist() {
		
		return "/user/regist_form";
	}
	
}
