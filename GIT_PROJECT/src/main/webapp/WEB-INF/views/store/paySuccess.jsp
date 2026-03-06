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
	<link href="<c:url value="/resources/css/paySuccess.css" />" rel="stylesheet" type="text/css">
	
</head>
<body>

    <%@ include file="/WEB-INF/views/inc/header.jspf" %>
    
    <main>
        <div class="container">
            <div class="card shadow-sm payment-card">
                <div class="card-body text-center success-container">
                    
                    <div class="success-icon-wrapper">
                        <i class="bi bi-check-lg success-icon"></i>
                    </div>
            
                    <h3 class="fw-bold mb-3">결제가 성공적으로 완료되었습니다</h3>
                    <p class="text-secondary small">
                        결제 내역은 마이페이지에서 확인하실 수 있습니다.
                    </p>
            
                    <div class="d-grid gap-3">  <%-- 마이페이지 - 결제내역 연결 필요 --%>
                        <a href="<c:url value="/my/payment" />" class="btn btn-dark btn-main text-white text-decoration-none">
                            <i class="bi bi-receipt me-2"></i> 결제 내역 확인하기
                        </a>
            
                        <a href="<c:url value="/" />" class="btn btn-sub text-decoration-none">
                            메인페이지로 이동
                        </a>
                    </div>
            
                </div>
            </div>
        </div>                              
    </main>

    <%@ include file="/WEB-INF/views/inc/footer.jspf" %>
    
    <script>
		window.onload = function () {
			if (performance.navigation.type === 2) {
				window.history.forward();
			}
		};
    </script>

</body>
</html>