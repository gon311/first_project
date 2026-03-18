package com.itwillbs.project.my.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class MyResumeDTO {

    // PK/FK
    private Integer resumeId;     // resume.resume_id (PK)
    private Long userId;          // resume.user_id (FK)

    // 목록용 메타
    private String title;         // resume.title
    private String status;        // resume.status (DRAFT/COMPLETE)

    // 시간/삭제
    private LocalDateTime createdAt;   // resume.created_at
    private LocalDateTime updatedAt;   // resume.updated_at
    private Integer isDeleted;         // resume.is_deleted (0/1)

    // 화면 표시용(문자열 포맷)
    private String updatedAtStr;  // DATE_FORMAT(updated_at, ...) AS updated_at_str
    
    // 업종들
    private String hiddenJob;           // 직종명
    private String hiddenIndustry;      // 업종명
    private String hiddenCompanyType;   // 기업형태명
    private String appliedField;        // 지원직무
    private String companyName;         // 기업명
    
    
}