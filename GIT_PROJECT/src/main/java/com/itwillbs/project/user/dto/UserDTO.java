package com.itwillbs.project.user.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class UserDTO {
	// 공통
	private Long userId;            // user_id (BIGINT)
	private String email;           // email (VARCHAR)
	private String password;        // password (VARCHAR)
	private String phone;           // phone (VARCHAR)
	private String userName;        // user_name (VARCHAR)
	private String userType;        // user_type (CHAR)
	private String status;          // status (VARCHAR)
	private LocalDateTime joinedAt; // joined_at (DATETIME)
	private LocalDateTime withdrawnAt; // withdrawn_at (DATETIME)
	
	// 개인
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthDate;       // birth_date (DATE)
	private String gender;             // gender (CHAR)
	private String country;            // country (VARCHAR)
	private Integer reportReceivedCnt; // report_received_ (INT) - 'cnt' 등을 붙여 의미를 명확히 함
	private String profileUrl;         // profile_url (VARCHAR)
	
	// 기업
	private String bizRegNo;         // biz_reg_no (VARCHAR)
	private String companyName;      // company_name (VARCHAR)
	private String ceoName;          // ceo_name (VARCHAR)
	private String companyAddress;   // company_addre... (VARCHAR)
	
	// 약관동의
	private List<String> termsCode;
	private String agreedYn;
	
}
