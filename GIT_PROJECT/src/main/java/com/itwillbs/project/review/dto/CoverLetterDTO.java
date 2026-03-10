package com.itwillbs.project.review.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CoverLetterDTO {
	
	private Long coverLetterIdx;	// 자소서 일련번호
	private Long userId; 			// 사용자 식별자(user(user_id))
	
	private String title;			// 자소서 제목
	
	private String industryCode;	// 업종
	private String jobCode;			// 직종
	private String roleCode;		// 세부직종
	private String companyCode;		// 기업 형태
	private String careerCode;		// 경력사항
	
	private String appliedField; 	// 지원분야 
	private String companyName;  	// 기업 이름 
	
	private String questionCode;	// 질문 유형 코드 
	private String content; 		// 자기소개서 본문
	
	private Integer saveStatus;     // 저장 상태 (0: 최종저장, 1: 저장, 2: 임시저장(default)) 
	
	private Boolean aiGenerated;   // AI 생성 여부
	
	private LocalDateTime createdAt; // 생성일시
	private LocalDateTime updatedAt; // 수정일시 
		
}
