import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.admin.dto.CommentDTO;
import com.itwillbs.project.admin.dto.FaqDTO;
import com.itwillbs.project.admin.dto.FreeDTO;
import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.PageInfoDTO;
import com.itwillbs.project.admin.dto.QnaDTO;
import com.itwillbs.project.admin.dto.SearchDTO;
import com.itwillbs.project.admin.service.AdminService;
import com.itwillbs.project.common.dto.FileDTO;

@Controller
@RequestMapping("/admin/contents")
public class AdminContentController {

	@Autowired
	private AdminService adminService;
	
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
		return "admin/contents/notice";
	}
	
	@GetMapping("/noticeWrite")
	public String noticeWrite(Model model) {
		model.addAttribute("pageTitle", "공지사항 작성");
		return "admin/contents/noticeWrite";
	}
	
	@PostMapping("/noticeSave")
	public String noticeSave(NoticeDTO noticeDTO) {
//		System.out.println("데이터 바인딩 결과: " + noticeDTO.toString());
//	    System.out.println("제목 값: " + noticeDTO.getNoticeTitle());
		adminService.insertNotice(noticeDTO);
		return "redirect:/admin/contents/notice";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("noticeId") int noticeId, Model model) {
		NoticeDTO noticeDTO =adminService.getNoticeDetail(noticeId);
		model.addAttribute("noticeDTO", noticeDTO); 
//		System.out.println("데이터 결과값: " + noticeDTO.toString());
//		System.out.println("제목 리턴값: " + noticeDTO);
		return "admin/contents/noticeDetail";
	}
	
	@GetMapping("/noticeDelete")
	public String noticeDelete(@RequestParam("noticeId") int noticeId) {
	    // 삭제 로직 호출
	    adminService.deleteNotice(noticeId);
	    
	    // 삭제 후 다시 공지사항 목록으로 리다이렉트
	    return "redirect:/admin/contents/notice";
	}
//	게시글 수정	
	// 1. 수정 페이지 이동 (기존 데이터 조회)
	@GetMapping("/noticeUpdate")
	public String noticeUpdate(@RequestParam("noticeId") int noticeId, Model model) {
	    NoticeDTO noticeDTO = adminService.getNoticeDetail(noticeId);
	    model.addAttribute("noticeDTO", noticeDTO);
	    return "admin/contents/noticeUpdate";
	}

	// 2. 수정 실행
	@PostMapping("/noticeUpdateSave")
	public String noticeUpdateSave(@ModelAttribute NoticeDTO noticeDTO) {
	    adminService.updateNotice(noticeDTO);
	    // 수정 후 상세 페이지로 다시 이동 (ID 전달)
	    return "redirect:/admin/contents/noticeDetail?noticeId=" + noticeDTO.getNoticeId();
	}
// ==============================================================================
//	== [ 채용 공고 관리 ] ==
//	채용공고목록조회
	@GetMapping("/JobPost")
	public String jobPostList(@RequestParam(value="pageNum", defaultValue="1") int pageNum
			, SearchDTO searchDTO
			, Model model) {
		
		
		int listLimit = 10;
		int pageListLimit = 5; 
		
		int listCount = adminService.getJobPostTotalCount(searchDTO);
		
		int maxPage = (int)Math.ceil((double)listCount/listLimit);
		int startPage = ((pageNum -1 )/ pageListLimit) * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage,startPage, endPage, pageNum);
		
		searchDTO.setOffset((pageNum - 1) * listLimit);
		searchDTO.setLimit(listLimit);
		
		
		List<JobPostDTO> jobPostList = adminService.getJobPostList(searchDTO);
//		System.out.println("postStatus: " + jobPostDTO.getPostStatus());
		
		model.addAttribute("jobPostList", jobPostList);
		model.addAttribute("searchDTO", searchDTO);
		model.addAttribute("pageInfoDTO", pageInfoDTO);
		return "admin/contents/jobPost";
	}
