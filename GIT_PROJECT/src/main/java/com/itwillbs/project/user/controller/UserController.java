package com.itwillbs.project.user.controller;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.protobuf.TextFormat.Printer;
import com.itwillbs.project.user.dto.UserDTO;
import com.itwillbs.project.user.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
@Log4j2
public class UserController {
	private final UserService userService;
	
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
		
//		String encryptedPassword = passwordEncoder.encode(userDTO.getPassword());
//		userDTO.setPassword(encryptedPassword);
		System.out.println(userDTO);
		
		if(userDTO.getUserType().equals("P")) {
			userService.registUser(userDTO);
		} else if(userDTO.getUserType().equals("C")) {
			
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/find")
	public String find() {
		
		return "/user/find_form";
	}
	
}
