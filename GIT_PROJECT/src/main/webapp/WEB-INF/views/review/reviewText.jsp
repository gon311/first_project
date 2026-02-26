<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf"%>
		<link href="<c:url value="/resources/css/reviewText.css" />" rel="stylesheet" type="text/css">
		<%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf"%>
	
		<%-- main area --%>
		<main class="container my-4">
			<form action="<c:url value="/review/save" />" name="registText"
				id="registText" method="post" novalidate>
				<div class="card shadow-sm review-card">
					<div class="card-body p-4">
	
						<!-- 제목 -->
						<div class="mb-4">
							<label for="title" class="form-label fw-semibold">자소서 제목 <span
								class="text-danger">*</span></label> <input type="text"
								class="form-control" id="title" name="title"
								value="${param.title}" placeholder="제목을 입력해 주세요." required>
						</div>
	
						<!-- 질문 선택 -->
						<div class="mb-3">
							<label for="question" class="form-label fw-semibold">질문 선택
								<span class="text-danger">*</span>
							</label> <select id="question" name="question"
								class="form-select w-auto d-inline-block" required>
								<option value="default" disabled selected>질문을 선택하세요</option>
								<option value="MOTIVATION">지원동기</option>
								<option value="JOB_COMPETENCY">직무역량</option>
								<option value="EXPERIENCE_BASED">경험 기반</option>
								<option value="PROBLEM_SOLVING">문제해결</option>
								<option value="FAILURE_EXPERIENCE">실패 경험</option>
								<option value="CONFLICT_MANAGEMENT">갈등관리</option>
								<option value="COMMUNICATION">의사소통</option>
								<option value="RESPONSIBILITY">책임감</option>
								<option value="GROWTH_BACKGROUND">성장 과정</option>
								<option value="CHALLENGE_SPIRIT">도전정신</option>
								<option value="ETHICS">윤리의식</option>
								<option value="GOAL_ORIENTATION">목표의식</option>
								<option value="JOB_UNDERSTANDING">직무 이해</option>
								<option value="STRENGTH">강점</option>
								<option value="WEAKNESS">약점</option>
								<option value="LEARNING_ABILITY">학습능력</option>
								<option value="CULTURE_FIT">조직적합</option>
								<option value="LEADERSHIP">리더십</option>
								<option value="DILIGENCE">성실성</option>
								<option value="FREE_TOPIC">자유 주제</option>
							</select>
						</div>
	
						<!-- 글자수 -->
						<div class="text-count mb-2">
							글자수 체크(공백 포함) <span id="charCount">0</span>자
						</div>
	
						<!-- 입력/출력 2열 -->
						<div class="row g-3 textarea-wrap">
							<div class="col-12 col-lg-6">
								<label for="inputText" class="form-label">입력</label>
								<textarea id="inputText" name="inputText" class="form-control"
									rows="18" placeholder="키워드 또는 문장을 입력해주세요."></textarea>
							</div>
							<div class="col-12 col-lg-6">
								<label for="outputText" class="form-label">출력</label>
								<textarea id="outputText" class="form-control" rows="18">
									<c:if test="${not empty response}">${response}</c:if>
								</textarea>
							</div>
						</div>
	
						<!-- 버튼 -->
						<div class="d-flex justify-content-end gap-2 mt-4">
							<!-- 1단계 선택지 + 질문 + 입력창 입력값으로 생성 -->
							<button type="button" id="generate" class="btn btn-primary">생성하기</button>
							<!-- 출력 → 입력 덮어쓰기 -->
							<button type="button" id="apply" class="btn btn-outline-secondary">적용하기</button>
							<!-- 저장 -->
							<button type="submit" class="btn btn-success">저장</button>
						</div>
	
					</div>
				</div>
			</form>
			
			<%--ChatGPT 교정 요청 시 응답 돌아올 때 까지 작업 중 오버레이 화면 --%>
			<div id="loadingOverlay" 
				class="position-fixed top-0 start-0 w-100 h-100 d-none"
				style="background: rgba(0,0,0,0.4); z-index: 9999">
				<div class="d-flex justify-content-center align-items-center h-100">
					<div class="text-center text-white">
						<div class="spinner-border" role="status"></div>
						<div class="mt-3">교정 중...</div>
					</div>
				</div>
			</div>
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf"%>
	
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script type="text/javascript">
// 	 			1) 글자수 계산
				document.addEventListener('DOMContentLoaded', () => {
					const textarea = document.getElementById('inputText'); // 대상 textarea
					const countSpan = document.getElementById('charCount'); // 숫자 표시 span
					
					function updateCount() {
						// 기본 : 문자열 길이(공백 포함)
						const len = textarea.value.length;
						countSpan.textContent = len;
						
					}
					// 입력할 때마다 갱신
					textarea.addEventListener('input', updateCount);
					
					// 초기 1회 갱신
					updateCount();
				});
				
// 				2) 생성하기 버튼
				document.getElementById("generate").addEventListener('click', () => {
					document.getElementById("loadingOverlay").classList.remove("d-none");
					
					// 입력받은 내용 가져오기 
					let inputContent = document.getElementById("inputText").value;
					
					// chatGPT에 전달하기 
					async function requestGenerate() {
						try {
							const = response = await fetch("<c:url value="/gpt/generateContent" />", {
								method: "POST", 
								headers: { 
									"Content-type": "application/json"
								}
								
							});
							
						} catch(error) {
							
						}
					}
					
				});
				
				
// 				3) 적용하기 버튼 
				document.addEventListener('DOMContentLoaded', () => {
					const applyBtn = document.getElementById('apply');
					const inputArea = document.getElementById('inputText');
					const outputArea = document.getElementById('outputText');
					
					applyBtn.addEventListener('click', () => {
						// 출력창 내용으로 입력창 덮어쓰기 
						inputArea.value = outputArea.value;
						
						// 글자수 카운터 갱신 함수 호출
						if(typeof updateCount === 'function') updateCount();
					});
				});
			</script>
	</body>
</html>

