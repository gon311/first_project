package com.itwillbs.project.admin.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;



@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class JobPostDTO {
	// 출력 위한 임시 DTO
	private Long jobId;
	private Long compId;
	private String companyName;
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
	private Integer postStatus;
	private String address;
	private String mgrName;
	private String mgrEmail;
	private String mgrPhone;
	private String isPublic;
	private String keyword;
	
}