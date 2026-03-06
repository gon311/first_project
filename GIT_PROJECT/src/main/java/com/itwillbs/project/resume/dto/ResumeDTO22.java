package com.itwillbs.project.resume.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResumeDTO2 {
	
	// @DateTimeFormat(pattern = "yyyy-MM-dd") 
	
	private Integer resume_id; 		// 	-- 이력서 아이디 autoIncrease
	private	Integer user_id;		// 	-- 소유자 유저 ID (FK)
	private	String 	name_kor;		//  -- 이력서 이름(한글)
	private	String  name_eng;		//	-- 이력서 이름(영문)
	private	String  name_han;		//	-- 이력서 이름(한문)

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private	LocalDate birth_date;	// -- 생년월일
	private	String gender;          // -- 성별
	private	String phone_number;    // -- 전화번호
	private	String email;           // -- 이메일
	private	String address1;           // -- 주소1
	private	String address2;           // -- 상세주소2

	private	String veteran_status;		// -- 보훈대상 여부
	private	String veteran_number;      // -- 보훈번호
	private	String disability_status;   // -- 장애 여부
	private	String disability_grade;   	// -- 장애 등급 : 추가
	
	private	String multicultural_status;// -- 다문화가정 여부
	private	String north_defector;		// -- 북한이탈주민 여부
	private	String low_income_status;	// -- 기초생활수급자/차상위계층 여부

	private	String military_service;	// -- 군필 여부
	private	String military_branch;		// -- 군별
	private	String military_rank;		// -- 계급
	private	String discharge_reason;	// -- 전역사유
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private	LocalDate 	enlist_date;		// -- 입대일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private	LocalDate 	discharge_date;		// -- 전역일
	private	String 		exemption_reason;	// -- 면제사유
	
//	 1차 작성된 추가 컬럼들
	private String title;			// 제목            
	private String industryCode;    // 업종            
	private String jobCode;         // 직종            
	private String roleCode;        // 세부직종          
	private String companyCode;     // 기업형태          
	private String appliedField;    // 지원분야(지원직무)    
	private String companyName;     // 기업명(지원한)      
	private String careerCode;     	// 경력사항(신입/경력/인턴)
	
	private String hiddenIndustry;		// 업종명칭   
	private String hiddenJob;           // 직종명칭   
	private String hiddenRole;          // 세부직종명  
	private String hiddenCompanyType;   // 기업형태명칭 
	
	// 학력정보 1 ~ n개.
	private List<ResumeEducationDTO> educationList;
	
	// 경력정보 1 ~ n개.
	private List<ResumeExperienceDTO> experienceList;
}


//CREATE TABLE resume (
//	    resume_id INT AUTO_INCREMENT PRIMARY KEY, -- 이력서 아이디
//		user_id BIGINT NOT NULL,                  -- 소유자 유저 ID (FK)
//	    name_kor VARCHAR(50) NOT NULL,            -- 이력서 이름(한글)
//	    name_eng VARCHAR(50),                     -- 이력서 이름(영문)
//	    name_han VARCHAR(50),                     -- 이력서 이름(한문)
//	    birth_date DATE,                          -- 생년월일
//	    gender VARCHAR(10),                       -- 성별
//	    phone_number VARCHAR(20),                 -- 전화번호
//	    email VARCHAR(100),                       -- 이메일
//
//	    veteran_status VARCHAR(30),               -- 보훈대상 여부
//	    veteran_number VARCHAR(30),               -- 보훈번호
//	    disability_status VARCHAR(30),            -- 장애 여부
//	    multicultural_status VARCHAR(30),         -- 다문화가정 여부
//	    north_defector VARCHAR(30),               -- 북한이탈주민 여부
//	    low_income_status VARCHAR(30),            -- 기초생활수급자/차상위계층 여부
//
//	    military_service VARCHAR(20),             -- 군필 여부
//	    military_branch VARCHAR(30),              -- 군별
//	    military_rank VARCHAR(30),                -- 계급
//	    discharge_reason VARCHAR(30),             -- 전역사유
//	    enlist_date DATE,                         -- 입대일
//	    discharge_date DATE,                      -- 전역일
//	    exemption_reason VARCHAR(30),              -- 면제사유
//	    
//		CONSTRAINT fk_resume_user
//		FOREIGN KEY (user_id) REFERENCES USER(user_id)
//		ON DELETE CASCADE
//	    
//	);