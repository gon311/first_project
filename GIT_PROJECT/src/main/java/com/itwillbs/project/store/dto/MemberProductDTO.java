package com.itwillbs.project.store.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberProductDTO {
	// 구직자 회원 이용권 dto
	private String payId;
	private String productId;
	private long userId;
	private int remainingCount;
	private LocalDateTime startDate;
	private LocalDateTime endDate;
	private String useStatus;
	
}


