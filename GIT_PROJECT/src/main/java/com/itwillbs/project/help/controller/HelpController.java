package com.itwillbs.project.help.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.admin.service.AdminService;
import com.itwillbs.project.help.dto.NoticeDTO;
import com.itwillbs.project.help.service.HelpService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/help")
@RequiredArgsConstructor
@Log4j2
public class HelpController {
	@Autowired
	private HelpService helpService;
	private AdminService adminService;
	
	@GetMapping("/helpWord")
	public String posting() {
		
		return "/help/help_word";
	}
	
	@GetMapping("/notice")
	public String noticeList(@RequestParam(value="page", defaultValue="1") int page,
			NoticeDTO noticeDTO,
			Model model) {
		
		List<NoticeDTO> list = helpService.getNoticeList(noticeDTO);
		model.addAttribute("noticeList", list);
		model.addAttribute("noticeDTO", noticeDTO); 
		
		return "/help/notice";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("noticeId") int noticeId, Model model) {
		com.itwillbs.project.admin.dto.NoticeDTO noticeDTO = adminService.getNoticeDetail(noticeId);
		model.addAttribute("noticeDTO", noticeDTO); 
		System.out.println("데이터 결과값: " + noticeDTO.toString());
		return "help/noticeDetail";
	}
	
}
