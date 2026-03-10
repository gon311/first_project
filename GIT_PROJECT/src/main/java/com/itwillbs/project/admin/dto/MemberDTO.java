package com.itwillbs.project.admin.dto;

import java.time.LocalDate;
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
	private long userId;
	private String email;
	private String password;
	private String phone;
	private String userName;
	private String userType;
	private String status;
	private LocalDateTime joinedAt;
	private LocalDateTime withdrawnAt;
	
	// 구직자 회원 상세 정보
	private LocalDate birthDate;
	private String gender;
	private String country;
	private Integer passCount;
	private Integer reportReceivedCount;
	private String profileUrl;
	
	// 기업 회원 상세 정보
	private String bizRegNo;
	private String companyName;
	private String ceoName;
	private String companyAddress;
	
	// 구직자 회원 이용권
	private String productId;
	private String productName;
	
	// 탈퇴 일자 계산을 위한 현재 날짜
	private LocalDateTime today = LocalDateTime.now();
	
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
	
	public void setGender(char gender) {
		if(gender == 'M') {
			this.gender = "남";
		} else if(gender == 'F') {
			this.gender = "여";
		} else {
			this.gender = "공개안함";
		}
	}
	
}
