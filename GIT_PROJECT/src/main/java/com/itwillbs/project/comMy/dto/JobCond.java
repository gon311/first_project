package com.itwillbs.project.comMy.dto;

import com.itwillbs.project.common.paging.BaseCond;

import lombok.Data;

@Data
public class JobCond extends BaseCond{
	private Long userId;
	
	private String status;			 // 전체 진행중 마감
	private String q;          // 검색어
	
	

}
