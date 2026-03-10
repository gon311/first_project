package com.itwillbs.project.my.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// ---------------------------------------------------------
// ✅ (목록) 이력서 관리(myResume.jsp) - 리스트 1줄에 필요한 값
// ---------------------------------------------------------
// [이력서-목록]
//  - resumeId
//  - title
//  - status(DRAFT/COMPLETE)
//  - representative(true/false)
//  - updatedAt
//
// (선택) 화면에서 보여주면 추가
//  - careerType(신입/경력)
//  - desiredJob / desiredRegion

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MyResumeDTO {
	
    private int resumeId;              // resume.resume_id (INT PK)
    private String title;              // resume.title (VARCHAR)
    private String status;             // resume.status ("DRAFT" / "COMPLETE")
    private String representative;     // resume.is_representative -> "Y"/"N"로 변환해서 담기(권장)
    private LocalDateTime updatedAt;   // resume.updated_at (DATETIME)

    // (선택) 화면 표시용
    private String careerType;         // "신입" / "경력" (경력 테이블 존재 여부로 계산)
	
}
