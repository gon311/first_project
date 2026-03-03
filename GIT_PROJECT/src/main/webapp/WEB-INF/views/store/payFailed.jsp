<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .payment-success-container {
            max-width: 500px;
            margin: 100px auto;
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        .btn-group {
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jspf" %>

    <div class="payment-success-container">
	    <h1 class="text-success mb-3">결제를 실패했습니다!</h1>
	    <p class="mb-4">결제 중 오류가 발생하였습니다.</p>
	
	    <div class="btn-group">
	        <button type="button" class="btn btn-danger" onclick="history.back();">이전으로</button>
<%-- 	        <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/myPayments';">내 결제내역</button> --%>
	    </div>
	</div>
    
    <%-- footer area --%>
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>