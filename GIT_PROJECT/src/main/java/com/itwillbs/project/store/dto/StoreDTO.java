package com.itwillbs.project.store.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StoreDTO {
	private String productId;
	private String productName;
	private String productType;
	private Integer productPrice;
	private Integer productCount;
	private Integer productDuration;
	
}
