package com.itwillbs.project.my.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/my")
@Log4j2
public class MyController {
	
	@GetMapping("/my")
	public String myMy() {
		
		return "/my/my";
	}
}
