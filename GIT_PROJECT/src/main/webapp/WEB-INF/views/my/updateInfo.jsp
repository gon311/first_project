<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/my/updateInfo.css'/>" type="text/css">
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<!-- URL수정 -->
<c:url var="urlUpdateInfo" value="/my/updateInfo"/>   <%-- POST 처리 URL --%>
<c:url var="urlMyInfo" value="/my/myInfo"/>           <%-- 취소/뒤로가기 필요시 --%>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 왼쪽 사이드바(inc) --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 오른쪽 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">내 정보 수정</h2>
        <div class="page-desc">회원 정보를 수정하고 저장할 수 있어요.</div>
        
		<c:if test="${not empty errorMsg}">
			<div class="alert alert-danger mb-3">${errorMsg}</div>
		</c:if>

        <form action="${urlUpdateInfo}" method="post">

          <div class="form-grid">

            <div>
              <div class="field-label">이메일</div>
              <input type="email" class="form-control" name="email"
                     value="${loginUser.email}" readonly />
            </div>

            <div>
              <div class="field-label">이름</div>
              <input type="text" class="form-control" name="userName"
                     value="${loginUser.userName}"
                     required pattern="^[가-힣a-zA-Z\s]{2,20}$"
                     title="이름은 한글/영문 2~20자만 입력하세요." />        
            </div>

            <div class="form-row-full">
              <div class="field-label">전화번호</div>
              <input type="text" class="form-control" name="phone"
                     value="${loginUser.phone}"
                      required pattern="^01[0-9]-\d{3,4}-\d{4}$"
                      title="전화번호는 010-1234-5678 형식으로 입력하세요." />
            </div>

          </div>

          <div class="form-actions">
            <a class="danger-link" href="#">계정 삭제</a>
            <button type="submit" class="btn btn-save">저장하기</button>
          </div>

        </form>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

</body>
</html>

