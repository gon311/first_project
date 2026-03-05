<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

	<main class="container mt-4 mb-5">

		<h2 class="mb-4">결제 정보</h2>

		<div class="row justify-content-center">
			<div class="col-lg-6">

				<div class="card shadow-sm">
					<div class="card-header bg-white border-bottom">
						<h5 class="mb-0 fw-bold">결제 상세</h5>
					</div>
					<div class="card-body px-4 py-4">

						<dl class="row mb-0">

							<dt class="col-5 text-secondary py-2">결제번호</dt>
							<dd class="col-7 py-2">${pay.payId}</dd>

							<dt class="col-5 text-secondary py-2">아이디</dt>
							<dd class="col-7 py-2">${pay.userId}</dd>

							<dt class="col-5 text-secondary py-2">이름</dt>
							<dd class="col-7 py-2">${pay.userName}</dd>

							<dt class="col-5 text-secondary py-2">전화번호</dt>
							<dd class="col-7 py-2">${pay.phone}</dd>

							<dt class="col-5 text-secondary py-2">회원유형</dt>
							<dd class="col-7 py-2">${pay.userType}</dd>

							<dt class="col-5 text-secondary py-2">결제일시</dt>
							<dd class="col-7 py-2">
								<fmt:parseDate var="payDate" value="${pay.payDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
								<fmt:formatDate value="${payDate}" pattern="yyyy년 MM월 dd일 HH:mm:ss" />
							</dd>

							<dt class="col-5 text-secondary py-2">결제 상품명</dt>
							<dd class="col-7 py-2">${pay.productName}</dd>

							<dt class="col-5 text-secondary py-2">결제수단</dt>
							<dd class="col-7 py-2">${pay.payMethod}/${pay.cardName} <small class="text-secondary">(${pay.cardNum})</small> </dd>

							<dt class="col-5 text-secondary py-2">결제금액</dt>
							<dd class="col-7 py-2">
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${pay.payPrice}" /> 원
							</dd>

							<dt class="col-5 text-secondary py-2">결제상태</dt>
							<dd class="col-7 py-2">
								<c:choose>
									<c:when test="${pay.payStatus eq 'paid'}">
										결제완료
									</c:when>
									<c:when test="${pay.payStatus eq 'ready'}">
										입금대기
									</c:when>
									<c:otherwise>
										결제취소
									</c:otherwise>
								</c:choose>
							</dd>

						</dl>

						<div class="text-end mt-4">
							<c:choose>
								<c:when test="${pay.payStatus eq 'cancelled'}">
									<button type="button" id="cancel" class="btn btn-danger" disabled="disabled">
										결제 취소
									</button>
								</c:when>
								<c:otherwise>
									<button type="button" id="cancel" class="btn btn-danger" onclick="payCancel(${pay.payId})">
										결제 취소
									</button>
								</c:otherwise>
							</c:choose>
						</div>

					</div>
				</div>

			</div>
		</div>
		
		<!-- 하단 중앙 목록 버튼 -->
		<div class="text-center mt-5">
			<a href="<c:url value="/admin/payments" />" class="btn btn-outline-dark px-4">
				목록으로
			</a>
		</div>

	</main>

	<script>
		function payCancel(payId) {
			if(confirm("결제를 취소하시겠습니까?")) {
				location.href="<c:url value='/admin/payments/cancel' />" + "?payId=" + payId; 
			}
		}
	</script>

</body>
</html>