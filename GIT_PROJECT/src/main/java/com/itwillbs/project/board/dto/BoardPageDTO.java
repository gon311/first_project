package com.itwillbs.project.board.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

//페이징 처리된 게시물 목록 저장에 사용되는 클래스

@Getter
//@Setter
@ToString
//@NoArgsConstructor
@AllArgsConstructor
public class BoardPageDTO {
	private List<BoardDTO> boardList;
	private PageInfoDTO pageInfoDTO; 
}
