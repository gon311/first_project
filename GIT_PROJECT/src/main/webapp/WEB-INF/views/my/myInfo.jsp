<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/my/myInfo.css'/>" type="text/css">
</head>

<c:url var="urlUpdateInfo" value="/my/updateInfo"/>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<main class="container-fluid px-0 mypage-wrap">
	<div class="row g-0">

		<%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

		<section class="col-10 myContent">
			<div class="myContent-inner">

				<div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
					<div>
						<h2 class="page-title">내 정보</h2>
						<p class="page-desc">회원 기본 정보를 확인할 수 있습니다.</p>
					</div>

					<div class="top-actions">
						<a href="${urlUpdateInfo}" class="btn btn-primary">정보 수정</a>
					</div>
				</div>

				<div class="info-grid">

					<div class="info-card">
						<div class="info-label">이름</div>
						<div class="info-value">${loginUser.userName}</div>
					</div>

					<div class="info-card">
						<div class="info-label">성별</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${loginUser.gender eq 'M'}">남성</c:when>
								<c:when test="${loginUser.gender eq 'F'}">여성</c:when>
								<c:when test="${loginUser.gender eq 'N'}">선택 안 함</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="info-card">
						<div class="info-label">이메일</div>
						<div class="info-value">${loginUser.email}</div>
					</div>

					<div class="info-card">
						<div class="info-label">휴대전화</div>
						<div class="info-value">${loginUser.phone}</div>
					</div>

					<div class="info-card">
						<div class="info-label">생년월일</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${not empty loginUser.birthDate}">
									${loginUser.birthDate}
								</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="info-card">
						<div class="info-label">국적</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${empty loginUser.country or loginUser.country eq 'KR'}">대한민국</c:when>
								<c:when test="${loginUser.country eq 'US'}">미국</c:when>
								<c:when test="${loginUser.country eq 'JP'}">일본</c:when>
								<c:when test="${loginUser.country eq 'CN'}">중국</c:when>
								<c:when test="${loginUser.country eq 'TW'}">대만</c:when>
								<c:when test="${loginUser.country eq 'HK'}">홍콩</c:when>
								<c:when test="${loginUser.country eq 'SG'}">싱가포르</c:when>
								<c:when test="${loginUser.country eq 'TH'}">태국</c:when>
								<c:when test="${loginUser.country eq 'VN'}">베트남</c:when>
								<c:when test="${loginUser.country eq 'PH'}">필리핀</c:when>
								<c:when test="${loginUser.country eq 'MY'}">말레이시아</c:when>
								<c:when test="${loginUser.country eq 'ID'}">인도네시아</c:when>
								<c:when test="${loginUser.country eq 'IN'}">인도</c:when>
								<c:when test="${loginUser.country eq 'AU'}">호주</c:when>
								<c:when test="${loginUser.country eq 'NZ'}">뉴질랜드</c:when>
								<c:when test="${loginUser.country eq 'CA'}">캐나다</c:when>
								<c:when test="${loginUser.country eq 'GB'}">영국</c:when>
								<c:when test="${loginUser.country eq 'FR'}">프랑스</c:when>
								<c:when test="${loginUser.country eq 'DE'}">독일</c:when>
								<c:when test="${loginUser.country eq 'IT'}">이탈리아</c:when>
								<c:when test="${loginUser.country eq 'ES'}">스페인</c:when>
								<c:when test="${loginUser.country eq 'NL'}">네덜란드</c:when>
								<c:when test="${loginUser.country eq 'SE'}">스웨덴</c:when>
								<c:when test="${loginUser.country eq 'CH'}">스위스</c:when>
								<c:when test="${loginUser.country eq 'RU'}">러시아</c:when>
								<c:when test="${loginUser.country eq 'BR'}">브라질</c:when>
								<c:when test="${loginUser.country eq 'MX'}">멕시코</c:when>
								<c:when test="${loginUser.country eq 'AR'}">아르헨티나</c:when>
								<c:when test="${loginUser.country eq 'ZA'}">남아프리카공화국</c:when>
								<c:when test="${loginUser.country eq 'AE'}">아랍에미리트</c:when>
								<c:when test="${loginUser.country eq 'SA'}">사우디아라비아</c:when>
								<c:when test="${loginUser.country eq 'TR'}">튀르키예</c:when>
								<c:when test="${loginUser.country eq 'EG'}">이집트</c:when>
								<c:when test="${loginUser.country eq 'ETC'}">기타</c:when>
								<c:otherwise>${loginUser.country}</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="info-card">
						<div class="info-label">회원유형</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${loginUser.userType eq 'P'}">개인회원</c:when>
								<c:when test="${loginUser.userType eq 'C'}">기업회원</c:when>
								<c:when test="${loginUser.userType eq 'A'}">관리자</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</div>
					</div>

				</div>

			</div>
		</section>

	</div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>