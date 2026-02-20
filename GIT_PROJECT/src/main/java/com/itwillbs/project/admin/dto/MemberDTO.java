package com.itwillbs.project.admin.dto;

import java.math.BigInteger;
import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {
	// 화면 출력 확인을 위해 임시로 만든 회원정보DTO
	private BigInteger id;
	private String email;
	private String password;
	private String phone;
	private String name;
	private char memberType;
	private String status;
	private LocalDateTime joinedAt;
	private LocalDateTime withdrawnAt;
	
	// 구직자 상세 정보
//	private UserDTO userDto = new UserDTO();
	
	// 기업회원 상세 정보
//	private ComDTO comDTO = new ComDTO();
}
