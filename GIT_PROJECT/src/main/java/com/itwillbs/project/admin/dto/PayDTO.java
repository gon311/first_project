package com.itwillbs.project.admin.dto;

import java.math.BigInteger;
import java.time.LocalDateTime;

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
	private String id;
	private BigInteger userId;
	private String userType;	 // 사용자 구분(결제 - 회원 테이블 조인)
	private String productId;
	private String productName;  // 상품명(결제 - 상품 테이블 조인)
	private String payMethod;
	private String cardName;
	private String cardNum;
	private String bankName;
	private String depositAccount;
	private String depositName;
	private Integer payPrice;
	private LocalDateTime payDate;
	private String payStatus;
}
