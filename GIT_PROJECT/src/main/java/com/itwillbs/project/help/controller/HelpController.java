package com.itwillbs.project.help.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.admin.dto.FaqDTO;
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
	public String posting(@RequestParam(value="userType", defaultValue="all") String userType
						, @RequestParam(value="category", defaultValue="") String category
						, @RequestParam(defaultValue="1") Integer pageNum
						, FaqDTO faqDTO
						, SearchDTO searchDTO
						, Model model) {
		
		int listLimit = 5;
		int pageListLimit = 5; 
		
		int listCount = adminService.getFaqTotalCount(searchDTO);
		
		int maxPage = (int)Math.ceil((double)listCount/listLimit);
		int startPage = ((pageNum -1 )/ pageListLimit) * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage,startPage, endPage, pageNum);
		
		searchDTO.setOffset((pageNum - 1) * listLimit);
		searchDTO.setLimit(listLimit);
	    
	    // 서비스 호출 (카테고리, 키워드 포함)
	    List<FaqDTO> faqList = adminService.getFaqList(searchDTO);
//	    System.out.println(faqList);
//	    System.out.println(category.toString());
	    
//	    faqDTO.getKeyword().trim();
	    
	    model.addAttribute("faqList", faqList);
	    model.addAttribute("userType", userType); // 탭 활성화 유지용
	    model.addAttribute("keyword", faqDTO.getKeyword());   // 검색어 유지용
	    model.addAttribute("category", category); // 카테고리 유지용
	    model.addAttribute("searchDTO", searchDTO);
	    model.addAttribute("pageInfoDTO", pageInfoDTO);
		
		return "/help/help_word";
	}
	
	@PostMapping("/helpWord")
	public String helpWord(@RequestParam(value="userType", defaultValue="all") String userType
			, @RequestParam(value="category", defaultValue="") String category
			, @RequestParam(defaultValue="1") Integer pageNum
			, FaqDTO faqDTO
			, SearchDTO searchDTO
			, Model model) {
		
		int listLimit = 5;
		int pageListLimit = 5; 
		
		int listCount = adminService.getFaqTotalCount(searchDTO);
		
		int maxPage = (int)Math.ceil((double)listCount/listLimit);
		int startPage = ((pageNum -1 )/ pageListLimit) * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage,startPage, endPage, pageNum);
		
		searchDTO.setOffset((pageNum - 1) * listLimit);
		searchDTO.setLimit(listLimit);
		
		// 서비스 호출 (카테고리, 키워드 포함)
		List<FaqDTO> faqList = adminService.getFaqList(searchDTO);
//	    System.out.println(faqList);
//	    System.out.println(category.toString());
		
//	    faqDTO.getKeyword().trim();
		
		model.addAttribute("faqList", faqList);
		model.addAttribute("userType", userType); // 탭 활성화 유지용
		model.addAttribute("keyword", faqDTO.getKeyword());   // 검색어 유지용
		model.addAttribute("category", category); // 카테고리 유지용
		model.addAttribute("searchDTO", searchDTO);
		model.addAttribute("pageInfoDTO", pageInfoDTO);
		
		return "/help/help_word?userType=" + userType + "&category=" + category;
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
		
		
		
		//DB에서 공지사항 리스트 로직 가져오는 로직 추가 필요.
		return "help/notice";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("noticeId") int noticeId, Model model) {
		NoticeDTO noticeDTO = adminService.getNoticeDetail(noticeId);
		model.addAttribute("noticeDTO", noticeDTO); 
		return "help/noticeDetail";
	}
	
//	==============================================================================
// == [ FAQ 관리 ] ==
	// FAQ 전체 목록 및 카테고리별 출력
	@GetMapping("/faq")
	public String faqList(@RequestParam(value="userType", defaultValue="all") String userType
						, @RequestParam(value="category", defaultValue="") String category
						, @RequestParam(defaultValue="1") Integer pageNum
						,FaqDTO faqDTO
						, SearchDTO searchDTO
						, Model model) {
		
		int listLimit = 10;
		int pageListLimit = 5; 
		
		int listCount = adminService.getFaqTotalCount(searchDTO);
		
		int maxPage = (int)Math.ceil((double)listCount/listLimit);
		int startPage = ((pageNum -1 )/ pageListLimit) * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage,startPage, endPage, pageNum);
		
		searchDTO.setOffset((pageNum - 1) * listLimit);
		searchDTO.setLimit(listLimit);
	    
	    // 서비스 호출 (카테고리, 키워드 포함)
	    List<FaqDTO> faqList = adminService.getFaqList(searchDTO);
//	    System.out.println(faqList);
//	    System.out.println(category.toString());
	    
//	    faqDTO.getKeyword().trim();
	    
	    model.addAttribute("faqList", faqList);
	    model.addAttribute("userType", userType); // 탭 활성화 유지용
	    model.addAttribute("keyword", faqDTO.getKeyword());   // 검색어 유지용
	    model.addAttribute("category", category); // 카테고리 유지용
	    model.addAttribute("searchDTO", searchDTO);
	    model.addAttribute("pageInfoDTO", pageInfoDTO);
	    
	    return "help/faq"; // faq.jsp로 포워딩
	}
	
}
