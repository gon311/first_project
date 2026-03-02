package com.itwillbs.project.store.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResponsePaymentDTO {
	private String paymentId;
    private String merchantUid;
    private String status;
}
