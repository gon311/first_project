package com.itwillbs.project.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.project.user.dto.UserDTO;

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
	public String registG() {
		
		return "/user/regist_form";
	}
	
	@PostMapping("/regist")
	public String registP(UserDTO userDTO) {
		
		return "redirect:/";
	}
	
	@GetMapping("/find")
	public String find() {
		
		return "/user/find_form";
	}
	
}
