package com.itwillbs.project.resume.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResumeExperienceDTO {

	private Integer expId;
    private Integer resumeId;

    private String companyName;
    private String jobPosition;
    private String jobDescription;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate; 
	
}
