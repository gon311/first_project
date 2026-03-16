<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <c:set var="pageTitle" value="아이디 찾기 결과" />
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <link href="<c:url value="/resources/css/user/userFindId.css" />" rel="stylesheet" type="text/css">
</head>
<body>
	<c:choose>
	    <c:when test="${sessionScope.memberType == 'company'}">
	        <%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>
	    </c:when>
	
	    <c:otherwise>
	        <%@ include file="/WEB-INF/views/inc/header.jspf" %>
	    </c:otherwise>
	</c:choose>

    <main class="container">
        <div class="find-id-container">
            <h3 class="fw-bold mb-2">아이디를 ${userIdList.size() }개 찾았어요</h3>
            <p class="text-muted mb-4">비밀번호를 잊으셨다면 아이디를 선택 후<br>'비밀번호 찾기'를 눌러 주세요.</p>

            <form action="<c:url value='/user/findPw' />" method="get">
                <div class="id-list-group">
					<c:forEach var="userId" items="${userIdList}">
						<label class="id-item w-100 m-0">
	                        <div class="id-info">
	                            <span class="user-icon">👤</span>
	                            <span class="fw-bold">${userId.email}</span>
	                        </div>
	                        <input type="radio" name="email" value="${userId.email}">
	                    </label>
					</c:forEach>
                </div>

                <div class="row g-2">
                    <div class="col-6">
                        <button type="submit" class="btn btn-pw-find w-100 fw-bold">비밀번호 찾기</button>
                    </div>
                    <div class="col-6">
                        <a href="<c:url value='/user/login' />" class="btn btn-login w-100 fw-bold">로그인하러 가기</a>
                    </div>
                </div>
            </form>

            <div class="mt-4">
                <a href="#" class="help-link">도움이 필요하신가요?</a>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>