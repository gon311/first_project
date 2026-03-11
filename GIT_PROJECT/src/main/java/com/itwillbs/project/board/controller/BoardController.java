package com.itwillbs.project.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.board.dto.BoardCommentDTO;
import com.itwillbs.project.board.dto.BoardCond;
import com.itwillbs.project.board.dto.BoardDTO;
import com.itwillbs.project.board.service.BoardCommentService;
import com.itwillbs.project.board.service.BoardService;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.dto.FileResourceDTO;
import com.itwillbs.project.common.exception.LoginRequiredException;
import com.itwillbs.project.common.paging.PageRes;
import com.itwillbs.project.common.util.FileUtils;
import com.itwillbs.project.my.dto.MyDTO;
import com.itwillbs.project.my.service.MyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board")
@Log4j2
@RequiredArgsConstructor
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MyService myService;
	
	@Autowired
	private BoardCommentService boardCommentService;
	
	
	// 게시글 목록 조회
	@GetMapping("")
	public String board(
	        Model model,
	        @RequestParam(required = false) String q,
	        @RequestParam(defaultValue = "ALL") String category,
	        @RequestParam(defaultValue = "latest") String sort,
	        @RequestParam(defaultValue = "1") int page,
	        @RequestParam(defaultValue = "5") int size,
	        @RequestParam(defaultValue = "all") String searchType
	) {

	    BoardCond cond = new BoardCond();

	    cond.setCategory(category);
	    cond.setQ(q);
	    cond.setSort(sort);
	    cond.setSearchType(searchType);

	    cond.getPage().setPage(page);
	    cond.getPage().setSize(size);

	    List<BoardDTO> posts = boardService.getBoardList(cond);
	    int total = boardService.getBoardCount(cond);

	    PageRes pager = PageRes.of(cond.getPage(), total);

	    model.addAttribute("posts", posts);
	    model.addAttribute("pager", pager);

	    model.addAttribute("q", q);
	    model.addAttribute("category", category);
	    model.addAttribute("sort", sort);
	    model.addAttribute("searchType", searchType);

	    return "/board/board";
	}
	
	

	// 게시글 작성 페이지
	@GetMapping("/write")
	public String boardWrite(HttpSession session) {
		String sId = (String) session.getAttribute("sId");

		if (sId == null) {
			throw new LoginRequiredException("로그인이 필요한 서비스입니다.\\n로그인 페이지로 이동합니다.");
		}

		return "/board/board_write";
	}

	// 게시글 등록 처리
	@PostMapping("/write")
	public String boardWrite(BoardDTO boardDTO,
							 List<MultipartFile> files,
							 HttpServletRequest request,
							 HttpSession session,
							 Model model,
							 RedirectAttributes ra) throws IOException {

		Long userIdx = (Long) session.getAttribute("userIdx");

		if (userIdx == null) {
			throw new LoginRequiredException("로그인이 필요한 서비스입니다.\\n로그인 페이지로 이동합니다.");
		}

		boardDTO.setAuthorMemberId(userIdx);

		boardService.registBoard(boardDTO, files);

		// 등록 후 상세 페이지로 이동할 게시글 번호 전달
		ra.addAttribute("postId", boardDTO.getPostId());

		return "redirect:/board/detail";
	}
	
	// 게시글 상세
	@GetMapping("/detail")
	public String boardDetail(@RequestParam Long postId,
	                          HttpSession session,
	                          Model model) {

	    boardService.increaseReadcount(postId);

	    BoardDTO post = boardService.getBoard(postId);
	    List<FileDTO> fileList = boardService.getBoardFiles(postId);

	    boolean isOwner = false;
	    Long loginUserId = null;

	    String sId = (String) session.getAttribute("sId");
	    if (sId != null) {
	        MyDTO user = myService.getUser(sId);

	        if (user != null) {
	            loginUserId = user.getUserId();
	            model.addAttribute("loginUser", user);

	            if (user.getUserId().equals(post.getAuthorMemberId())) {
	                isOwner = true;
	            }
	        }
	    }

	    List<BoardCommentDTO> comments = boardCommentService.getCommentList(postId, loginUserId);

	    model.addAttribute("post", post);
	    model.addAttribute("fileList", fileList);
	    model.addAttribute("comments", comments);
	    model.addAttribute("isOwner", isOwner);

	    return "/board/board_detail";
	}
	
	// 다운로드
	@GetMapping("/download")
	public ResponseEntity<Resource> downloadFile(@RequestParam Integer fileId) {
	    FileDTO fileDTO = boardService.getFileById(fileId);

	    if (fileDTO == null) {
	        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "파일 정보가 없습니다.");
	    }

	    FileResourceDTO fileResourceDTO = FileUtils.getFileResource(fileDTO);
	    Resource resource = fileResourceDTO.getResource();

	    return ResponseEntity.ok()
	            .contentType(MediaType.APPLICATION_OCTET_STREAM)
	            .header(HttpHeaders.CONTENT_DISPOSITION, fileResourceDTO.getContentDisposition().toString())
	            .body(resource);
	}
	
	// 수정
	@GetMapping("/edit")
	public String editForm(@RequestParam Long postId,
	                       HttpSession session,
	                       Model model,
	                       RedirectAttributes ra) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    MyDTO user = myService.getUser(sId);
	    BoardDTO post = boardService.getBoard(postId);

	    if (post == null || !user.getUserId().equals(post.getAuthorMemberId())) {
	        ra.addFlashAttribute("msg", "본인이 작성한 글만 수정할 수 있습니다.");
	        return "redirect:/board/detail?postId=" + postId;
	    }

	    List<FileDTO> fileList = boardService.getBoardFiles(postId);

	    model.addAttribute("post", post);
	    model.addAttribute("fileList", fileList);

	    return "/board/board_edit";
	}
	
	@PostMapping("/edit")
	public String editBoard(BoardDTO boardDTO,
	                        @RequestParam(value = "deleteFileIds", required = false) List<Integer> deleteFileIds,
	                        List<MultipartFile> files,
	                        HttpSession session,
	                        RedirectAttributes ra) throws IOException {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    MyDTO user = myService.getUser(sId);

	    boolean result = boardService.updateBoard(boardDTO, deleteFileIds, files, user.getUserId());

	    if (!result) {
	        ra.addFlashAttribute("msg", "본인이 작성한 글만 수정할 수 있습니다.");
	        return "redirect:/board/detail?postId=" + boardDTO.getPostId();
	    }

	    ra.addFlashAttribute("msg", "게시글이 수정되었습니다.");
	    return "redirect:/board/detail?postId=" + boardDTO.getPostId();
	}
	
	@PostMapping("/delete")
	public String deleteBoard(@RequestParam Long postId,
	                          HttpSession session,
	                          RedirectAttributes ra) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    MyDTO user = myService.getUser(sId);

	    boolean result = boardService.deleteBoard(postId, user.getUserId());

	    if (!result) {
	        ra.addFlashAttribute("msg", "본인이 작성한 글만 삭제할 수 있습니다.");
	        return "redirect:/board/detail?postId=" + postId;
	    }

	    ra.addFlashAttribute("msg", "게시글이 삭제되었습니다.");

	    return "redirect:/board";
	}
	

	
	
	
	
}