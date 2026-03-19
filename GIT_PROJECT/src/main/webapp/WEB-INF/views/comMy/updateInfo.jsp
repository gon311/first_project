<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/comMyCss/updateInfo.css'/>" type="text/css">

<!-- 다음 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>

<c:url var="urlUpdateInfo" value="/comMy/updateInfo"/>
<c:url var="urlMyInfo" value="/comMy/info"/>

<main class="container-fluid px-0 mypage-wrap">
	<div class="row g-0">

		<%@ include file="/WEB-INF/views/inc/comMySidebar.jspf" %>

		<section class="col-10 myContent">
			<div class="myContent-inner">

				<h2 class="page-title">내 정보 수정</h2>
				<div class="page-desc">기업 회원 정보를 확인하고 수정할 수 있어요.</div>

				<c:if test="${not empty errorMsg}">
					<div class="alert alert-danger mb-3">${errorMsg}</div>
				</c:if>

				<form action="${urlUpdateInfo}" method="post" id="updateForm">
					<div class="form-grid">

						<div>
							<div class="field-label">이메일</div>
							<input type="email" class="form-control readonly-field"
								   name="email"
								   value="${loginUser.email}" readonly />
						</div>

						<div>
							<div class="field-label">담당자명</div>
							<input type="text" class="form-control" name="userName"
								   value="${loginUser.userName}"
								   required
								   pattern="^[가-힣a-zA-Z\\s]{2,20}$"
								   title="담당자명은 한글/영문 2~20자만 입력하세요." />
						</div>

						<div>
							<div class="field-label">전화번호</div>
							<input type="text" class="form-control" name="phone" id="phone"
								   value="${loginUser.phone}"
								   required
								   maxlength="13"
								   pattern="^((01[016789]|02|0[3-9][0-9]|070)-\d{3,4}-\d{4}|1[0-9]{3}-\d{4})$"
								   title="전화번호는 010-1234-5678, 02-123-4567, 051-123-4567, 1588-1234 형식으로 입력하세요." />
						</div>

						<div>
							<div class="field-label">회사명</div>
							<input type="text" class="form-control" name="companyName"
								   value="${loginUser.companyName}"
								   required
								   maxlength="200"
								   title="회사명을 입력하세요." />
						</div>

						<div>
							<div class="field-label">대표자명</div>
							<input type="text" class="form-control" name="ceoName"
								   value="${loginUser.ceoName}"
								   required
								   maxlength="60"
								   title="대표자명을 입력하세요." />
						</div>

						<div>
							<div class="field-label">사업자등록번호</div>
							<input type="text" class="form-control readonly-field"
								   value="${loginUser.bizRegNo}"
								   readonly />
						</div>

						<div class="form-row-full">
							<div class="field-label">회사 주소</div>

							<div class="input-with-btn">
								<input type="text" id="postcode" class="form-control readonly-field"
									   placeholder="우편번호" readonly>
								<button type="button" class="btn-action" onclick="execDaumPostcode()">주소 찾기</button>
							</div>

							<input type="text" id="address" class="form-control readonly-field mt-8"
								   placeholder="기본주소" readonly>

							<input type="text" id="detailAddress" class="form-control mt-8"
								   placeholder="상세주소">

							<input type="hidden" name="companyAddress" id="real_company_address"
								   value="${loginUser.companyAddress}">
						</div>

					</div>

					<div class="form-actions form-actions-right">
						<a href="${urlMyInfo}" class="btn btn-light btn-cancel">취소</a>
						<button type="submit" class="btn btn-save">저장하기</button>
					</div>
				</form>

			</div>
		</section>

	</div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>

// hidden 최종 주소 조합
function updateCompanyAddress() {
	const postcode = document.getElementById("postcode").value.trim();
	const address = document.getElementById("address").value.trim();
	const detailAddress = document.getElementById("detailAddress").value.trim();

	let fullAddress = "";

	if (postcode) fullAddress += "[" + postcode + "] ";
	if (address) fullAddress += address;
	if (detailAddress) fullAddress += " " + detailAddress;

	document.getElementById("real_company_address").value = fullAddress.trim();
}

// 기존 주소 로드
function loadExistingCompanyAddress() {
	const savedAddress = document.getElementById("real_company_address").value.trim();
	if (!savedAddress) return;

	const postcodeEl = document.getElementById("postcode");
	const addressEl = document.getElementById("address");
	const detailAddressEl = document.getElementById("detailAddress");

	const match = savedAddress.match(/^\[(\d{5})\]\s*(.*)$/);

	if (match) {
		postcodeEl.value = match[1];
		addressEl.value = match[2];
	} else {
		addressEl.value = savedAddress;
	}

	// 상세주소 칸은 비워서 보여주기만 함
	detailAddressEl.value = "";
}

// 다음 주소 API
function execDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			let addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;

			document.getElementById("postcode").value = data.zonecode;
			document.getElementById("address").value = addr;
			document.getElementById("detailAddress").value = "";

			updateCompanyAddress();
			document.getElementById("detailAddress").focus();
		}
	}).open();
}

document.addEventListener("DOMContentLoaded", function() {
	loadExistingCompanyAddress();

	const detailAddressEl = document.getElementById("detailAddress");
	const form = document.getElementById("updateForm");

	if (detailAddressEl) {
		detailAddressEl.addEventListener("input", updateCompanyAddress);
	}

	if (form) {
		form.addEventListener("submit", function() {
			updateCompanyAddress();
		});
	}
});
</script>

</body>
</html>