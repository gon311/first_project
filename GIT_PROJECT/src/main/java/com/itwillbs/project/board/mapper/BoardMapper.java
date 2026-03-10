package com.itwillbs.project.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.board.dto.BoardCond;
import com.itwillbs.project.board.dto.BoardDTO;
import com.itwillbs.project.common.dto.FileDTO;

@Mapper
public interface BoardMapper {

	void insertBoard(BoardDTO boardDTO);
	
	// 게시물 상세
	BoardDTO selectBoard(Long postId);
	void updateReadcount(Long postId);
	List<FileDTO> selectBoardFiles(Long postId);
	FileDTO selectFileById(Integer fileId);
	
	int updateBoard(BoardDTO boardDTO);
	int deleteBoard(Long postId);
	
	
	// 게시물 리스트
	List<BoardDTO> selectBoardList(BoardCond cond);
	int selectBoardCount(BoardCond cond);


}
