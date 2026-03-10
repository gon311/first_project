package com.itwillbs.project.comMy.dto;

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

}

