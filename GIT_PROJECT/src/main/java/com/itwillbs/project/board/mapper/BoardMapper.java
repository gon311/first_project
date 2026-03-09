package com.itwillbs.project.board.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.board.dto.BoardDTO;

@Mapper
public interface BoardMapper {

	void insertBoard(BoardDTO boardDTO);
	
	// 게시물 상세
	BoardDTO selectBoard(Long postId);

	void updateReadcount(Long postId);



}
