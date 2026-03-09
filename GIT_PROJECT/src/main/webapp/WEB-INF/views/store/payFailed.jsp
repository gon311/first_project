<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
    <%-- 현재 페이지 전용 CSS 영역--%>
	<link href="<c:url value="/resources/css/payFailed.css" />" rel="stylesheet" type="text/css">
	
	<script>history.replaceState(null, '', 'payFailed');</script>

</head>
<body>

    <%@ include file="/WEB-INF/views/inc/header.jspf" %>
    
    <main>
        <div class="container">
            <div class="card shadow-sm payment-card">
                <div class="card-body text-center fail-container">
                    
                    <div class="fail-icon-wrapper">
                        <i class="bi bi-exclamation-circle-fill fail-icon"></i>
                    </div>
            
                    <h3 class="fw-bold mb-2">결제가 중단되었습니다</h3>
                    <p class="text-secondary small">
                        결제 과정에서 문제가 발생하여 처리가 완료되지 않았습니다.
                    </p>
            
                    <div class="d-grid gap-3">
                        <button type="button" class="btn btn-dark btn-retry text-white" onclick="window.history.go(-2)">
                            <i class="bi bi-arrow-clockwise me-2"></i> 다시 결제 시도하기
                        </button>
            
                        <a href="<c:url value="/" />" class="btn btn-home bg-white">
                            홈으로 돌아가기
                        </a>
                    </div>
            
                    <div class="mt-5 border-top pt-4">
                        <p class="small text-muted mb-0">
                            도움이 필요하신가요? <a href="#" class="text-decoration-none fw-bold text-dark">고객센터 문의하기</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>                              
    </main>

    <%@ include file="/WEB-INF/views/inc/footer.jspf" %>
    
    <script>
	    // 페이지 로드 시 현재 상태를 히스토리에 한 번 더 쌓음
		history.pushState(null, null, location.href);
		
		window.onpopstate = function() {
		    // 뒤로가기 감지 시 메인페이지로 강제 이동
		    alert("잘못된 접근입니다.");
		    location.replace("<c:url value='/' />"); 
		};
    </script>

</body>
</html>