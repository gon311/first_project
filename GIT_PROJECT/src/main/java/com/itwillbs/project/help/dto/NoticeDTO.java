package com.itwillbs.project.help.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeDTO {
	private int noticeId;
	private String noticeTitle;
	private String noticeContent;
	private Date regDate;
	private String userType;
	// Enum을 String으로 선언해도문제없음(DB에서 저장된 ENUM)값을 Mybatis가 자동으로 String 변수에 담아줌
	private int readcount;
	private Date updateDate;
	private String status;
	
	//검색 기능 위한 필드 추가
	private String searchType; //검색 조건
	private String searchKeyword;
	
	
	
}
