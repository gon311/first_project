<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/comMyCss/password.css'/>" type="text/css">
<script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<c:url var="urlSubmit" value="/my/password"/>
<c:url var="urlCancel" value="/my/myInfo"/>

<main class="container pw-wrap">
  <div class="row justify-content-center w-100">
    <div class="col-12 col-md-7 col-lg-5">

      <div class="pw-card">
        <div class="mb-3">
          <h2 class="page-title">비밀번호 변경</h2>
          <div class="page-desc">안전한 비밀번호로 계정을 보호하세요.</div>
          <ul class="hint-list">
            <li>영문/숫자/특수문자를 섞어주세요</li>
          </ul>
        </div>

        <%-- 서버에서 flash/message 내려오면 표시용(선택) --%>
        <c:if test="${not empty msg}">
          <div class="alert alert-info mb-3" role="alert">${msg}</div>
        </c:if>
        <c:if test="${not empty errorMsg}">
          <div class="alert alert-danger mb-3" role="alert">${errorMsg}</div>
        </c:if>

        <form action="${urlSubmit}" method="post" class="mt-2">

          <div class="mb-3">
            <label class="form-label">현재 비밀번호</label>
            <input type="password" name="currentPassword" class="form-control"
                   placeholder="현재 비밀번호" required />
          </div>

          <div class="mb-3">
            <label class="form-label">새 비밀번호</label>
            <input type="password" name="newPassword" class="form-control"
                   placeholder="새 비밀번호" required
                   minlength="8" maxlength="30"
                   pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,30}$"
                   title="8~30자, 영문+숫자+특수문자를 포함해야 합니다." />
            <div class="form-text text-muted mt-1">
              8~30자 / 영문+숫자+특수문자 포함 권장
            </div>
          </div>

          <div class="mb-4">
            <label class="form-label">새 비밀번호 확인</label>
            <input type="password" name="newPasswordConfirm" class="form-control"
                   placeholder="새 비밀번호 확인" required />
          </div>

		  <div class="mb-3">
			<label class="form-label">자동입력 방지</label>
			  <div class="border rounded-3 p-3 bg-light">
			    <div class="cf-turnstile"
			         data-sitekey="0x4AAAAAACnFvtsMiRr6zWEI"></div>
			  </div>
		  </div>

          <div class="d-grid gap-2 mt-4">
            <button type="submit" class="btn btn-primary">확인</button>
            <a href="${urlCancel}" class="btn btn-outline-secondary">취소</a>
          </div>

        </form>
      </div>

    </div>
  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
  // 새 비밀번호 확인 일치 검사(프론트 1차)
  (function () {
    const form = document.querySelector('form[action="${urlSubmit}"]');
    if (!form) return;

    const newPw = form.querySelector('input[name="newPassword"]');
    const newPw2 = form.querySelector('input[name="newPasswordConfirm"]');

    function validateMatch() {
      if (!newPw || !newPw2) return;
      if (newPw2.value && newPw.value !== newPw2.value) {
        newPw2.setCustomValidity("새 비밀번호가 일치하지 않습니다.");
      } else {
        newPw2.setCustomValidity("");
      }
    }

    newPw?.addEventListener('input', validateMatch);
    newPw2?.addEventListener('input', validateMatch);
  })();
</script>

</body>
</html>

