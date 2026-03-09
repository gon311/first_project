package com.itwillbs.project.common.service;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.dto.FileResourceDTO;
import com.itwillbs.project.common.mapper.FileMapper;
import com.itwillbs.project.common.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class FileService {
	private final FileMapper fileMapper;

	// 파일 상세정보 조회 요청
	public FileResourceDTO getFile(Integer fileId, HttpSession session) {
		FileDTO fileDTO = fileMapper.selectFile(fileId);
//		String sId = "/" + session.getAttribute("userIdx");
		// -----------------------------------------------------------------
		// FileUtils - getFileResource() 메서드 호출하여 조회된 파일 정보에 대한 실제 파일 가져오기
		// => 파라미터 : FileDTO 객체   리턴타입 : FileResourceDTO(fileResourceDTO)
		FileResourceDTO fileResourceDTO = FileUtils.getFileResource(fileDTO);
		log.info(">>>>>> fileResourceDTO : " + fileResourceDTO);
		
		return fileResourceDTO;
	}
	
	
}



















