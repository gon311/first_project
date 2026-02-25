package com.itwillbs.project.resume.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CareerDTO {
	
//	resume_경력정보 섹션
	
	private Integer expId;              // 경력 아이디 (PK)
    private Integer resumeId;           // 이력서 참조 (FK)
    private String companyName;     	// 회사명
    private String jobPosition;     	// 직무/직책
    private String jobDescription;  	// 담당 업무 및 상세 설명
    private LocalDateTime startDate;    // 입사일
    private LocalDateTime endDate;      // 퇴사일 (재직 중이면 NULL 가능)

}
