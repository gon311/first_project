package com.itwillbs.project.gpt.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GptResponseDTO {
	private String title; 	// 생성된 소제목 
	private String content; // 생성된 본문
}
