<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/comMyCss/info.css'/>" type="text/css">
</head>

<body>
<%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>

<c:url var="urlPassword" value="/comMy/password"/>
<c:url var="urlUpdateInfo" value="/comMy/updateInfo"/>
<c:url var="urlUserDelete" value="/my/user/delete"/>

<main class="container-fluid px-0 mypage-wrap">
	<div class="row g-0">

		<%@ include file="/WEB-INF/views/inc/comMySidebar.jspf" %>

		<section class="col-10 myContent">
			<div class="myContent-inner">

				<div class="d-flex justify-content-between align-items-start gap-3 mb-3">
					<div>
						<h2 class="page-title">내 정보</h2>
						<div class="page-desc">회원 기본 정보를 확인하고 수정할 수 있어요.</div>
					</div>

					<div class="top-actions d-flex gap-2">
						<a class="btn btn-outline-secondary" href="${urlPassword}">비밀번호 변경</a>
						<a class="btn btn-primary" href="${urlUpdateInfo}">내 정보 수정</a>
						<button type="button" class="btn btn-danger" onclick="userDelete()">회원 탈퇴</button>
					</div>
				</div>

				<c:if test="${not empty msg}">
					<div class="alert alert-info mb-3" role="alert">
						${msg}
					</div>
				</c:if>

				<div class="info-grid">
					<div class="info-card">
						<div class="info-label">담당자명</div>
						<div class="info-value">${loginUser.userName}</div>
					</div>

					<div class="info-card">
						<div class="info-label">이메일</div>
						<div class="info-value">${loginUser.email}</div>
					</div>

					<div class="info-card">
						<div class="info-label">전화번호</div>
						<div class="info-value">${loginUser.phone}</div>
					</div>

					<div class="info-card">
						<div class="info-label">회원유형</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${loginUser.userType == 'P'}">개인회원</c:when>
								<c:when test="${loginUser.userType == 'C'}">기업회원</c:when>
								<c:when test="${loginUser.userType == 'A'}">관리자</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="info-card">
						<div class="info-label">회사명</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${not empty loginUser.companyName}">
									${loginUser.companyName}
								</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="info-card">
						<div class="info-label">대표자명</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${not empty loginUser.ceoName}">
									${loginUser.ceoName}
								</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="info-card">
						<div class="info-label">사업자등록번호</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${not empty loginUser.bizRegNo}">
									${loginUser.bizRegNo}
								</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="info-card info-card-wide">
						<div class="info-label">회사 주소</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${not empty loginUser.companyAddress}">
									${loginUser.companyAddress}
								</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<div class="ticket-box">
					<div class="ticket-box-head">
						<div>
							<h3 class="ticket-title">보유 이용권</h3>
							<p class="ticket-desc">현재 사용 중인 기업 이용권 정보를 확인할 수 있습니다.</p>
						</div>

						<div class="ticket-status-wrap">
							<c:choose>
								<c:when test="${loginUser.useStatus eq 'active'}">
									<span class="ticket-badge active">사용중</span>
								</c:when>
								<c:when test="${loginUser.useStatus eq 'expired'}">
									<span class="ticket-badge expired">만료</span>
								</c:when>
								<c:otherwise>
									<span class="ticket-badge empty">없음</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="ticket-card-main">
						<div class="ticket-card-left">
							<div class="ticket-label">현재 이용권</div>
							<div class="ticket-product">
								<c:choose>
									<c:when test="${not empty loginUser.productName}">
										${loginUser.productName}
									</c:when>
									<c:otherwise>이용권 없음</c:otherwise>
								</c:choose>
							</div>
							<div class="ticket-subtext">현재 사용 중인 대표 이용권입니다.</div>

							<div class="ticket-count-box period-box">
								<div class="ticket-count-label">이용 기간</div>
								<div class="ticket-period-date">
									<c:choose>
										<c:when test="${not empty loginUser.startDate}">
											${loginUser.startDate}
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</div>
								<div class="ticket-period-sep">~</div>
								<div class="ticket-period-date">
									<c:choose>
										<c:when test="${not empty loginUser.endDate}">
											${loginUser.endDate}
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>

						<div class="ticket-card-right">
							<div class="ticket-info-card">
								<div class="ticket-info-title">이용 안내</div>
								<div class="ticket-info-text">
									<c:choose>
										<c:when test="${loginUser.useStatus eq 'active'}">
											현재 기업 이용권이 활성화되어 있습니다.<br>
											이용 기간 내 채용 서비스를 정상적으로 사용할 수 있습니다.
										</c:when>
										<c:when test="${loginUser.useStatus eq 'expired'}">
											이용 기간이 종료되어 현재 이용권이 만료되었습니다.<br>
											계속 사용하려면 새 이용권을 구매해주세요.
										</c:when>
										<c:otherwise>
											현재 등록된 기업 이용권이 없습니다.<br>
											이용권 구매 후 서비스를 사용할 수 있습니다.
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>

					<div class="ticket-guide">
						<c:choose>
							<c:when test="${loginUser.useStatus eq 'active'}">
								이용 기간 내 기업 서비스 이용이 가능합니다.
							</c:when>
							<c:when test="${loginUser.useStatus eq 'expired'}">
								이용 기간이 종료되어 추가 이용권 구매가 필요합니다.
							</c:when>
							<c:otherwise>
								현재 등록된 이용권 정보가 없습니다.
							</c:otherwise>
						</c:choose>
					</div>
				</div>

			</div>
		</section>

	</div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
	function userDelete() {
		if (confirm("정말 탈퇴하시겠습니까?")) {
			location.href = "${urlUserDelete}";
		}
	}
</script>
</body>
</html>