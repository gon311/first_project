package com.itwillbs.project.resume.services;

import org.springframework.stereotype.Service;

import com.itwillbs.project.resume.dto.ResumeDTO;
import com.itwillbs.project.resume.mapper.ResumeMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class ResumeService {

	private final ResumeMapper resumeMapper;
	
	public void registResume(ResumeDTO resumeDTO) {
		resumeMapper.insertResume(resumeDTO);		
	}

}
