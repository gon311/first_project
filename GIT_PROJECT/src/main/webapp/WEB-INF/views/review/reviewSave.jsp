<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf"%>
		<%-- 현재 페이지(rivewSave.jsp) 전용 CSS 영역--%>
		<link href="<c:url value="/resources/css/review/reviewSave.css" />" rel="stylesheet" type="text/css">
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf"%>
	
		<%-- main area --%>
		<main>
			<div class="container my-4">
				<div class="row g-4 align-items-start">
					<!-- 좌측: 제목 + 본문 -->
					<div class="col-12 col-lg-9 title-body">
						<!-- 제목 카드 -->
						<div class="card">
							<div class="card-body">
								<h5 class="card-title mb-0">${param.title}</h5>
							</div>
						</div>
	
						<!-- 본문 카드 -->
						<div class="card mt-3">
							<div class="card-body">
								<!-- 본문 영역(큰 박스 느낌) -->
								<div class="border rounded-3 bg-light-subtle p-3"
									style="height: 520px; overflow: auto;">
									<!-- 실제 본문 컨텐츠가 들어가는 영역 -->
									${param.content}
								</div>
							</div>
						</div>
					</div>
	
					<!-- 우측: 액션 버튼 스택 -->
					<div class="col-12 col-lg-3 no-print">
						<div class="card shadow-sm sticky-top" style="top: 16px;">
							<div class="card-body">
	
								<div class="d-flex flex-column align-items-center gap-2">
									<button type="button"
										class="btn btn-outline-secondary text-center action-btn"
										onclick="history.back()">
										수정</button>
									<button type="button"
										class="btn btn-outline-danger text-center action-btn"
										onclick="handleDelete()">
										삭제</button>
									<button type="button"
										class="btn btn-outline-secondary text-center action-btn"
										onclick="window.print()">
										인쇄/PDF 저장</button>
									<button type="button"
										class="btn btn-outline-secondary text-center action-btn"
										onclick="location.href='<c:url value="/review/spellCheck" />'">
										맞춤법 검사</button>
									<button type="button"
										class="btn btn-outline-secondary text-center action-btn"
										onclick="location.href='<c:url value="/review/copyCheck" />'">
										표절검사</button>
									<button type="button"
										class="btn btn-light border text-center action-btn" 
										onclick ="location.href='<c:url value="/my/myReview" />'">
										<%-- 목록으로 클릭 시 마이페이지 내 이력서/자조서 페이지로 이동 --%>
										목록으로</button>
								</div>
								
								<input class="no-print" type="hidden" id="coverLetterIdx" value="${coverLetterIdx}">
								
							</div>
						</div>
					</div>
				</div>
			</div>
	
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf"%>
	
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script type="text/javascript">
			console.log(${coverLetterIdx})
		
			// 1) 삭제 버튼 
			function handleDelete() {
				if(!confirm("삭제하시겠습니까?")) return;
				
				const id = document.getElementById("coverLetterIdx").value;
				
				const form = document.createElement("form");
				form.method = "post";
				form.action = "<c:url value='/review/delete' />";
				
				const input = document.createElement("input");
				input.type = "hidden";
				input.name = "coverLetterIdx";
				input.value = id;
				
				form.appendChild(input);
				document.body.appendChild(form);
				form.submit();
			}
			
			
			
			
		</script>
	
	</body>
</html>
	
