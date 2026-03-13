package com.itwillbs.project.help.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class SupportQnaDTO {
    
    // QNA 기본 정보
    private int qnaId;             // qna_id (PK)
    private String qnaCategory;    // qna_category (문의 유형: PAY, ACCOUNT 등)
    private String qnaTitle;       // qna_title (제목)
    private String qnaContent;     // qna_content (내용)
    private long writerId;         // writer_id (작성자 USER_ID)
    private Date regDate;          // reg_date (등록일)
    
    // 답변 관련 정보
    private String reStatus;       // re_status (pending / completed)
    private Date reDate;           // re_date (답변일)
    private String reContent;      // re_content (답변 내용)
    
    // 상태 관리
    private String isDeleted;      // is_deleted (Y / N)

    // [추가 선택사항] 작성자 이름을 화면에 바로 뿌리고 싶을 때 사용
    private String userName;       
}