package com.itwillbs.project.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        
        String userType = (String) session.getAttribute("userType"); 

        // 2. 관리자 아이디가 없거나 관리자가 아니라면 차단
        if (userType == null || !userType.equals("A")) { 
            // 에러 메시지와 함께 로그인 페이지로 리다이렉트
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('관리자만 접근 가능합니다.'); location.href='/project/user/login';</script>");
            return false; // 요청 중단
        }

        return true; // 관리자라면 통과!
    }
}