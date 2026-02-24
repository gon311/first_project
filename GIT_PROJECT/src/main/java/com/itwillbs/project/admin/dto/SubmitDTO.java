package com.itwillbs.project.admin.dto;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE `JOB_POSTING` (
`job_id` BIGINT NOT NULL AUTO_INCREMENT,
`comp_id` BIGINT NOT NULL, -- 기업 회원 ID (USER.user_id)
-- 공고 핵심 내용
`title` VARCHAR(200) NOT NULL, -- 공고제목 [cite: 18]
`field` VARCHAR(100) NOT NULL, -- 모집분야 (직무) [cite: 19]
`task` TEXT NOT NULL, -- 주요업무 [cite: 21]
-- 고용 조건 및 자격 요건
`emp_type` VARCHAR(50) NOT NULL, -- 고용 형태 (정규직, 계약직 등) [cite: 23]
`probation` CHAR(1) DEFAULT 'N', -- 수습기간 여부 ('Y'/'N') [cite: 24]
`exp_type` VARCHAR(20) NOT NULL, -- 경력 구분 (new/career) [cite: 24]
`exp_year` VARCHAR(50) NULL, -- 경력 기간 (예: "신입", "경력무관", "3~5")
`edu` VARCHAR(50) NOT NULL, -- 학력 [cite: 28]
`salary` VARCHAR(50) NULL, -- 급여 [cite: 30]
-- 근무지 정보
`address` VARCHAR(500) NOT NULL, -- 주소 (우편번호 + 기본 + 상세 합산)
`is_remote` CHAR(1) DEFAULT 'N', -- 재택근무 여부 ('Y'/'N') [cite: 34]
-- 담당자 정보
`mgr_name` VARCHAR(50) NOT NULL, -- 담당자 이름 [cite: 35]
`mgr_phone` VARCHAR(20) NOT NULL, -- 담당자 연락처 [cite: 35]
`mgr_email` VARCHAR(100) NOT NULL, -- 담당자 이메일 [cite: 35]
`is_public` CHAR(1) DEFAULT 'Y', -- 정보 공개 여부 ('Y'/'N') [cite: 35]
-- 기간 및 상태
`open_date` DATE NOT NULL, -- 접수 시작일
`close_date` DATE NOT NULL, -- 접수 마감일
`post_status` TINYINT DEFAULT 1, -- 모집 상태 (1: 모집중 등)
`reg_date` DATETIME DEFAULT CURRENT_TIMESTAMP, -- 등록일시
`post_check` INT DEFAULT 1,  -- 1: 검토전, 2: 승인, 3: 보류 
 
PRIMARY KEY (`job_id`),
CONSTRAINT `fk_job_comp` FOREIGN KEY (`comp_id`) REFERENCES `USER`(`user_id`),
CONSTRAINT `check_date` CHECK (`open_date` <= `close_date`)
)  
*/

@Getter
@Setter
@ToString
public class SubmitDTO {
	private BigInteger jobId; // job_id
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
	private String regDate;
	private String postCheck;
	
	public void setRegDate(LocalDateTime regDate) {
		String pattern = "yyyy년 MM월 dd일 HH시 mm분 ss초";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(pattern);
		
		this.regDate = regDate.format(dtf);
		
	}
	
	public void setPostCheck(Integer postCheck) {
		if(postCheck == 1) {
			this.postCheck = "검토전";
		} else if(postCheck == 2) {
			this.postCheck = "승인";
		} else if(postCheck == 3) {
			this.postCheck = "보류";
		}
	}
	
	
}
