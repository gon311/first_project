package com.itwillbs.project.admin.dto;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SubmitDTO {
	private BigInteger id; // job_id
	private BigInteger compId;
	private String title;
	private String field;
	private String task;
	private String empType;
	private char probation;
	private String expType;
	private String expYear;
	private String edu;
	private String salary;
	private String address;
	private char isRemote;
	private String mgrName;
	private String mgrPhone;
	private String mgrEmail;
	private char isPublic;
	private Date openDate;
	private Date closeDate;
	private int postStatus;
	private LocalDateTime regDate;
	private Integer postCheck;
}
