package com.itwillbs.project.admin.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchDTO {
	// 조건별 검색 DTO(임시)
	private String keyword;
	private String type; 
	private String status;
}
