package com.itwillbs.project.store.dto;

import java.text.DecimalFormat;
import java.time.LocalDateTime;

import com.itwillbs.project.user.dto.UserDTO;

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
public class PaymentDTO {
	private String payId;
	private long userId;
	private String userName;	
	private String phone;	 
	private String productId;
	private String productName;  // 상품명(결제 - 상품 테이블 조인)
	private String payMethod;
	private String cardName;
	private String cardNum;
	private String bankName;
	private String depositAccount;
	private String depositName;
	private int payPrice;
	private LocalDateTime payDate; 
	private String payStatus; 
	  
//	public void setPayPrice(Integer payPrice) {
//		DecimalFormat df = new DecimalFormat("###,###");
//		this.payPrice = df.format(payPrice);
//	}
	
}
