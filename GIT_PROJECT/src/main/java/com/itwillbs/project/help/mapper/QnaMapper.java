package com.itwillbs.project.help.mapper;

import com.itwillbs.project.help.dto.SupportQnaDTO;
import com.itwillbs.project.common.dto.FileDTO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaMapper {
    // 1. 문의글 저장 (SupportQnaDTO 사용)
    void insertQna(SupportQnaDTO qna);

    // 2. 파일 정보 저장
    void insertFile(FileDTO fileDto);
    
 // 특정 사용자의 QNA 리스트 가져오기
    List<SupportQnaDTO> selectQnaList(Long writerId);

	SupportQnaDTO selectQnaDetail(int qnaId);
	
	void deleteQna(int qnaId);
}