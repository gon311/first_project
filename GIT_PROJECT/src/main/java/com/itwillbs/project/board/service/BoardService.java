package com.itwillbs.project.board.service;


import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project.board.dto.BoardDTO;
import com.itwillbs.project.board.mapper.BoardMapper;
import com.itwillbs.project.common.DTO.FileDTO;
import com.itwillbs.project.common.DTO.FileResourceDTO;
import com.itwillbs.project.common.mapper.FileMapper;
import com.itwillbs.project.common.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class BoardService {

	@Autowired
	private final BoardMapper boardMapper;
	private final FileMapper fileMapper;

	
	// 게시물 등록 작업
	public void registBoard(BoardDTO boardDTO, List<MultipartFile> files) throws IOException {
		// 게시글 등록 요청 
		boardMapper.insertBoard(boardDTO);
		

		// 파일 업로드 요청
		List<FileDTO> fileList = FileUtils.uploadBoardFile(files);
		
		// 파일 목록 List 객체가 비어있지 않을 경우 파일 정보 DB 등록 요청
		if(!fileList.isEmpty()) {
			fileMapper.insertFiles(fileList, boardDTO.getPostId(), "FREE");
		}
	}
	
	// 게시물 상세정보 조회
	
	// 게시물 목록 조회

}
