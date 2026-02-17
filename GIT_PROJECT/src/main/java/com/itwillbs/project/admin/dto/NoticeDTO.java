package com.itwillbs.project.admin.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class NoticeDTO {
	private int id;
	private String title;
	private String content;
	private String regDate;
	private String status;
	private String userType;
	private int count;
	
	//검색 기능 위한 필드 추가
	private String searchType; //검색 조건
	private String keyword; //검색 키워드
}