//	채용공고 상세조회
	@GetMapping("/JobPostDetail")
	public String jobPostDetail(@RequestParam("jobId") int jobId, Model model) {
		JobPostDTO jobPostDTO = adminService.getJobPostDetail(jobId);
		model.addAttribute("jobPostDTO", jobPostDTO);
		
		return "admin/contents/jobPostDetail";
	}
	
	@GetMapping("/JobPostDelete")
	public String jobPostDelete(@RequestParam("jobId") int jobId){
		adminService.deleteJobPost(jobId);
		
		return "redirect:/admin/contents/JobPost";
	}
	
//	==============================================================================
//	== [ 자유게시판 관리] ==
	
	@GetMapping("/Board")
	public String boardList(
							@RequestParam(defaultValue="1") Integer pageNum
							, Model model
							, SearchDTO searchDTO) {
		
		int listLimit = 10;
		int pageListLimit = 5; 
		
		int listCount = adminService.getBoardTotalCount(searchDTO);
		
		int maxPage = (int)Math.ceil((double)listCount/listLimit);
		int startPage = ((pageNum -1 )/ pageListLimit) * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage,startPage, endPage, pageNum);
		
		searchDTO.setOffset((pageNum - 1) * listLimit);
		searchDTO.setLimit(listLimit);
		
		List<FreeDTO> boardList = adminService.getBoardList(searchDTO);
		
		
//		System.out.println(freeDTO.getStatus());
		model.addAttribute("boardList", boardList);
		model.addAttribute("searchDTO", searchDTO);
		model.addAttribute("pageInfoDTO", pageInfoDTO);
	
		
		return "admin/contents/board";
	}
	
//	자유게시판 게시글 상세 조회
	@GetMapping("/boardDetail")
	public String boardDetailById(@RequestParam("postId") long postId
								, Model model) {
		FreeDTO freeDTO = adminService.getBoardDetailById(postId);
		
		List<CommentDTO> commentList = adminService.getCommentByPostId(postId);
		
//		System.out.println(freeDTO.toString());
//		System.out.println(freeDTO.getContent());
//		System.out.println(freeDTO.getStatus());
//		System.out.println(commentList.toString());
		model.addAttribute("freeDTO", freeDTO);
		model.addAttribute("commentList", commentList);
		
		return "admin/contents/boardDetail";
	}
// 자유게시판 게시글 삭제
	@GetMapping("/boardDelete")
	public String boardDelete(@RequestParam("postId") long postId) {
		adminService.deleteBoard(postId);
		
		return "redirect:/admin/contents/Board";
	}
	
	
	
//	자유게시판 게시글 댓글 삭제
	@GetMapping("/commentDelete")
	public String commentDelete(@RequestParam("commentId") long commentId
								, @RequestParam("postId") long postId) {
	    // 삭제 로직 호출
	    adminService.deleteComment(commentId);
	    
	    // 삭제 후 다시 공지사항 목록으로 리다이렉트
	    return "redirect:/admin/contents/boardDetail?postId=" + postId;
	}
	
//	==============================================================================
// == [ FAQ 관리 ] ==
	// FAQ 전체 목록 및 카테고리별 출력
	@GetMapping("/FaQ")
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
	    
	    return "admin/contents/faq"; // faq.jsp로 포워딩
	}

	@GetMapping("/FaqWrite")
	public String faqWrite(Model model) {
		
		return "admin/contents/faqWrite";
	}
	
	@PostMapping("/insertFaq")
	public String faqInsert(@ModelAttribute FaqDTO faqDTO) {
//		System.out.println(faqDTO.toString());
		adminService.insertFaq(faqDTO);
//		return "redirect:/admin/contents/faq";
		return "redirect:/admin/contents/FaQ?userType=" + faqDTO.getUserType();
	}
	
	// faq 삭제
	@GetMapping("/faqDelete")
	public String faqDelete(@RequestParam("faqId") int faqId) {
	    adminService.deleteFaq(faqId);
	    return "redirect:/admin/contents/FaQ"; // 삭제 후 다시 목록으로
	}
	
	
	// 1. 수정 폼으로 이동 (기존 데이터 조회)
	@GetMapping("/FaqUpdate")
	public String faqUpdate(@RequestParam("faqId") int faqId, Model model) {
	    // 아코디언 리스트에서 사용하는 DTO를 하나 가져오는 로직 필요
	    SearchDTO  searchDTO = new SearchDTO();
	    searchDTO.setFaqId(faqId);
	    
	    List<FaqDTO> list = adminService.getFaqList(searchDTO);
	    
	    if (list != null && !list.isEmpty()) {
	    	model.addAttribute("faq", list.get(0));
	    }
	    return "admin/contents/faqUpdate";
	}

	// 2. 수정 실행
	@PostMapping("/faqUpdateSave")
	public String faqUpdateSave(@ModelAttribute FaqDTO faqDTO) {
		System.out.println(faqDTO.toString());
		System.out.println(faqDTO.getFaqId());
	    adminService.updateFaq(faqDTO);
	    return "redirect:/admin/contents/FaQ?userType=" + faqDTO.getUserType();
	}
