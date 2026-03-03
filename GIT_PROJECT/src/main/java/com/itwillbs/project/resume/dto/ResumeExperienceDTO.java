package com.itwillbs.project.resume.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResumeExperienceDTO {

	private Integer exp_id;   			// 경력 아이디
	private Integer resume_id;        	// 이력서 참조 (FK)
	private String company_name;      	// 회사명
	private String job_position;      	// 직무/직책
	private String job_description;   	// 담당 업무 및 상세 설명
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate start_date;     	// 입사일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate end_date;       	// 퇴사일 (재직 중이면 NULL 가능)
	
	
}
