package com.itwillbs.project.store.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
 
@Getter
@Setter
@ToString
public class OrderDTO {
	private String orderId;
	private long userId;
	private String userName;	
	private String phone;	
	private String email;
	private String productId;
	private String productName; 
	private Integer productPrice;  
	private String status; 
	
}
