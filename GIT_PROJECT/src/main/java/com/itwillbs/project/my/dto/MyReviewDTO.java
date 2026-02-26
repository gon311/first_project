package com.itwillbs.project.my.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


// cover_letter 테이블 참고.

// company_name VARCHAR(100) NOT NULL,

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MyReviewDTO {
	
    // ===== 식별/관계키 =====
    private Long coverLetterId;      // cover_letter_idx (PK)
    private Long userId;          // user_id (FK)

    // ===== 목록/편집에 필요한 값 =====
    private String title;         // title
    private int status;        // save_status (0 최종저장 1 저장 2 임시저장)
    private String companyName;   // 기업 이름

    // ===== 시간 =====
    private LocalDateTime createdAt; // created_at
    
    private String createdAtStr; // JSP 표시용(포맷된 문자열)

}
