package com.itwillbs.project.store.dto;

import java.text.DecimalFormat;

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
	private String productPrice;
	private Integer productCount;
	private Integer productDuration;
	
	public void setProductPrice(Integer productPrice) {
		DecimalFormat df = new DecimalFormat("###,###");
		this.productPrice = df.format(productPrice);
	}
}
