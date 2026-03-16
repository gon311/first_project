package com.itwillbs.project.store.dto;


import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberProductDTO {
	// 회원 이용권 dto
	private String payId;
	private String productId;
	private long userId;
	private int remainingCount;
	private Date startDate;
	private Date endDate;
	private String useStatus;
	
} 


