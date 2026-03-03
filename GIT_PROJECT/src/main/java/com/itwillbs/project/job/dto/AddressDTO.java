package com.itwillbs.project.job.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 주소 정보를 별도로 관리하는 DTO 클래스 정의
@Getter
@Setter
@ToString
public class AddressDTO {
	private String postCode;
	private String address1;
	private String address2;
}
