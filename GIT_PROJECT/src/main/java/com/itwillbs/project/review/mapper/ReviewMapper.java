package com.itwillbs.project.review.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.review.dto.CoverLetterDTO;

@Mapper
public interface ReviewMapper {
	
	// 1단계 form 저장
	void insertForm(CoverLetterDTO coverLetterDTO);
	
	// 1단계 form 업데이트(임시저장 한 후 저장 경우)
	void updateForm(CoverLetterDTO coverLetterDTO);
	
	// 2단계 제목 및 생성된 자소서 저장 
	void updateContent(CoverLetterDTO coverLetterDTO);
	
	void deleteData(Long coverLetterIdx);

	// 마이페이지 자소서 수정에 필요한 정보 요청
	CoverLetterDTO selectCoverLetter(Long coverLetterIdx);



 
}
