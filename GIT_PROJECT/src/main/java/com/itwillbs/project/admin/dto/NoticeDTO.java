package com.itwillbs.project.admin.dto;

import java.util.Date;

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
	private int notice_id;
	private String notice_title;
	private String notice_content;
	private Date reg_date;
	private Enum user_type;
	private int readcount;
	private Date update_time;
	
	//검색 기능 위한 필드 추가
	private String searchType; //검색 조건
	private String keyword; //검색 키워드
}
