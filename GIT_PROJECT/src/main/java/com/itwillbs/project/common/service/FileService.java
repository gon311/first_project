package com.itwillbs.project.common.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.common.DTO.FileDTO;
import com.itwillbs.project.common.DTO.FileResourceDTO;
import com.itwillbs.project.common.mapper.FileMapper;
import com.itwillbs.project.common.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class FileService {

	@Autowired
	private final FileMapper fileMapper;
	
	// 파일 상세정보 조회 요청
	public FileResourceDTO getFile(Integer fileId) {
		FileDTO fileDTO = fileMapper.selectFile(fileId);
		
		// 조회된 파일 정보에 대한 실제 파일 가져오기
		FileResourceDTO fileResourceDTO = FileUtils.getFileResource(fileDTO);
		
		
		return fileResourceDTO;
	}

}
