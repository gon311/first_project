package com.itwillbs.project.common.exception;

// 로그인하지 않은 사용자가 특정 기능 접근 시 예외 처리 클래스 정의
public class LoginRequiredException extends RuntimeException {
	// 슈퍼클래스가 가진 String 타입 1개를 파라미터로 전달받는 생성자 상속받아 정의
	public LoginRequiredException(String message) {
		super(message);
	}
	
}
