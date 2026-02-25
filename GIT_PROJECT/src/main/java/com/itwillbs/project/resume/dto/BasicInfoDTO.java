package com.itwillbs.project.resume.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BasicInfoDTO {
	
//	 resume_기본정보 섹션
	
	 private Integer resume_id; 				// 이력서 아이디
	 private String name_kor;          		   	// 이력서 이름(한글)
	 private String name_eng;                  	// 이력서 이름(영문)
	 private String name_han;                  	// 이력서 이름(한문)
	 private LocalDateTime birth_date;          // 생년월일
	 private String gender;                    	// 성별
	 private String phone_number;              	// 전화번호
	 private String email;                     	// 이메일

	 private String veteran_status;            	// 보훈대상 여부
	 private String veteran_number;            	// 보훈번호
	 private String disability_status;         	// 장애 여부
	 private String multicultural_status;      	// 다문화가정 여부
	 private String north_defector;            	// 북한이탈주민 여부
	 private String low_income_status;         	// 기초생활수급자/차상위계층 여부

	 private String military_service;          	// 군필 여부
	 private String military_branch;           	// 군별
	 private String military_rank;             	// 계급
	 private String discharge_reason;          	// 전역사유
	 private LocalDateTime enlist_date;         // 입대일
	 private LocalDateTime discharge_date;      // 전역일
	 private String exemption_reason;           // 면제사유

}
