<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <c:set var="pageTitle" value="아이디 찾기 결과" />
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <style>
        .find-id-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 40px;
            border: 1px solid #e9ecef;
            border-radius: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .id-list-group {
            border: 1px solid #dee2e6;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 25px;
        }
        .id-item {
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }
        .id-item:last-child { border-bottom: none; }
        .id-item input[type="radio"] {
            width: 20px;
            height: 20px;
            accent-color: #198754; /* 네이버 스타일 초록색 */
        }
        .id-info { display: flex; align-items: center; }
        .user-icon { 
            background: #f1f3f5;
            border-radius: 50%;
            padding: 8px;
            margin-right: 15px;
            color: #adb5bd;
        }
        .btn-pw-find {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            color: #212529;
            padding: 12px;
        }
        .btn-login {
            background-color: #03c75a; /* 네이버 스타일 */
            border: none;
            color: white;
            padding: 12px;
        }
        .btn-login:hover { background-color: #02b14f; color: white; }
        .help-link {
            text-decoration: none;
            color: #868e96;
            font-size: 0.9rem;
            border-bottom: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jspf" %>

    <main class="container">
        <div class="find-id-container">
            <h3 class="fw-bold mb-2">아이디를 ${userIdList.size() }개 찾았어요</h3>
            <p class="text-muted mb-4">비밀번호를 잊으셨다면 아이디를 선택 후<br>'비밀번호 찾기'를 눌러 주세요.</p>

            <form action="<c:url value='/user/findPw' />" method="post">
                <div class="id-list-group">
					<c:forEach var="userId" items="${userIdList}">
						<label class="id-item w-100 m-0">
	                        <div class="id-info">
	                            <span class="user-icon">👤</span>
	                            <span class="fw-bold">${userId.email}</span>
	                        </div>
	                        <input type="radio" name="sId" value="${userId.email}">
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