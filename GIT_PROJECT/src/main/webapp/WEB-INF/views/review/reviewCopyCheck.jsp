<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
// 세션 체크 
	if(session.getAttribute("sId") == null) {
%>
	<script>
		alert("로그인이 필요한 서비스입니다.");
		location.href="<c:url value='/user/login' />";
	</script>
<%
		return;
	}

%>
<!DOCTYPE html>
<html>
	<head>
		<title>문장 다듬기</title>
		<%@ include file="/WEB-INF/views/inc/head.jspf"%>
		<%-- 현재 페이지 전용 CSS 영역--%>
		<link href="<c:url value="/resources/css/review/copyCheck.css" />" rel="stylesheet" type="text/css">
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf"%>
	
		<%-- main area --%>
		<main class="container my-4">
			<div class="card shadow-sm">
				<div class="card-body p-4">
	
					<!-- 제목 -->
					<h1 class="h4 mb-4">문장 다듬기</h1>
	
					<!-- 레이아웃: 좌(입력) / 우(수정결과 + 세부설명) -->
					<div class="row g-4">
						<!-- 좌측: 입력창 -->
						<div class="col-12 col-lg-6 left-pane">
							<label for="inputText" class="form-label">입력창</label>
							<textarea id="inputText" name="inputText" class="form-control"
								placeholder="회원님의 소중한 경험은 그대로, 표현은 더 독창적이고 전문적으로 바꿔보세요."></textarea>
						</div>
	
						<!-- 우측: 위/아래 스택 -->
						<div class="col-12 col-lg-6">
						    <div class="pane mb-3">
						        <label for="correctedResult" class="form-label">수정 결과물</label>
						        <div id="correctedResult" class="form-control"></div>
						    </div>
						
						    <div class="pane">
						        <label for="analysisDetail" class="form-label">수정 내역 세부 설명</label>
						        <div id="analysisDetail" class="form-control"></div>
						    </div>
						</div>
					</div>
	
					<!-- 버튼 영역 -->
					<div class="d-flex justify-content-end gap-2 mt-4">
						<button type="button" id="runCheck" class="btn btn-primary">
							글 다듬기</button>
						<button type="button" id="copyBtn" name="copyBtn"
							class="btn btn-outline-secondary">복사 하기</button>
					</div>
	
				</div>
			</div>
			<%--ChatGPT 교정 요청 시 응답 돌아올 때 까지 작업 중 오버레이 화면 --%>
			<div id="loadingOverlay" 
				class="position-fixed top-0 start-0 w-100 h-100 d-none"
				style="background: rgba(0,0,0,0.4); z-index: 9999">
				<div class="d-flex justify-content-center align-items-center h-100">
					<div class="text-center text-white">
						<div class="spinner-border" role="status"></div>
						<div class="mt-3">글 다듬는 중...</div>
					</div>
				</div>
			</div>
		</main>
	
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf"%>
	
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script type="text/javascript">
			// 1) 페이지 로드 시 초기화
		    document.addEventListener("DOMContentLoaded", () => {
		        const input = document.getElementById("inputText");
		        if (input) input.focus();
	
		        const copyBtn = document.getElementById("copyBtn");
		        const output = document.getElementById("outputText");
	
		        // 복사하기 버튼 이벤트 등록 
		        if (copyBtn && output) {
		            copyBtn.addEventListener("click", async () => {
		                // div의 경우 innerText, input/textarea의 경우 value 사용
		                const text = output.innerText || output.value; 
	
		                if (!text || text.trim() === "") {
		                    alert("복사할 내용이 없습니다.");
		                    return;
		                }
	
		                // 1. HTTPS 전용 복사 프로세스
		                if (navigator.clipboard && window.isSecureContext) {
		                    try {
		                        await navigator.clipboard.writeText(text);
		                        alert("클립보드에 복사되었습니다.");
		                        return; 
		                    } catch (error) {
		                        console.error("Clipboard API 실패, 대안 시도:", error);
		                    }
		                }
	
		                // 2. 대안 방식 (HTTP 또는 구형 브라우저)
		                try {
		                    const textArea = document.createElement("textarea");
		                    textArea.value = text;
		                    textArea.style.position = "fixed";
		                    textArea.style.left = "-9999px";
		                    textArea.style.top = "0";
		                    document.body.appendChild(textArea);
	
		                    textArea.focus();
		                    textArea.select();
	
		                    const successful = document.execCommand("copy");
		                    document.body.removeChild(textArea);
	
		                    if (successful) {
		                        alert("클립보드에 복사되었습니다.");
		                    } else {
		                        throw new Error('execCommand 실패');
		                    }
		                } catch (err) {
		                    console.error("모든 복사 시도 실패:", err);
		                    alert("복사에 실패하였습니다. 직접 선택 후 Ctrl+C를 눌러주세요.");
		                }
		            });
		        }
		    });
		
			// 2) 문장 다듬기 버튼
			document.getElementById("runCheck").addEventListener('click', () => {
				document.getElementById("loadingOverlay").classList.remove("d-none");
				
				// 입력받은 내용 가져오기 
				const inputContent = document.getElementById("inputText").value;
				
				async function requestGenerate() {
					try {
						// chatGPT에 전달하기 
						const response = await fetch("<c:url value="/gpt/copyCheck" />", {
							method: "POST", 
							headers: { 
								"Content-type": "application/json"
							}, 
							body: JSON.stringify({
								inputText : inputContent
							})
						});
						
						if(!response.ok) {
							throw new Error("오류 발생!");
						}
						
						// 생성된 값 화면에 출력 
						const result = await response.json();
						const correctedResultArea = document.getElementById("correctedResult");
						const analysisDetailArea = document.getElementById("analysisDetail");
						
						correctedResultArea.innerHTML = result.corrected;
						analysisDetailArea.innerHTML = result.description;
						
					} catch(error) {
						console.error("Error:", error);
						alert("문장 다듬는 중 문제가 발생했습니다.");
					} finally {
						document.getElementById("loadingOverlay").classList.add("d-none");
					}
				}
				requestGenerate();
			});
			
			
			
		</script>
	</body>
</html>

