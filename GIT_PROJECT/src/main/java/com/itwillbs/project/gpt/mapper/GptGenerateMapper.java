package com.itwillbs.project.gpt.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.gpt.dto.GptGenerateDTO;
import com.itwillbs.project.gpt.dto.PassCheckDTO;

@Mapper
public interface GptGenerateMapper {

	GptGenerateDTO selectPromptData(Long coverLetterIdx);

	PassCheckDTO selectCount(Long userId);

	void updatePersonPass(Long userId);

	void updateProductRemain(Long userId);

	void updateStatusToExpired(Long userId);

}
