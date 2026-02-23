package com.itwillbs.project.review.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CoverLetterSaveDTO {
	
	private Integer coverLetterIdx;	// 자조서 일련번호
	private Integer userId; 		// 사용자 아이디 
	
	private String title;			// 자소서 제목
	
	private String industryIdx;		// 업종
	private String jobIdx;			// 직종
	private String roleIdx;			// 세부직종
	private String companyIdx;		// 기업 형태
	private String careerIdx;		// 경력사항
	
	private String appliedField; 	// 지원분야 
	private String companyName;  	// 기업 이름 
	
	private Integer saveStatus;     // 저장 상태 (0: 최종저장, 1: 저장, 2: 임시저장(default)) 
	
	private LocalDateTime createdAt; // 생성일시
	private LocalDateTime updatedAt; // 업데이트 일시 
	
	
}
