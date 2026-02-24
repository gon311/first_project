package com.itwillbs.project.my.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@NoArgsConstructor
public class MyResumeDTO {

    // ===== 식별/관계키 =====
    private Long resumeMyId;      // resume_my_id (PK)
    private Long userId;          // user_id (FK) - 보통 서버 내부 검증용
    private Integer resumeId;     // resume_id (FK)

    // ===== 목록/편집에 필요한 값 =====
    private String title;         // title
    private String status;        // status (추천: enum)
    private String memo;          // memo

    // ===== 시간/삭제 =====
    private LocalDateTime createdAt; // created_at
    private LocalDateTime updatedAt; // updated_at
    private Integer isDeleted;     // is_deleted (0/1)  (추천: Boolean으로 매핑)
    
    private String updatedAtStr; // JSP 표시용(포맷된 문자열)
    
}