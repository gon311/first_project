package com.itwillbs.project.gpt.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GptGenerateDTO {
	
	private Long coverLetterIdx;	// 자소서 번호
	
	private String question;		// 질문 유형 코드 
	private String inputText; 		// 입력받은 자기소개서 본문
	
}
