package com.itwillbs.project.resume.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.resume.dto.ResumeDTO;

@Mapper
public interface ResumeMapper {

	void insertResume(ResumeDTO resumeDTO);
}