//	===============================================================================
//	== [ 1:1 문의글 관리 ] ==
	@GetMapping("/QnA")
	public String qnaList(@RequestParam(value="reStatus", defaultValue="all") String reStatus, 
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="sort", defaultValue="all") String sort,
			Model model,
			SearchDTO searchDTO) {
	    
		
		int listLimit = 10;
		int pageListLimit = 5; 
		
		int listCount = adminService.getQnaTotalCount(searchDTO);
		
		int maxPage = (int)Math.ceil((double)listCount/listLimit);
		int startPage = ((pageNum -1 )/ pageListLimit) * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage,startPage, endPage, pageNum);
		
		searchDTO.setOffset((pageNum - 1) * listLimit);
		searchDTO.setLimit(listLimit);
		
		List<QnaDTO> qnaList = adminService.getQnaList(searchDTO);
//		System.out.println("정렬 확인 : " +sort.toString());
	    model.addAttribute("qnaList", qnaList);
	    model.addAttribute("reStatus", reStatus); // 현재 탭 활성화를 위해 전달
	    model.addAttribute("sort", sort);
	    model.addAttribute("searchDTO", searchDTO);
	    model.addAttribute("pageInfoDTO", pageInfoDTO);
	    
	    
	return "admin/contents/qna";
	}
//	1:1 문의글 상세 조회
	@GetMapping("/QnADetail")
	public String qnaDetail(@RequestParam("qnaId") int qnaId
							, Model model) {
		QnaDTO qnaDTO = adminService.getQnADetail(qnaId);
		
		model.addAttribute("qnaDTO", qnaDTO);
		return "admin/contents/qnaDetail";
	}
	
	// 1:1문의글 답변 등록
	@PostMapping("/qnaAnswerSave")
	public String qnaAnswerSave(QnaDTO qnaDTO) {
	    adminService.registAnswer(qnaDTO);
	    
	    return "redirect:/admin/contents/QnADetail?qnaId=" + qnaDTO.getQnaId();
	}
//	1:1 문의글 답변 수정
	@PostMapping("/qnaAnswerUpdate")
	public String qnaAnswerUpdate(QnaDTO qnaDTO) {
		adminService.modifyAnswer(qnaDTO);
		return "redirect:/admin/contents/QnADetail?qnaId="+ qnaDTO.getQnaId();
	}
	
//	1:1 문의글 답변 삭제
	@GetMapping("/qnaAnswerDelete")
	public String qnaAnswerDelete(@RequestParam("qnaId") int qnaId) {
		adminService.deleteQnaAnswer(qnaId);
		return "redirect:/admin/contents/QnADetail?qnaId=" + qnaId;
	}
	
	
//	1:1 문의글 삭제 
	@GetMapping("/QnaDelete")
	public String QnaDelete(@RequestParam("qnaId") int qnaId) {
		adminService.deleteQna(qnaId);
		return "redirect:/admin/contents/QnA";
	}
//	===================================================================================

}

