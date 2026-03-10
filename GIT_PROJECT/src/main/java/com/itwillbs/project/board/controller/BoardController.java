package com.itwillbs.project.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequestMapping("/board")
@Log4j2
@RequiredArgsConstructor
public class BoardController {
	
	@GetMapping({"", "/"})
	public String board() {

		return "/board/board";
	}
	
	@GetMapping("/detail")
	public String boardDetail() {
		
		return "/board/board_detail";
	}
	
	@GetMapping("/write")
	public String boardWrite() {
		return "/board/board_write";
	}

}
