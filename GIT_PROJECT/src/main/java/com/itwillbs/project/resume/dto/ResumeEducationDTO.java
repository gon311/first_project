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

	private Integer edu_id;   			// 학력 아이디
	private Integer resume_id;          // 이력서 참조 (FK)
	
	private String education_level;     // 학력 구분
	private String school_name;         // 학교명
	private String department;          // 계열
	private String major;               // 전공
	private BigDecimal hakjum;          // 학점
	private String hakjum_scale;        // 학점 기준
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate edu_start_day;    // 입학일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate edu_end_day;      // 졸업일
	
}
