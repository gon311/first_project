package com.itwillbs.project.common.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// 전역 예외 처리를 공통으로 수행할 클래스 정의 => @ControllerAdvice 어노테이션 필수!
@ControllerAdvice
// => 이 어노테이션은 예외 처리 전용 어노테이션은 아니고, 컨트롤러 전반에 걸쳐 공통 로직(예외처리, 바인딩, 모델 설정 등)을 적용하는 어드바이저
public class GlobalExceptionHandler {
	// @ExceptionHandler 어노테이션을 사용하여 처리할 예외 처리 클래스 지정 및 예외 처리 메서드 정의
	// => 기본 문법 : @ExceptionHandler(xxxException.class)
	// => 파라미터 : 예외 처리 클래스(필수), 필요에 따라 Model 타입 등을 선언
	//-------------------------------------------------------------------------------
	// 로그인 안 함 => 로그인 페이지로 리디렉션
	@ExceptionHandler(LoginRequiredException.class)
	public String handleLoginRequired(LoginRequiredException e, Model model) {
		// Model 객체에 예외 처리 과정에서 필요한 메세지 및 이동 방식과 이동할 주소 저장
		model.addAttribute("msg", e.getMessage()); 	// 예외 발생 메세지 저장
		model.addAttribute("moveType", "redirect"); // 예외 처리 후 이동 방식 저장
		model.addAttribute("url", "/user/login"); // 예외 처리 후 이동 URL 저장
		
		//------------------------------------------------------------------
		// 공통 에러 메세지 출력에 필요한 /common/alert.jsp 페이지로 포워딩
		return "/common/alert";
	}
	
	// 요청 처리 중 오류 발생 => 이전페이지로 돌아가기
	@ExceptionHandler(BackwardException.class)
	public String handleBackward(BackwardException e, Model model) {
		// Model 객체에 예외 처리 과정에서 필요한 메세지 및 이동 방식과 이동할 주소 저장
		model.addAttribute("msg", e.getMessage()); 	// 예외 발생 메세지 저장
		model.addAttribute("moveType", "back"); 	// 예외 처리 후 이동 방식 저장
		// 뒤로 가기 처리 용도는 url 불필요
		//------------------------------------------------------------------
		// 공통 에러 메세지 출력에 필요한 /common/alert.jsp 페이지로 포워딩
		return "/common/alert";
	}
	
	
	//--------------------------------------------------------------------------------------
	// 옵션) 그 외의 모든 예외 공통 처리
//	@ExceptionHandler(Exception.class)
//	public String handleEtc(Exception e) {
//		e.printStackTrace();
//		//------------------------------------------------------------------
//		// 나머지 모든 에러 메세지 출력에 필요한 /common/error.jsp 페이지로 포워딩
//		return "/common/error";
//	}
	
	
	
}
