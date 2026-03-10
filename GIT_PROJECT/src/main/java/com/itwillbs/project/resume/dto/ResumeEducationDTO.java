package com.itwillbs.project.resume.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResumeEducationDTO {

	private Integer eduId;
	private Integer resumeId;
	
	private String educationLevel;
	private String schoolName;
	private String department;
	
	private String major;
	
	private String minorMajor; // 선택값 (부전공/복수전공/이중전공)
	private String majorSub;   // 실제 전공명 입력 
		
	private BigDecimal hakjum;
	private String hakjumScale;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate eduStartDay;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate eduEndDay;
}