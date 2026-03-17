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
	
	<c:choose>
		<c:when test="${sessionScope.userType eq 'C'}">
		    <%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>
		</c:when>
		<c:otherwise>
		    <%@ include file="/WEB-INF/views/inc/header.jspf" %>
		</c:otherwise>
	</c:choose>
    
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
            
                    <div class="d-grid gap-3"> 
                        <a id="checkPayment" class="btn btn-dark btn-main text-white text-decoration-none">
                            <i class="bi bi-receipt me-2"></i> 결제 내역 확인하기
                        </a>
            
                        <a id="goToMain" class="btn btn-sub text-decoration-none">
                            메인페이지로 이동
                        </a>
                    </div>
            
                </div>
            </div>
        </div>                              
    </main>

    <%@ include file="/WEB-INF/views/inc/footer.jspf" %>
    
    <script>
		const userType = "${sessionScope.userType}";
		
	    // 페이지 로드 시 현재 상태를 히스토리에 한 번 더 쌓음
		history.pushState(null, null, location.href);
		
		window.onpopstate = function() {
		    // 뒤로가기 감지 시 메인페이지로 강제 이동
		    alert("잘못된 접근입니다.");
		    if(userType === "C") {
			    location.replace("<c:url value='/mainCom' />"); 
			} else {
			    location.replace("<c:url value='/' />"); 
			}
		};
		
		document.getElementById("checkPayment").addEventListener("click", function() {
			if(userType === "C") {
				location.href="<c:url value="/comMy/payment" />" ;
			} else {
				location.href="<c:url value="/my/payment" />" ;
			}
		});
		
		document.getElementById("goToMain").addEventListener("click", function() {
			if(userType === "C") {
				location.href="<c:url value="/mainCom" />" ;
			} else {
				location.href="<c:url value="/" />" ;
			}
		});
    </script>

</body>
</html>