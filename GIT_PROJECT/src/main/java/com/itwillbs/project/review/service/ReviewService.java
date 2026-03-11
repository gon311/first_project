package com.itwillbs.project.review.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.review.dto.CoverLetterDTO;
import com.itwillbs.project.review.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService{
	@Autowired
	private ReviewMapper reviewMapper;
	
	// 임시 저장 
	public Map<String, Object> draftSave(CoverLetterDTO coverLetterDTO) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			// coverLetterIdx가 있으면 UPDATE, 없으면 INSERT 
			if(coverLetterDTO.getCoverLetterIdx() != null &&
					coverLetterDTO.getCoverLetterIdx() > 0) {
				reviewMapper.updateForm(coverLetterDTO);
			} else {
				reviewMapper.insertForm(coverLetterDTO);
			}
			
			result.put("success", true);
			result.put("message", "임시저장 되었습니다.");
			result.put("coverLetterIdx", coverLetterDTO.getCoverLetterIdx()); 
		} catch (Exception e) {
			result.put("success", false);
	        result.put("message", "임시저장 실패: " + e.getMessage());
		}
		return result;
	}

	// 1단계 정식 저장 
	public void registForm(CoverLetterDTO coverLetterDTO) {
		// coverLetterIdx가 있으면 UPDATE (임시저장 레코드 활용)
		if(coverLetterDTO.getCoverLetterIdx() != null &&
				coverLetterDTO.getCoverLetterIdx() > 0) {
			reviewMapper.updateForm(coverLetterDTO);
		} else {
			// 없으면 새로 INSERT
			reviewMapper.insertForm(coverLetterDTO); // 실행 후 coverLetterDTO.getCoverLetterIdx()에 자동 세팅
		}
	}
	
	
	public void saveTotal(CoverLetterDTO coverLetterDTO) {
		reviewMapper.updateContent(coverLetterDTO);
		
	}

	public void deleteData(Long coverLetterIdx) {
		reviewMapper.deleteData(coverLetterIdx);
		
	}

	public CoverLetterDTO getCoverLetter(Long coverLetterIdx) {
				
		return reviewMapper.selectCoverLetter(coverLetterIdx);
	}



}
