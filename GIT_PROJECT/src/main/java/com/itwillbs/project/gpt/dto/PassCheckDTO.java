package com.itwillbs.project.gpt.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PassCheckDTO {
	private Long userId;		// 유저 번호 (user_product)
	private int passCount; //패스권 개수 (USER_PERSON)
	private int remainingCount; // 남은 패스권 개수 (user_product) 
	private String useStatus ;	// 패스권 사용 상태 'active', 'expired' 
	
}
