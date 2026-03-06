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
    
    // resume_my 에 필요한 부분.
    private String status;				// 상태 - DEFAULT 'COMPLETE'
    private String createdAt;				// 생성일
    private String updatedAt;				// 수정일
    private String isDeleted;				// 삭제 여부.
    

    private List<ResumeEducationDTO> educationList;
    private List<ResumeExperienceDTO> experienceList;
}

//status VARCHAR(20) NOT NULL DEFAULT 'COMPLETE',      -- 상태 (예: DRAFT=미완성, COMPLETE=완성 등)
//memo VARCHAR(500) NULL,                           -- 메모 (예: "11/25까지 제출" 같은 메모)
//
//created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,                 -- 생성일
//updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
//           ON UPDATE CURRENT_TIMESTAMP,                                 -- 최종수정일(업데이트 시 자동 갱신)
//is_deleted TINYINT(1) NOT NULL DEFAULT 0,                               -- 삭제여부(0=정상, 1=삭제/숨김)
//
