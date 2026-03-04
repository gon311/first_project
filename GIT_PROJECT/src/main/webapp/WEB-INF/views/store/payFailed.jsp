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
            
<!--                     <div class="error-box text-start"> -->
<!--                         <div class="d-flex justify-content-between mb-3 border-bottom pb-2"> -->
<!--                             <span class="label-text">주문번호</span> -->
<%--                             <span class="value-text">${payment.orderId != null ? payment.orderId : '미발급'}</span> --%>
<!--                         </div> -->
<!--                         <div class="d-flex justify-content-between"> -->
<!--                             <span class="label-text">사유</span> -->
<%--                             <span class="value-text text-danger">${errorMessage != null ? errorMessage : '사용자 결제 취소 또는 타임아웃'}</span> --%>
<!--                         </div> -->
<!--                     </div> --> 
            
                    <div class="d-grid gap-3">
                        <button type="button" class="btn btn-dark btn-retry text-white" onclick="history.back();">
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

</body>
</html>