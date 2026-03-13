<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <%-- 현재 페이지 전용 CSS 영역--%>
	<link href="<c:url value="/resources/css/payInfo.css" />" rel="stylesheet" type="text/css">
</head>
<body>
    <%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

    <main class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                
                <h4 class="fw-bold mb-4 text-dark">
                    <i class="bi bi-receipt me-2"></i>결제 상세 정보
                </h4>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-dark text-white py-3">
                        <h5 class="mb-0 fs-6">결제 번호 : <span class="fw-normal">${pay.payId}</span></h5>
                    </div>
                    
                    <div class="card-body p-4">
                        <h6 class="fw-bold border-start border-4 border-primary ps-2 mb-4">결제 정보</h6>
                        
                        <dl class="row mb-4">
                            <dt class="col-5 text-dark py-2 ps-3 small text-uppercase">아이디</dt>
                            <dd class="col-7 py-2">${pay.userId}</dd>
                            
                            <dt class="col-5 text-dark py-2 ps-3 small text-uppercase">이름</dt>
                            <dd class="col-7 py-2">${pay.userName}</dd>

                            <dt class="col-5 text-dark py-2 ps-3 small text-uppercase">전화번호</dt>
                            <dd class="col-7 py-2">${pay.phone}</dd>

                            <dt class="col-5 text-dark py-2 ps-3 small text-uppercase">회원유형</dt>
                            <dd class="col-7 py-2">
                                ${pay.userType}
                            </dd>

                            <dt class="col-5 text-dark py-2 ps-3 small text-uppercase">결제 상품명</dt>
                            <dd class="col-7 py-2">${pay.productName}</dd>

                            <dt class="col-5 text-dark py-2 ps-3 small text-uppercase">결제금액</dt>
                            <dd class="col-7 py-2">
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${pay.payPrice}" />원
                            </dd>

                            <dt class="col-5 text-dark py-2 ps-3 small text-uppercase">결제상태</dt>
                            <dd class="col-7 py-2">
                                <c:choose>
                                    <c:when test="${pay.payStatus eq 'paid'}">
                                        결제완료
                                    </c:when>
                                    <c:otherwise>
                                        결제취소
                                    </c:otherwise>
                                </c:choose>
                            </dd>
                        </dl>

                        <h6 class="fw-bold border-start border-4 border-primary ps-2 mb-4">상세 내역</h6>
                        
                        <dl class="row mb-0">
                            <dt class="col-5 text-dark py-2 ps-3 small text-uppercase">결제수단</dt>
                            <dd class="col-7 py-2">
	                            <i class="bi bi-credit-card me-1">${pay.payMethod} / ${pay.cardName}</i> 
	                            <div class="text-secondary small mt-1">(${pay.cardNum})</div>
                            </dd>

                            <dt class="col-5 text-dark py-2 ps-3 small text-uppercase">결제일시</dt>
                            <dd class="col-7 py-2 text-secondary">
                            	${pay.strPayDate}
                            </dd>
                        </dl>

                        <hr class="my-4">

                        <div class="text-end">
                            <c:choose>
                                <c:when test="${pay.payStatus eq 'cancelled'}">
                                    <button type="button" class="btn btn-sm btn-secondary" disabled>결제 취소</button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn btn-sm btn-danger px-3" onclick="payCancel(${pay.payId})">
                                        <i class="bi bi-x-circle me-1"></i> 결제 취소
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-3">
                    <a href="<c:url value="/admin/payments" />" class="btn btn-outline-dark px-5 py-2">
                        <i class="bi bi-list me-2"></i>목록으로
                    </a>
                </div>

            </div>
        </div>
    </main> 

    <script>
        function payCancel(payId) {
            if(confirm("해당 결제 건을 취소하시겠습니까?")) {
                location.href="<c:url value='/admin/payments/cancel' />" + "?payId=" + payId; 
            }
        }
    </script>
</body>
</html>