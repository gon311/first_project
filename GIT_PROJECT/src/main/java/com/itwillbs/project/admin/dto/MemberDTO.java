package com.itwillbs.project.admin.dto;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {
	// 화면 출력 확인을 위해 임시로 만든 회원정보DTO
	private BigInteger userId;
	private String email;
	private String password;
	private String phone;
	private String userName;
	private String userType;
	private String status;
	private String joinedAt;
	private String withdrawnAt;
	
	public void setUserType(char userType) {
	    this.userType = (userType == 'C') ? "기업 회원" : "구직자 회원";
	}
	
	public void setStatus(String status) {
		if(status.equalsIgnoreCase("active")) {
			this.status = "활성";
		} else if(status.equalsIgnoreCase("suspended")) {
			this.status = "차단";
		} else if(status.equalsIgnoreCase("withdrawn")) {
			this.status = "탈퇴";
		}
	}
	
	public void setJoinedAt(LocalDateTime joinedAt) {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm:ss");
		this.joinedAt = joinedAt.format(dtf);
	}
	
	public void setWithdrawnAt(LocalDateTime withdrawnAt) {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm:ss");
		this.withdrawnAt = withdrawnAt.format(dtf);
	}
	
	// 구직자 상세 정보
//	private UserDTO userDto = new UserDTO();
	
	// 기업회원 상세 정보
//	private ComDTO comDTO = new ComDTO();
}
