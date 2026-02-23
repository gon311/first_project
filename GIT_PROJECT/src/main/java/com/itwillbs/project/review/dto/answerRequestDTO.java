package com.itwillbs.project.review.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class answerRequestDTO {
	
	private String questionCode;		// 질문 코드 
	private String content;				// 자소서 본문 
	
}
