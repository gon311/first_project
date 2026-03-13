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
	private String strJoinedAt;
	private String strWithDrawnAt; 
	
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
	
	public void setCountry(String country) {
		switch(country) {
		case "KR": this.country = "대한민국 (South Korea)"; break;
		case "US": this.country = "미국 (United States)"; break;
		case "JP": this.country = "일본 (Japan)"; break;
		case "CN": this.country = "중국 (China)"; break;
		case "VN": this.country = "베트남 (Vietnam)"; break;
		case "PH": this.country = "필리핀 (Philippines)"; break;
		case "TH": this.country = "태국 (Thailand)"; break;
		case "ID": this.country = "인도네시아 (Indonesia)"; break;
		case "CA": this.country = "캐나다 (Canada)"; break;
		case "AU": this.country = "호주 (Australia)"; break;
		case "GB": this.country = "영국 (United Kingdom)"; break;
		case "DE": this.country = "독일 (Germany)"; break;
		case "FR": this.country = "프랑스 (France)"; break;
		case "ETC": this.country = "기타 (Others)";
		}
	}
	
	public void setJoinedAt(LocalDateTime joinedAt) {
		this.joinedAt = joinedAt;
		
		if(joinedAt != null) { 
			this.strJoinedAt = joinedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		} 
	}
	
	public void setWithdrawnAt(LocalDateTime withdrawnAt) {
		this.withdrawnAt = withdrawnAt;
		
		if(withdrawnAt != null) { 
			this.strWithDrawnAt = withdrawnAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		} 
	}
	
}
