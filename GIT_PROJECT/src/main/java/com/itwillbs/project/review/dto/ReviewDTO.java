package com.itwillbs.project.review.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewDTO {
	private String title;		// 자소서 제목
	private String industry;	// 업종
	private String jobGroup;	// 직종
	private String jobRole;		// 세부직종
	private String companyType;	// 기업 형태
	private String careerLevel;	// 경력사항
}
