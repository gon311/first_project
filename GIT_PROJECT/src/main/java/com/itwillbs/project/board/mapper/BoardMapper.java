package com.itwillbs.project.board.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.board.dto.BoardDTO;

@Mapper
public interface BoardMapper {

	void insertBoard(BoardDTO boardDTO);



}
