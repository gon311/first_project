package com.itwillbs.project.common.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.itwillbs.project.common.dto.FileResourceDTO;
import com.itwillbs.project.common.service.FileService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class FileController {
	@Autowired
	private FileService fileService;
	
	@GetMapping("/file/{fileId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable("fileId") Integer fileId) {
		log.info(">>>>>>>>>>>> fileId : " + fileId);
		
		// 파일 정보 조회 요청 
		FileResourceDTO fileResourceDTO = fileService.getFile(fileId);
		
		return ResponseEntity.ok()
				.contentType(fileResourceDTO.getContentType())
				.header(HttpHeaders.CONTENT_DISPOSITION, fileResourceDTO.getContentDisposition().toString())
				.body(fileResourceDTO.getResource()); //resource 객체 리턴 
	}
}
