package com.itwillbs.project.resume.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.resume.dto.ResumeDTO;

@Mapper
public interface ResumeMapper {

	// 이력서 저장.
	void insertResume(ResumeDTO resumeDTO);

}
