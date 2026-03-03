package com.itwillbs.project.my.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class RecommendedRowDTO {
    private long jobId;
    private double score;
    private String title;
    private String field;
    private String address;
    private LocalDate openDate;
    private LocalDate closeDate;
    // 필요하면 compId, 회사명 등 추가
}
