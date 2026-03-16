package com.itwillbs.project.common.util;

import java.util.Properties;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
public class MailClient {
	// application.properties 파일 내의 메일 관련 속성값 가져오기
	@Value("${mail.sender_address}")
	private String senderAddress;
	// -----------------------------------------
	// MailClient 클래스 기본 생성자를 통해 JavaMailSender 객체 생성하여 저장
	private JavaMailSender mailSender;
	
	public MailClient(@Value("${mail.host}") String host,
						@Value("${mail.port:587}") int port,
						@Value("${mail.username}") String username,
						@Value("${mail.password}") String password) {
		System.out.println("생성자 호출됨!");
		// 메일 발송에 필요한 JavaMailSender 객체 생성을 위한 JavaMailSenderImple 객체 생성 및 값 설정
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		System.out.println("host : " + host);
		System.out.println("port : " + port);
		System.out.println("username : " + username);
		
		// 메일 발송에 사용할 서버 정보 설정
		sender.setHost(host);
		sender.setPort(port);
		sender.setUsername(username);
		sender.setPassword(password);
		
		// java.util.Properties 객체 가져오기(메일 서버 추가 정보 설정용 값 관리할 객체)
		Properties props = sender.getJavaMailProperties();
		// 메일 서버 사용하기 위해 인증이 필요하므로 "mail.smtp.auth" 속성값을 "true" 설정
		props.put("mail.smtp.auth", "true");
		// 인증에 사용되는 프로토콜을 TLS 프로토콜로 설정
		props.put("mail.smtp.starttls.enable", "true");
		// TLS 프로토콜 버전 설정
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		// JavaMailSender 타입 필드에 JavaMailSenderImpl 객체 저장(업캐스팅)
		mailSender = sender;
	}

	// ====================================================================
	// 메일 발송 작업을 처리하는 sendMail() 메서드 정의
	public void sendMail(String receiverAddress, String subject, String content, String authCode) {
		try {
			// 메일 발송을 위한 내용 설정
			// 1. 메일 내용을 관리할 MimeMessage 객체 가져오기(JavaMailSender 객체로부터 리턴받아 사용)
			MimeMessage message = mailSender.createMimeMessage();
			
			// 2. MimeMessage 객체 설정을 도와주는 MimeMessageHelper 객체 생성
			// => 첫번째 파라미터 : MimeMessage 객체
			// => 두번째 파라미터 : 멀티파트(Multipart) 사용 여부(false : 단순 텍스트, true : HTML 이나 첨부파일 사용 가능)
			// => 세번째 파라미터 : 인코딩 방식
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 3. MimeMessageHelper 객체를 활용하여 발송할 메일의 정보 전달
			// 3-1) 발신자 정보
			helper.setFrom(senderAddress, "아이티윌"); // 발신자 주소와 발신자 이름(메일에 표시됨) 전달
			// => 주의! 기본적으로 상용 메일 서비스에서는 발신자 메일 주소 변경이 불가능(= 스팸정책 때문)
			//    따라서, 다른 주소를 입력하더라도 실제 메일 발신자는 SMTP 서버 로그인 한 계정으로 발송됨
			//    참고) 네이버는 발신자 주소 강제 변경 시 실행 예외 발생함
			
			// 3-2) 수신자 정보
			// => 메일 수신자 지정 방법 3가지
			//    a) to : 수신자에게 직접 전송(메일을 직접 수신할 수신자 = 업무 담당자)
			//    b) cc : 참조(Carbon Copy 약자). 직접 수신자는 아니나 업무 참조용 수신자(= 업무 관계자)
			//    c: bcc : 숨은 참조(Blind CC 약자). 메일 수신자가 CC 여부를 알 수 없게 참조 수신자를 숨김
			helper.setTo(receiverAddress);
//			helper.setCc("업무 관계자 메일 주소");
//			helper.setBcc("숨김 참조 메일 주소");
			// 3-4) 제목
			helper.setSubject(subject);
			// 3-5) 본문
			helper.setText(content);
			
			// 4. 메일 발송
			mailSender.send(message);
			log.info("메일 발송 성공!");
			
		} catch (Exception e) {
			log.info("메일 발송 실패!");
			e.printStackTrace();
		}
		
	}

}









