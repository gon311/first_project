package com.itwillbs.project.my.dto;

import java.time.LocalDate;
import lombok.Data;

@Data
public class FavoriteJobRowDTO {
    private Long jobId;
    private Long compId;

    private String companyName;
    private String title;

    private String expType;
    private String expYear;
    private String edu;
    private String empType;
    private String address;

    private LocalDate closeDate;

    private boolean closed;
    private String deadlineLabel;
}