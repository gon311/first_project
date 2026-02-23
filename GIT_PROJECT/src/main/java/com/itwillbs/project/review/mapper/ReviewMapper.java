package com.itwillbs.project.review.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.review.dto.CoverLetterDTO;

@Mapper
public interface ReviewMapper {

	void insertForm(CoverLetterDTO coverLetterDTO);

 
}
