package com.itwillbs.project.my.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MyDTO {
	private Long userId; // 회원 ID
	private String userName; // 회원 이름
	private String email; // 이메일
	private String phone; // 전화번호
	private String userType; // 회원 상태 "P" or "C"
	
	private String gender;       // 성별 M/F/N
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthDate; // 생년월일
	private String country;      // 국적
	private String profileUrl;   // 프로필 이미지
	private String status;       // 회원 상태 ACTIVE/SUSPENDED/WITHDRAWN
	
	private String userTypeName; // 개인회원 / 기업회원
	private String genderName;   // 남성 / 여성 / 선택안함
	
	private Integer remainingCount;   // 남은 이용권 횟수
	private Integer passCount;   // 이용권 횟수
	private String useStatus;         // active / expired
	private String productId;         // 상품 ID
	private String productName;       // 상품명

}

