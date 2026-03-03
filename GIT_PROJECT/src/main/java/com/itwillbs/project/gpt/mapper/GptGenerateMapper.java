package com.itwillbs.project.gpt.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.gpt.dto.GptGenerateDTO;

@Mapper
public interface GptGenerateMapper {

	GptGenerateDTO selectPromptData(Long coverLetterIdx);

}
