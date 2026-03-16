package com.itwillbs.project.user.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
[ 회원 이메일 인증 정보를 관리할 mail_auth_info 테이블 정의 ]
-------------------------------------------------------------
번호(idx) - 정수 자동증가 PK
이메일(email) - 50자, UN, NN, FK(member - email)
인증코드(auth_code) - 100자, UN, NN
코드등록일시(created_at) - DATETIME(기본값 : 현재 시각)
-------------------------------------------------------------
CREATE TABLE mail_auth_info (
	idx INT AUTO_INCREMENT PRIMARY KEY,
	email VARCHAR(50) UNIQUE NOT NULL,
	auth_code VARCHAR(100) UNIQUE NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (email) REFERENCES member(email) ON DELETE CASCADE
);
*/
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MailAuthInfo {
	private Integer idx;
	private String email;
	private String authCode;
	private LocalDateTime createdAt;
}































