<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf"%>
		<%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
		<link href="<c:url value="/resources/css/review/reviewText.css" />" rel="stylesheet" type="text/css">
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
							<label for="title" class="form-label fw-semibold">자소서 제목<span
								class="text-danger">*</span></label> <input type="text"
								class="form-control" id="title" name="title"
								value="${coverLetterDTO.title}" placeholder="제목을 입력해 주세요." required>
						</div>
						
						<!-- 질문 선택 -->
						<div class="mb-3">
							<label for="question" class="form-label fw-semibold">질문 선택
								<span class="text-danger">*</span>
							</label> <select id="questionCode" name="questionCode"
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
								<textarea id="content" name="content" class="form-control"
									rows="18" placeholder="키워드 또는 문장을 입력해주세요.">${coverLetterDTO.content}</textarea>
							</div>
							<div class="col-12 col-lg-6">
								<label for="outputText" class="form-label">출력</label>
								<div id="outputText" class="form-control"></div>
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
				
				<%-- select문에서 사용할 coverLetterIdx --%>
				<input type="hidden" id="coverLetterIdx" name="coverLetterIdx" value="${coverLetterDTO.coverLetterIdx}">
				<%-- ai 생성 여부  --%>
				<input type="hidden" id="aiGenerated" name="aiGenerated" value="0">
				<%-- 최종저장 status --%>
				<input type="hidden" id="saveStatus" name="saveStatus" value="0">
			
			</form>
			
			
			<%--ChatGPT 교정 요청 시 응답 돌아올 때 까지 작업 중 오버레이 화면 --%>
			<div id="loadingOverlay" 
				class="position-fixed top-0 start-0 w-100 h-100 d-none"
				style="background: rgba(0,0,0,0.4); z-index: 9999">
				<div class="d-flex justify-content-center align-items-center h-100">
					<div class="text-center text-white">
						<div class="spinner-border" role="status"></div>
						<div class="mt-3">자소서 생성 중...</div>
					</div>
				</div>
			</div>
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf"%>
	
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script type="text/javascript">
			
// 	 			1) 글자수 계산 함수 
				function updateCount() {
				    const textarea = document.getElementById('content');
				    const countSpan = document.getElementById('charCount');
				    countSpan.textContent = textarea.value.length;
				}
				
				document.addEventListener('DOMContentLoaded', () => {
				    const textarea = document.getElementById('content');
				    textarea.addEventListener('input', updateCount);
				    updateCount();
				});
				
 				// 2) 생성하기 버튼 (async 키워드 추가)
				document.getElementById("generate").addEventListener('click', async () => {
				    
				    // 회원권 체크 및 차감 로직 호출
				    const canGenerate = await checkCount();
				    if(!canGenerate) {
				        return; // 잔여 횟수가 없으면 중단
				    }
				    
				    document.getElementById("loadingOverlay").classList.remove("d-none");
				    
				    // 입력받은 내용 가져오기 
				    const coverLetterIdx = document.getElementById("coverLetterIdx").value;
				    const questionCode = document.getElementById("questionCode").value;
				    const inputContent = document.getElementById("content").value;
				    
				    // 요청 함수 실행
				    await requestGenerate(coverLetterIdx, questionCode, inputContent);
				});
				
				// 생성 요청 함수
				async function requestGenerate(coverLetterIdx, questionCode, inputContent) {
				    try {
				        const response = await fetch("<c:url value='/gpt/generateContent' />", {
				            method: "POST", 
				            headers: { 
				                "Content-Type": "application/json"
				            }, 
				            body: JSON.stringify({
				                coverLetterIdx : coverLetterIdx, 
				                questionCode : questionCode,
				                content : inputContent
				            })
				        });
				        
				        if(!response.ok) throw new Error("오류 발생!");
				        
				        const result = await response.json();
				        const outputArea = document.getElementById("outputText");
				        outputArea.textContent = result.title + "\n\n" + result.content;
				        
				        // 생성하기에 성공했을 때만 aiGenerated.value 1로 바뀜
				        const aiGenerated = document.getElementById("aiGenerated");
				        if(aiGenerated){
					        aiGenerated.value = "1";
				        }
				        
				    } catch(error) {
				        console.error("Error:", error);
				        alert("자기소개서 생성 중 문제가 발생했습니다.");
				    } finally {
				        document.getElementById("loadingOverlay").classList.add("d-none");
				    }
				}
								
// 				3) 적용하기 버튼 
				document.addEventListener('DOMContentLoaded', () => {
					const applyBtn = document.getElementById('apply');
					const inputArea = document.getElementById('content');
					const outputArea = document.getElementById('outputText');
					
					applyBtn.addEventListener('click', () => {
						// 출력창 내용으로 입력창 덮어쓰기 
						inputArea.value = outputArea.textContent;
						
						// 글자수 카운터 갱신 함수 호출
						if(typeof updateCount === 'function') updateCount();
					});
				});
				
				// 4) 회원권 체크 함수
				async function checkCount() {
					try {
						const response = await fetch("<c:url value="/gpt/checkAndDeductPass" />",{
							method: "POST",
							headers: {"Content-Type": "application/json"}						
						});
						
						const result = await response.json();
						
						if(!result.success) {
							alert(result.message);
							return false;
						}
						return true; // 차감 성공 시 진행 
					} catch(error) {
						console.error("회원권 확인 중 오류: ", error);
						alert("시스템 오류가 발생했습니다.")
						return false;
					}
				}
				// 5) 뒤로 가기 방지 함수 
				const preventBack = () => {
					history.pushState(null, null, location.href);
				};
				
				// 6) 사용자가 페이지에서 첫 클릭을 하면 히스토리 스택을 하나 쌓음
				window.addEventListener('click', () => {
				    preventBack;
				}, { once: true }); 
				
				// 7) 뒤로가기 시도시 다시 앞으로 밀어내고 경고 
				window.onpopstate = function (e) {
				    preventBack;
				    alert("변경사항이 저장되지 않을 수 있습니다.");
				};
			</script>
	</body>
</html>

