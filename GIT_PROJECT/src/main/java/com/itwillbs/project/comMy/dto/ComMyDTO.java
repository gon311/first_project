package com.itwillbs.project.comMy.dto;

import java.time.LocalDate;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@NoArgsConstructor
public class ComMyDTO {
	private Long userId; // 회원 ID
	private String userName; // 회원 이름
	private String email; // 이메일
	private String phone; // 전화번호
	private String userType; // 회원 상태 "P" or "C"
	
	// 기업 상세정보
	private String bizRegNo; // 사업자등록번호
	private String companyName; // 회사명
	private String ceoName; // 대표자명
	private String companyAddress; // 회사 주소
	private Integer passCount; // 신고/패스 관련 기존 컬럼 유지용

	// 이용권 정보
	private String payId; // 결제번호
	private String productId; // 상품번호
	private String productName; // 상품명
	private LocalDate startDate; // 이용 시작일
	private LocalDate endDate; // 이용 종료일
	private String useStatus; // active / expired

}

