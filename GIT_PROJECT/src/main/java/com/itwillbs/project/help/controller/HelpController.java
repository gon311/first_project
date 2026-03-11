package com.itwillbs.project.help.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.help.dto.FaqDTO;
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
	
	@GetMapping("/helpWord")
	public String posting() {
		
		return "/help/help_word";
	}
	
	@GetMapping("/notice")
	public String noticeList(
			@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			NoticeDTO noticeDTO,
			Model model) {
		
		searchKeyword = searchKeyword.trim();
//		NoticePageDTO noticePageDTO = helpService.getNoticeList(page, searchType, searchKeyword);
//		model.addAttribute("noticeList", noticePageDTO.getNoticeList());
//		model.addAttribute("pageInfoDTO", noticePageDTO.getPageInfoDTO());
		
		List<NoticeDTO> list = helpService.getNoticeList(noticeDTO);
		model.addAttribute("noticeList", list);
		model.addAttribute("noticeDTO", noticeDTO); 
		
		return "/help/notice";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("noticeId") int noticeId, Model model) {
		NoticeDTO noticeDTO = helpService.getNoticeDetail(noticeId);
		model.addAttribute("noticeDTO", noticeDTO); 
		System.out.println("데이터 결과값: " + noticeDTO.toString());
		return "help/noticeDetail";
	}
	
	// FAQ 전체 목록 및 카테고리별 출력
	@GetMapping("/FaQ")
	public String faqList(@RequestParam(value="userType", defaultValue="all") String userType
						, @RequestParam(value="category", defaultValue="") String category
						,FaqDTO faqDTO
						, Model model) {
		
		
	    
	    // 서비스 호출 (카테고리, 키워드 포함)
	    List<FaqDTO> faqList = helpService.getFaqList(faqDTO);
//	    System.out.println(faqList);
	    System.out.println(category.toString());
	    
	    model.addAttribute("faqList", faqList);
	    model.addAttribute("userType", userType); // 탭 활성화 유지용
	    model.addAttribute("keyword", faqDTO.getKeyword());   // 검색어 유지용
	    model.addAttribute("category", category); // 카테고리 유지용
	    
	    return "help/faq"; // faq.jsp로 포워딩
	}
	
}
