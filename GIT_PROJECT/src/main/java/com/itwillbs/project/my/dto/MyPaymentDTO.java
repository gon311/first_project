package com.itwillbs.project.my.dto;


import java.time.LocalDateTime;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// pay 테이블 사용

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MyPaymentDTO {
	// 사용자 식별
	private String payId;
	private long userId;
	
	// 상품 ID
	private String productId; 
	
	// 결제일시
	private LocalDateTime payDate;
	
	// 결제상품 이름 (상품 테이블과 JOIN 하여 사용)
	private String productName;
	
	// 결제금액
	private int payPrice;
	
	// 결제상태 ( ready , paid , cacelled)
	private String payStatus; 
	
	// 결제수단/증빙
	private String payMethod;
	
	
	// 날짜(디스플레이)
	private String payDateText;
	
	
	
	
}
