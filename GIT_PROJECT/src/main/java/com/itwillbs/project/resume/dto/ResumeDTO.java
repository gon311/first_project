package com.itwillbs.project.resume.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResumeDTO {
	// 기본 정보
    private Integer resumeId;          // 이력서 아이디 (PK)
    private Integer userId;            // 소유자 유저 ID (FK)
    private String nameKor;            // 이름(한글)
    private String nameEng;            // 이름(영문)
    private String nameHan;            // 이름(한문)

    private LocalDate birthDate;       // 생년월일
    private String gender;             // 성별
    private String phoneNumber;        // 전화번호
    private String email;              // 이메일
    private String address1;           // 주소1
    private String address2;           // 상세주소2

    // 부가 정보
    private String veteranStatus;      // 보훈대상 여부
    private String veteranNumber;      // 보훈번호
    private String disabilityStatus;   // 장애 여부
    private String disabilityGrade;    // 장애 등급
    
    private String multiculturalStatus;// 다문화가정 여부
    private String northDefector;      // 북한이탈주민 여부
    private String lowIncomeStatus;    // 기초생활수급자/차상위계층 여부

    // 병역 정보
    private String militaryService;    // 군필 여부
    private String militaryBranch;     // 군별
    private String militaryRank;       // 계급
    private String dischargeReason;    // 전역사유
    private LocalDate enlistDate;      // 입대일
    private LocalDate dischargeDate;   // 전역일
    private String exemptionReason;    // 면제사유
    
    // 추가 컬럼들 (기존 camelCase 유지)
    private String title;              // 제목
    private String industry;           // 업종
    private String jobGroup;           // 직종
    private String jobRole;            // 세부직종
    private String companyType;        // 기업형태
    private String appliedField;       // 지원분야
    private String companyName;        // 기업명
    private String careerLevel;        // 경력사항
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