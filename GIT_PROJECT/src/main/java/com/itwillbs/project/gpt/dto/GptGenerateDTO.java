package com.itwillbs.project.gpt.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GptGenerateDTO {
	
	private String title;			// 자소서 제목
	
	private String industry;	// 업종
	private String job;			// 직종
	private String role;		// 세부직종
	private String company;		// 기업 형태
	private String career;		// 경력사항
	
	private String appliedField; 	// 지원분야 
	private String companyName;  	    // 회사명
	
	private String question;	// 질문 유형 코드 
	private String content; 		// 최종 저장된 자기소개서 본문
	
}
