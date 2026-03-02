package com.itwillbs.project.my.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class ApplyRowDTO {
    private Long appId;        // JOB_APPLICATION.app_id
    private Long jobId;

    private String companyName;
    private String title;

    private String expType;
    private String expYear;
    private String edu;
    private String empType;
    private String address;

    private LocalDateTime applyDate;   // apply_date
    private String applyDateStr;       // "2026-02-08" 같은 표시용

    private LocalDate closeDate;       // 마감일
    private boolean closed;            // close_date < today

    private String step;               // app_step (서류대기/면접 등)
    private String statusLabel;        // 화면에 뿌릴 한글 라벨(예: 지원완료/최종발표)
}
