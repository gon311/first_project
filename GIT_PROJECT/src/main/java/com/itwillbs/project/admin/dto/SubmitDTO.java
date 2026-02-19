package com.itwillbs.project.admin.dto;

import java.math.BigInteger;
import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SubmitDTO {
	private BigInteger id; 
	private BigInteger compId;
	private String title;
	private String field;
	private String task;
	private String expType;
	private Integer expYear;
	private String edu;
	private String empType;
	private String probation;
	private String salary;
	private String address;
	private Integer isRemote;
	private LocalDateTime openDate;
	private LocalDateTime closeDate;
	private String mgrName;
	private String mgrPhone;
	private String mgrEmail;
	private Integer isPublic;
	private Integer postStatus;
}
