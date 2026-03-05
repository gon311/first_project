package com.itwillbs.project.resume.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.resume.dto.ResumeDTO;
import com.itwillbs.project.resume.mapper.ResumeMapper;

@Service
public class ResumeService {

	@Autowired
	private ResumeMapper resumeMapper;
	
	// 이력서 저장 요청.
	public int registResume(ResumeDTO resumeDTO) {
		resumeMapper.insertResume(resumeDTO);
		
		return resumeDTO.getResumeId();	// pk 반환.
	}

	// 이력서 저장 후 상세정보.
	public ResumeDTO getResumeInfo(Integer resumeId) {
		// 
		return resumeMapper.selectResume(resumeId);
	}

	public int modifyResume(ResumeDTO resumeDTO) {
		// 
		return resumeMapper.updateResume(resumeDTO);
	}

}
