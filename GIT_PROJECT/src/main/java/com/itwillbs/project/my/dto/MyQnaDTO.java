package com.itwillbs.project.my.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MyQnaDTO {
    private Integer qnaId;
    private String qnaCategory;
    private String qnaTitle;
    private String qnaContent;
    private Long writerId;
    private Date regDate;

    private String reStatus;     // pending / completed
    private Date reDate;
    private String reContent;
    private String isDeleted;

    private String regDateText;  // 화면 출력용
    private String statusText;   // 답변대기 / 답변완료
}