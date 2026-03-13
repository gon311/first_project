<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/my/updateInfo.css'/>" type="text/css">
</head>

<c:url var="urlUpdateInfo" value="/my/updateInfo"/>
<c:url var="urlMyInfo" value="/my/myInfo"/>
<c:url var="urlDeleteUser" value="/my/user/delete"/>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<main class="container-fluid px-0 mypage-wrap">
	<div class="row g-0">

		<%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

		<section class="col-10 myContent">
			<div class="myContent-inner">

				<div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
					<div>
						<h2 class="page-title">내 정보 수정</h2>
						<p class="page-desc">회원 기본 정보를 수정할 수 있습니다.</p>
					</div>
				</div>

				<c:if test="${not empty errorMsg}">
					<div class="alert alert-danger mt-3 mb-0" role="alert">
						${errorMsg}
					</div>
				</c:if>

				<form action="${urlUpdateInfo}" method="post">
					<div class="form-grid">

						<div>
							<div class="field-label">이름</div>
							<input type="text" name="userName" class="form-control"
								   value="${loginUser.userName}" maxlength="20"
								   placeholder="이름을 입력하세요" required>
						</div>

						<div>
							<div class="field-label">성별</div>
							<select name="gender" class="form-control">
								<option value="M" <c:if test="${loginUser.gender eq 'M'}">selected</c:if>>남성</option>
								<option value="F" <c:if test="${loginUser.gender eq 'F'}">selected</c:if>>여성</option>
								<option value="N" <c:if test="${loginUser.gender eq 'N'}">selected</c:if>>선택 안 함</option>
							</select>
						</div>

						<div>
							<div class="field-label">이메일</div>
							<input type="text" class="form-control" value="${loginUser.email}" readonly>
						</div>

						<div>
							<div class="field-label">휴대전화</div>
							<input type="text"
								   name="phone"
								   id="phone"
								   class="form-control"
								   value="${loginUser.phone}"
								   maxlength="13"
								   placeholder="010-1234-5678"
								   oninput="formatPhone(this)"
								   required>
						</div>

						<div>
							<div class="field-label">생년월일</div>
							<input type="date" name="birthDate" class="form-control"
								   value="${loginUser.birthDate}"
								   max="<%= java.time.LocalDate.now() %>">
						</div>

						<div>
							<div class="field-label">국적</div>
							<select name="country" class="form-control">
								<option value="KR" <c:if test="${empty loginUser.country or loginUser.country eq 'KR'}">selected</c:if>>대한민국</option>
								<option value="US" <c:if test="${loginUser.country eq 'US'}">selected</c:if>>미국</option>
								<option value="JP" <c:if test="${loginUser.country eq 'JP'}">selected</c:if>>일본</option>
								<option value="CN" <c:if test="${loginUser.country eq 'CN'}">selected</c:if>>중국</option>
								<option value="TW" <c:if test="${loginUser.country eq 'TW'}">selected</c:if>>대만</option>
								<option value="HK" <c:if test="${loginUser.country eq 'HK'}">selected</c:if>>홍콩</option>
								<option value="SG" <c:if test="${loginUser.country eq 'SG'}">selected</c:if>>싱가포르</option>
								<option value="TH" <c:if test="${loginUser.country eq 'TH'}">selected</c:if>>태국</option>
								<option value="VN" <c:if test="${loginUser.country eq 'VN'}">selected</c:if>>베트남</option>
								<option value="PH" <c:if test="${loginUser.country eq 'PH'}">selected</c:if>>필리핀</option>
								<option value="MY" <c:if test="${loginUser.country eq 'MY'}">selected</c:if>>말레이시아</option>
								<option value="ID" <c:if test="${loginUser.country eq 'ID'}">selected</c:if>>인도네시아</option>
								<option value="IN" <c:if test="${loginUser.country eq 'IN'}">selected</c:if>>인도</option>
								<option value="AU" <c:if test="${loginUser.country eq 'AU'}">selected</c:if>>호주</option>
								<option value="NZ" <c:if test="${loginUser.country eq 'NZ'}">selected</c:if>>뉴질랜드</option>
								<option value="CA" <c:if test="${loginUser.country eq 'CA'}">selected</c:if>>캐나다</option>
								<option value="GB" <c:if test="${loginUser.country eq 'GB'}">selected</c:if>>영국</option>
								<option value="FR" <c:if test="${loginUser.country eq 'FR'}">selected</c:if>>프랑스</option>
								<option value="DE" <c:if test="${loginUser.country eq 'DE'}">selected</c:if>>독일</option>
								<option value="IT" <c:if test="${loginUser.country eq 'IT'}">selected</c:if>>이탈리아</option>
								<option value="ES" <c:if test="${loginUser.country eq 'ES'}">selected</c:if>>스페인</option>
								<option value="NL" <c:if test="${loginUser.country eq 'NL'}">selected</c:if>>네덜란드</option>
								<option value="SE" <c:if test="${loginUser.country eq 'SE'}">selected</c:if>>스웨덴</option>
								<option value="CH" <c:if test="${loginUser.country eq 'CH'}">selected</c:if>>스위스</option>
								<option value="RU" <c:if test="${loginUser.country eq 'RU'}">selected</c:if>>러시아</option>
								<option value="BR" <c:if test="${loginUser.country eq 'BR'}">selected</c:if>>브라질</option>
								<option value="MX" <c:if test="${loginUser.country eq 'MX'}">selected</c:if>>멕시코</option>
								<option value="AR" <c:if test="${loginUser.country eq 'AR'}">selected</c:if>>아르헨티나</option>
								<option value="ZA" <c:if test="${loginUser.country eq 'ZA'}">selected</c:if>>남아프리카공화국</option>
								<option value="AE" <c:if test="${loginUser.country eq 'AE'}">selected</c:if>>아랍에미리트</option>
								<option value="SA" <c:if test="${loginUser.country eq 'SA'}">selected</c:if>>사우디아라비아</option>
								<option value="TR" <c:if test="${loginUser.country eq 'TR'}">selected</c:if>>튀르키예</option>
								<option value="EG" <c:if test="${loginUser.country eq 'EG'}">selected</c:if>>이집트</option>
								<option value="ETC" <c:if test="${loginUser.country eq 'ETC'}">selected</c:if>>기타</option>
							</select>
						</div>

					<div class="form-row-full">
						<div class="field-label">회원유형</div>
						<input type="text" class="form-control"
							   value="${loginUser.userType}" readonly>
						<small class="text-muted mt-1 d-block">
							<c:choose>
								<c:when test="${loginUser.userType eq 'P'}">개인회원</c:when>
								<c:when test="${loginUser.userType eq 'C'}">기업회원</c:when>
								<c:when test="${loginUser.userType eq 'A'}">관리자</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</small>
					</div>

					</div>

					<div class="form-actions">
						<a href="${urlDeleteUser}" class="danger-link"
						   onclick="return confirm('정말 탈퇴하시겠습니까?');">회원 탈퇴</a>

						<div class="d-flex gap-2">
							<a href="${urlMyInfo}" class="btn btn-light">취소</a>
							<button type="submit" class="btn btn-save">저장하기</button>
						</div>
					</div>
				</form>

			</div>
		</section>

	</div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
function formatPhone(input) {
    let numbers = input.value.replace(/[^0-9]/g, ''); // 숫자만 남김

    // 최대 11자리까지만 허용
    if (numbers.length > 11) {
        numbers = numbers.substring(0, 11);
    }

    // 하이픈 자동 추가
    if (numbers.length < 4) {
        input.value = numbers;
    } else if (numbers.length < 8) {
        input.value = numbers.replace(/(\d{3})(\d+)/, '$1-$2');
    } else {
        input.value = numbers.replace(/(\d{3})(\d{3,4})(\d+)/, '$1-$2-$3');
    }
}
</script>
</body>
</html>