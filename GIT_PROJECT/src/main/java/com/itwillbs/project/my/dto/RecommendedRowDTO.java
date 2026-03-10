package com.itwillbs.project.my.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class RecommendedRowDTO {
    private long jobId; // 유저 아이디
    private double score;	// 점수
    private String title;	// 공고 제목
    private String field;	// 공고 필드
    private String address;	// 공고 주소
    private Date openDate;	// 시작 날짜
    private Date closeDate;	// 마감
}
