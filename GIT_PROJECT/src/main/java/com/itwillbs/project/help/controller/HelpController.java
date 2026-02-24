package com.itwillbs.project.help.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.taglibs.standard.lang.jstl.test.beans.PublicBean1;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.project.job.dto.JobDTO;
import com.itwillbs.project.job.service.JobService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/help")
@RequiredArgsConstructor
@Log4j2
public class HelpController {
	
	@GetMapping("/helpWord")
	public String posting() {
		
		return "/help/help_word";
	}
	
}
