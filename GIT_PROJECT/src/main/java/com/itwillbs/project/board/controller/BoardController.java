package com.itwillbs.project.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.board.dto.BoardDTO;
import com.itwillbs.project.board.service.BoardService;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.exception.LoginRequiredException;
import com.itwillbs.project.common.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board")
@Log4j2
@RequiredArgsConstructor
public class BoardController {

	@Autowired
	private BoardService boardService;

	@GetMapping({"", "/"})
	public String board() {
		return "/board/board_list";
	}

	@GetMapping("/detail")
	public String boardDetail() {
		return "/board/board_detail";
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

	// 게시물 상세정보 조회
	// @GetMapping("/detail")

	// 게시물 목록 조회
	// @GetMapping("/list")
}