package com.itwillbs.project.admin.dto;

import java.util.List;

import com.itwillbs.project.store.dto.PaymentDTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;
 
@Getter
@ToString
@AllArgsConstructor
public class PaymentPageDTO {
	private List<PaymentDTO> PaymentList;
	private PageInfoDTO pageInfoDTO; 
} 
