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

<%-- 수정 URL들 --%>
<c:url var="urlPassword" value="/comMy/password"/>
<c:url var="urlUpdateInfo" value="/comMy/updateInfo"/>
<c:url var="urlUserDelete" value="/my/user/delete"/>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 사이드바 include --%>
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
            <div class="info-label">이름</div>
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
                <c:when test="${loginUser.userType == 'P'}">개인</c:when>
                <c:when test="${loginUser.userType == 'C'}">기업</c:when>
                <c:when test="${loginUser.userType == 'A'}">관리자</c:when>
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

<script>
	function userDelete() {
		if(confirm("정말 탈퇴하시겠습니까?")) {
			location.href="${urlUserDelete}"
		}
	}
</script>
</body>
</html>

