package com.itwillbs.project.review.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CoverLetterRequestDTO {
	private String title;			// 자소서 제목
	
	private String industryCode;	// 업종
	private String jobCode;			// 직종
	private String roleCode;		// 세부직종
	private String companyCode;		// 기업 형태
	private String careerCode;		// 경력사항
	
	private String appliedField; 	// 지원분야 
	private String companyName;  	// 기업 이름 
	
	private Integer saveStatus;     // 저장 상태 (0: 최종저장, 1: 저장, 2: 임시저장(default)) 
	
}
