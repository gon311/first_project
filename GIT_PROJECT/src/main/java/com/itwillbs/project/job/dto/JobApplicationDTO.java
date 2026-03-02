package com.itwillbs.project.job.dto;

import java.time.LocalDateTime;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Data
@NoArgsConstructor
public class JobApplicationDTO {
	private int appId;           // 신청 ID (AI)
    private long jobId;          // 채용공고 ID (FK) - JSP의 postId
    private long userId;         // 지원자 ID (FK)
    private Integer resumeId;    // 이력서 ID (FK) - 새로 추가한 컬럼
    private String appStep;      // 단계 (기본값: 서류대기)
    private String isFavorite;   // 즐겨찾기 (Y/N)
    private LocalDateTime applyDate;      // 지원 날짜
	
}
