package com.itwillbs.project.store.dto;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
[ 결제 테이블 ]
pay_id varchar(50),
user_id bigint,
product_id varchar(20),
pay_method varchar(20) not null,
card_name varchar(20),
card_num varchar(50),
bank_name varchar(20),
deposit_account varchar(30),
deposit_name varchar(10),
pay_price int not null,
pay_date datetime not null,
pay_status enum('ready', 'paid', 'cacelled') 
*/

@Getter
@Setter
@ToString
public class OrderDTO {
	private Integer orderId;
	private String payId;
	private long userId;
	private String userName;	
	private String phone;	
	private String email;
	private String productId;
	private String productName;  // 상품명(결제 - 상품 테이블 조인)
	private String productPrice;  // 상품명(결제 - 상품 테이블 조인)
	private String payMethod;
	private String cardName;
	private String bankName;
	private String depositAccount;
	private String depositName;
	private String payPrice;
	private LocalDateTime payDate;
	private String payStatus; 
	
	
	public void setPayPrice(Integer payPrice) {
		DecimalFormat df = new DecimalFormat("###,###");
		this.payPrice = df.format(payPrice);
	}
	
//	public void setPayId() {
//		LocalDate today = LocalDate.now();
//		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
//		
//		// 0~99999 랜덤 숫자, 5자리 고정
//	    int randNum = (int)(Math.random() * 100000);
//	    String randStr = String.format("%05d", randNum);
//	     
//		this.payId = today.format(dtf) + randStr;
//	}
	
}
