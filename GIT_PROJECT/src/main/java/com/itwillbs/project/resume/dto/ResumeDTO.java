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
public class ResumeDTO {
	
	// @DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Integer resumeId;
    private Integer userId;

    private String nameKor;
    private String nameEng;
    private String nameHan;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthDate;

    private String gender;
    private String phoneNumber;
    private String email;
    private String address1;
    private String address2;

    private String veteranStatus;
    private String veteranNumber;
    private String disabilityStatus;
    private String disabilityGrade;
    private String multiculturalStatus;
    private String northDefector;
    private String lowIncomeStatus;

    private String militaryService;
    private String militaryBranch;
    private String militaryRank;
    private String dischargeReason;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate enlistDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dischargeDate;

    private String exemptionReason;

    // 1단계 입력 부분
    private String title;
    private String industryCode;
    private String jobCode;
    private String roleCode;
    private String companyCode;
    private String appliedField;
    private String companyName;
    private String careerCode;

    private String hiddenIndustry;
    private String hiddenJob;
    private String hiddenRole;
    private String hiddenCompanyType;

    private List<ResumeEducationDTO> educationList;
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