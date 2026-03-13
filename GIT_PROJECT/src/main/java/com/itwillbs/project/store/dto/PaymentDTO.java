package com.itwillbs.project.store.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentDTO {
	private String payId;
	private long userId;
	private String userName;	
	private String userType;	
	private String phone;	 
	private String productId;
	private String productName;  // 상품명(결제 - 상품 테이블 조인)
	private String payMethod;
	private String cardName;
	private String cardNum;
	private int payPrice;
	private LocalDateTime payDate;
	private String strPayDate;
	private String payStatus; 
	
	public void setUserType(String userType) {
		if(userType.equalsIgnoreCase("c")) {
			this.userType = "기업 회원";
		} else {
			this.userType = "구직자 회원";
		}
	}
	
	public void setPayDate(LocalDateTime payDate) {
		this.payDate = payDate;
		
		if(payDate != null) { 
			this.strPayDate = payDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		}
	}
	
	
}
