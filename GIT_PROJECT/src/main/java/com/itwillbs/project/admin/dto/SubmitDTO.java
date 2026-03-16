package com.itwillbs.project.admin.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import com.itwillbs.project.common.dto.FileDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class SubmitDTO {
	private long jobId; 
	private long compId;
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
	private String strRegDate;
	private Integer postCheck;
	
	private List<FileDTO> fileList;
	
	public void setRegDate(LocalDateTime regDate) {
		this.regDate = regDate;
		
		if(regDate != null) { 
			this.strRegDate = regDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		}
	}
	
}
