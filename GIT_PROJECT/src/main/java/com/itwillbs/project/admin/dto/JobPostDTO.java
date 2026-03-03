package com.itwillbs.project.admin.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class JobPostDTO {
	// 출력 위한 임시 DTO
	private int jobId;
	private int compId;
	private String title;
	private String field;
	private String task;
	private String empType;
	private char probation;
	private String expType;
	private String expYear;
	private String edu;
	private String salary;
	private Date openDate;
	private Date closeDate;
	private int postStatus;
	
	private String keyword;
	private String companyName;
}
