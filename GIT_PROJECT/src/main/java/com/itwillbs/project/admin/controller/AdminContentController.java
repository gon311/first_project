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

import com.itwillbs.project.admin.dto.FaqDTO;
import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.QnaDTO;
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
	public String jobPostDetail(@RequestParam("job_id") int job_id, Model model) {
		JobPostDTO jobPostDTO = adminService.getJobPostDetail(job_id);
		model.addAttribute("jobPostDTO", jobPostDTO);
		
		return "admin/contents/jobPostDetail";
	}
	
//	==============================================================================
	
	
	@GetMapping("/Board")
	public String boardList() {
		
		return "admin/contents/board";
	}
//	==============================================================================

	// FAQ 전체 목록 및 카테고리별 출력
	@GetMapping("/FaQ")
	public String faqList(
	        @RequestParam(value="category", defaultValue="individual") String category,
	        @RequestParam(value="keyword", required=false) String keyword,
	        Model model
	        , FaqDTO faqDTO) {
	    
	    // 서비스 호출 (카테고리, 키워드 포함)
	    List<FaqDTO> faqList = adminService.getFaqList(category, keyword, faqDTO);
	    
	    model.addAttribute("faqList", faqList);
	    model.addAttribute("category", category); // 탭 활성화 유지용
	    model.addAttribute("keyword", keyword);   // 검색어 유지용
	    
	    return "admin/faq"; // faq.jsp로 포워딩
	}

	// 특정 게시글 상세 내용 확인
	@GetMapping("/admin/faqMgmt")
	public String faqDetail(@RequestParam("faqId") int faqId, Model model) {
	    
	    FaqDTO faq = adminService.getFaqDetail(faqId);
	    model.addAttribute("faq", faq);
	    
	    return "admin/faqMgmt"; // faqMgmt.jsp(상세페이지)로 포워딩
	}
	
//	===============================================================================
//	1:1 문의글 관리
	@GetMapping("/QnA")
	public String qnaList(@RequestParam(value="reStatus", defaultValue="all") String reStatus, 
			@RequestParam(value="page", defaultValue="1") int page,
			Model model, QnaDTO qnaDTO) {
	    List<QnaDTO> list;
	    
	    if("all".equals(reStatus)) {
	        list = adminService.getQnaList(qnaDTO);
	    } else {
	        list = adminService.getListByStatus(reStatus); // "pending" 또는 "completed"
	    }
	    
	    model.addAttribute("qnaList", list);
	    model.addAttribute("reStatus", reStatus); // 현재 탭 활성화를 위해 전달
	return "admin/contents/qna";
	}
	
		
	
}
