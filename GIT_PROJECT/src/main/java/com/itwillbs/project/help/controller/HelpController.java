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
public class HelpController {
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/helpWord")
	public String posting() {
		
		return "/help/help_word";
	}
	
	@GetMapping("/notice")
	public String noticeList(@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			SearchDTO searchDTO,
			Model model) {
		
		int listLimit = 10;
		int pageListLimit = 5; 
		
		int listCount = adminService.getNoitceTotalCount(searchDTO);
		
		int maxPage = (int)Math.ceil((double)listCount/listLimit);
		int startPage = ((pageNum -1 )/ pageListLimit) * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage,startPage, endPage, pageNum);
		
		searchDTO.setOffset((pageNum - 1) * listLimit);
		searchDTO.setLimit(listLimit);
		
		List<NoticeDTO> noticeList = adminService.getNoticeList(searchDTO);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("searchDTO", searchDTO); 
		model.addAttribute("pageInfoDTO", pageInfoDTO); 
		
		return "/help/notice";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("noticeId") int noticeId, Model model) {
		NoticeDTO noticeDTO = adminService.getNoticeDetail(noticeId);
		model.addAttribute("noticeDTO", noticeDTO); 
		return "help/noticeDetail";
	}
	
}
