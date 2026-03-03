package com.itwillbs.project.gpt.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GptGenerateDTO {
	
	private Long coverLetterIdx;	// 자소서 번호
	
	private String questionCode;		// 질문 유형 코드 
	private String content; 		// 입력받은 자기소개서 본문
	
	//cover_letter table에서 select 해온 값
	private String industryName;	
	private String jobName;
	private String roleName;
	private String appliedField;
	private String companyName;
	private String companyType;
	private String careerName;
	private String questionName;
	
	
	
	
	
}
