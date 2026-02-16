package com.itwillbs.project.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/contents")
public class AdminContentController {

	@GetMapping("/notice")
	public String noticeList(Model model) {
		model.addAttribute("pageTitle", "공지사항 관리");
		
		//DB에서 공지사항 리스트 로직 가져오는 로직 추가 필요.
		return "admin/contents/notice";
	}
	
	@GetMapping("/JobPost")
	public String jobPostList() {
		
		return "admin/contents/jobPost";
	}
	@GetMapping("/Board")
	public String boardList() {
		
		return "admin/contents/board";
	}
	@GetMapping("/FnQ")
	public String fnqList() {
		
		return "admin/contents/fnq";
	}
	@GetMapping("/QnA")
	public String qnaList() {
		
		return "admin/contents/qna";
	}
	
}
