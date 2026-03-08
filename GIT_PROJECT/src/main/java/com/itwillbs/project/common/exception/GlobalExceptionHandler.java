package com.itwillbs.project.common.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// 전역 예외처리를 수행할 클래스 정의 => @ControllerAdvice 어노테이션 필수
@ControllerAdvice
public class GlobalExceptionHandler {
	
	// 로그인 안 함 => 로그인페이지로 리디렉션
	@ExceptionHandler(LoginRequiredException.class)
	public String handleLoginRequired(LoginRequiredException e, Model model) {
		// 모델 객체에 예외처리 과정에서 필요한 메세지 및 이동 방식과 이동할 주소 등을 저장
		model.addAttribute("msg", e.getMessage()); // 예외 발생 메세지 저장
		model.addAttribute("moveType", "redirect"); // 예외 처리 후 이동방식 저장
		model.addAttribute("url", "/user/login"); // 예외 처리 후 이동 url 저장
				
		//공통 에러 메세지 출력 jsp로 포워딩
		return "/common/alert"; 
	}
	
	// 요청처리 중 오류 발생 => 이전페이지로 돌아가기  
	@ExceptionHandler(BackwardException.class)
	public String handleBackward(BackwardException e, Model model) {
		// 모델 객체에 예외처리 과정에서 필요한 메세지 및 이동 방식과 이동할 주소 등을 저장
		model.addAttribute("msg", e.getMessage()); // 예외 발생 메세지 저장
		model.addAttribute("moveType", "back"); // 예외 처리 후 이동방식 저장
		
		//공통 에러 메세지 출력 jsp로 포워딩
		return "/common/alert"; 
	}
	
	// 그 외 모든 예외 공통 처리 
	@ExceptionHandler(Exception.class)
	public String handleEtc(Exception e) {
		e.printStackTrace();
		// 나머지 모든 에러 => /common/error.jsp로 포워딩
		return "/common/error"; 
	}
	
	
}
