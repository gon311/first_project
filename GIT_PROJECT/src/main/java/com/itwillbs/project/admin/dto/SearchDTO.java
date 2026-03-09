package com.itwillbs.project.admin.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchDTO {
	// 조건별 검색 DTO
	private String keyword;
	private String type; 
	private String userType; 
	private String status;
	private String submitStatus;
	private String payStatus;
	private String startDate;
	private String endDate;
	private String userId;
	private String category;
	
	private Integer faqId;
	
	private int offset;
	private int limit;

}
