package com.itwillbs.project.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.service.AdminService;

@Controller
@RequestMapping("/admin/contents")
public class AdminContentController {

	@Autowired
	private AdminService adminService;
	
	@GetMapping("/notice")
	public String noticeList(@RequestParam(value="page", defaultValue="1") int page,
			NoticeDTO noticeDTO,
			Model model) {
		
		List<NoticeDTO> list = adminService.getNoticeList(noticeDTO);
		model.addAttribute("noticeList", list);
		model.addAttribute("noticeDTO", noticeDTO); //검색 조건 유지용?
//		List<NoticeDTO> list = noticeService.getNoticeList(page, searchType, keyword)
		// 서비스 단 페이징과 검색 조건 처리 필요 
		//DB에서 공지사항 리스트 로직 가져오는 로직 추가 필요.
		return "admin/contents/notice";
	}
	
	@GetMapping("/noticeWrite")
	public String noticeWrite(Model model) {
		model.addAttribute("pageTitle", "공지사항 작성");
		return "admin/contents/noticeWrite";
	}
	
	@PostMapping("/noticeSave")
	public String noticeSave(@ModelAttribute NoticeDTO noticeDTO) {
//		System.out.println("데이터 바인딩 결과: " + noticeDTO.toString());
//	    System.out.println("제목 값: " + noticeDTO.getNotice_title());
		adminService.insertNotice(noticeDTO);
		return "redirect:/admin/contents/notice";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("notice_id") int notice_id, Model model) {
		NoticeDTO noticeDTO =adminService.getNoticeDetail(notice_id);
		model.addAttribute("noticeDTO", noticeDTO); 
//		System.out.println("데이터 결과값: " + noticeDTO.toString());
//		System.out.println("제목 리턴값: " + noticeDTO);
		
		return "admin/contents/noticeDetail";
	}
// ==============================================================================
//	채용공고목록조회
	@GetMapping("/JobPost")
	public String jobPostList(@RequestParam(value="page", defaultValue="1") int page,
			JobPostDTO jobPostDTO
			, Model model) {
		
		List<JobPostDTO> list = adminService.getJobPostList(jobPostDTO);
		model.addAttribute("jobPostList", list);
		model.addAttribute("jobPostDTO", jobPostDTO);
		return "admin/contents/jobPost";
	}
	
	@GetMapping("/JobPostDetail")
	public String jobPostDetail(@RequestParam("jobPost_id") int jobPost_id, Model model) {
		JobPostDTO jobPostDTO = adminService.getJobPostDetail(jobPost_id);
		model.addAttribute("jobPostDTO", jobPostDTO);
		
		return "admin/contents/jobPostDetail";
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
