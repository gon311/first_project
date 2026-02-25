package com.itwillbs.project.common.exception;

// 특정 기능 접근 시 오류 메세지 후 뒤로 가기 처리를 수행할 예외 처리 클래스 정의
public class BackwardException extends RuntimeException {
	// 슈퍼클래스가 가진 String 타입 1개를 파라미터로 전달받는 생성자 상속받아 정의
	public BackwardException(String message) {
		super(message);
	}
	
}
