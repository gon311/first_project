package com.itwillbs.project.resume.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EducationDTO {
	
//	 resume_education 섹션
	
	 private Integer eduId;             // 학력 아이디 (PK)
	 private Integer resumeId;          // 이력서 참조 (FK)
	 private String educationLevel;  	// 학력 구분
	 private String schoolName;      	// 학교명
	 private String department;      	// 계열
	 private String major;           	// 전공
	 private double hakjum;          	// 학점 -> 자료형 - double : db - decimal
	 private String hakjumScale;     	// 학점 기준
	 private LocalDateTime eduStartDay; // 입학일
	 private LocalDateTime eduEndDay;   // 졸업일

    
}
