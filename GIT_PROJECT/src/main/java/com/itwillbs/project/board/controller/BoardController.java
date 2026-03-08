package com.itwillbs.project.board.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.project.board.dto.BoardDTO;
import com.itwillbs.project.common.exception.LoginRequiredException;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequestMapping("/board")
@Log4j2
@RequiredArgsConstructor
public class BoardController {
	
	@GetMapping({"", "/"})
	public String board() {

		return "/board/board_list";
	}
	
	@GetMapping("/detail")
	public String boardDetail() {
		
		return "/board/board_detail";
	}
	
	@GetMapping("/write")
	public String boardWrite(HttpSession session) {
		String sId = (String)session.getAttribute("sId");
		
		// 미로그인 시 LoginRequiredException 예외 발생시키기 => GlobalExceptionHandler 에서 공통 처리
		if(sId == null) {
			// throw 키워드를 사용하여 LoginRequiredException 예외를 강제로 발생시키기
			throw new LoginRequiredException("로그인이 필요한 서비스입니다.\\n로그인 페이지로 이동합니다.");
		}
		
		return "/board/board_write";
	}
	
//	@PostMapping("/write")
//	public String boardWrite(BoardDTO boardDTO, 
//							  )

}
