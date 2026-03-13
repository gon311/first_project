package com.itwillbs.project.help.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.PageInfoDTO;
import com.itwillbs.project.admin.dto.SearchDTO;
import com.itwillbs.project.admin.service.AdminService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/help")
@RequiredArgsConstructor
@Log4j2
public class QnAController {
	
	@GetMapping("/QnAWrite")
	public String posting() {
		
		return "/help/qnaWrite";
	}
	
	
}
