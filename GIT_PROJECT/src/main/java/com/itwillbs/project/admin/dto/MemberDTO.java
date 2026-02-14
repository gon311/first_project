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
	
	private BigInteger user_id;
	private String email;
	private String password;
	private String phone;
	private String user_name;
	private char user_type;
	private String status;
	private LocalDateTime joined_at;
	private LocalDateTime withdrawn_at;
	
	
}
