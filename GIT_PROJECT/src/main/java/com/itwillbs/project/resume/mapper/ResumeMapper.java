package com.itwillbs.project.resume.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.resume.dto.ResumeDTO;

@Mapper
public interface ResumeMapper {

	// 이력서 저장.(저장 후 resume_Id 리턴)
	int insertResume(ResumeDTO resumeDTO);

	// 선택(작성)한 이력서(상세정보) 불러오기.
	ResumeDTO selectResume(Integer resumeId);

	// 이력서 업데이트. 
	int updateResume(ResumeDTO resumeDTO);

}
