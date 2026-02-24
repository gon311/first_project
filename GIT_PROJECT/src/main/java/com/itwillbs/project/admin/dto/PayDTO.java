package com.itwillbs.project.admin.dto;

import java.math.BigInteger;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
public class PayDTO {
	private String payId;
	private BigInteger userId;
	private String userName;	
	private String phone;	 
	private String userType;	 // 사용자 구분(결제 - 회원 테이블 조인)
	private String productId;
	private String productName;  // 상품명(결제 - 상품 테이블 조인)
	private String payMethod;
	private String cardName;
	private String cardNum;
	private String bankName;
	private String depositAccount;
	private String depositName;
	private String payPrice;
	private String payDate;
	private String payStatus;
	
	public void setUserType(String userType) {
		if(userType.equalsIgnoreCase("c")) {
			this.userType = "기업 회원";
		} else {
			this.userType = "구직자 회원";
		}
	}
	
	public void setPayDate(LocalDateTime payDate) {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm:ss");
		this.payDate = payDate.format(dtf);
	}
	
	public void setPayStatus(String payStatus) {
		if(payStatus.equalsIgnoreCase("paid")) {
			this.payStatus = "결제완료";
		} else if(payStatus.equalsIgnoreCase("ready")) {
			this.payStatus = "입금대기";
		} else if(payStatus.equalsIgnoreCase("cacelled")) {
			this.payStatus = "결제취소";
		}
	}
	
	public void setPayPrice(Integer payPrice) {
		DecimalFormat df = new DecimalFormat("###,###");
		this.payPrice = df.format(payPrice);
	}
	
}
