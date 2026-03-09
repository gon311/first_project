<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    
    <%-- 현재 페이지 전용 CSS 영역--%>
	<link href="<c:url value="/resources/css/error.css" />" rel="stylesheet" type="text/css">
	
</head>
<body>

    <main class="container">
        <div class="error-container mx-auto text-center">
            <div class="error-icon mb-4">
                <i class="bi bi-exclamation-triangle-fill"></i>
            </div>
            
            <h2 class="fw-bold mb-3">시스템 오류가 발생했습니다.</h2>
            
            <p class="text-secondary mb-4">
                불편을 드려 죄송합니다.<br>
                일시적인 오류일 수 있으니 잠시 후 다시 시도해 주세요.
            </p>

            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                <a href="<c:url value='/' />" class="btn btn-primary btn-lg px-4 gap-3">
                    홈으로 돌아가기
                </a>
                <button type="button" onclick="history.back();" class="btn btn-outline-secondary btn-lg px-4">
                    이전 페이지
                </button>
            </div>
        </div>
    </main>
    
</body>
</html>