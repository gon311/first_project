package com.itwillbs.project.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.common.util.MailClient;
import com.itwillbs.project.user.dto.MailAuthInfo;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class MailService {
	@Autowired
	private MailClient mailClient;
	
	// 인증메일 발송 요청 메서드
	public MailAuthInfo sendAuthMail(String email, String authCode) {

		String subject = "[아이티윌] 가입 인증 메일입니다.";
		
		String url = "http://localhost:8080/mvc_board/member/mailAuth?email=" + email + "&authCode=" + authCode;
		String content = "<a href=\"" + url + "\">이메일 인증을 수행하려면 이 링크를 클릭하세요!</a>"
						+ "\n\n인증 코드 : " + authCode;
		// ------------------------------------------------------
		// MailClient - sendMail() 메서드 호출하여 메일 발송 요청
		// => 파라미터 : 수신자 메일주소, 제목, 본문
		mailClient.sendMail(email, subject, content, authCode);
		
		return null;
	}

}




















