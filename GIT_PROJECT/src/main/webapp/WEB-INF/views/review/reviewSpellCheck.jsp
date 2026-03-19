<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
// 세션 체크 
if (session.getAttribute("sId") == null) {
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
<title>맞춤법 검사</title>
<%@ include file="/WEB-INF/views/inc/head.jspf"%>
<%-- 현재 페이지 전용 CSS 영역--%>
<link href="<c:url value="/resources/css/review/spellCheck.css" />"
	rel="stylesheet" type="text/css">

</head>
<body>
	<%-- header area --%>
	<%@ include file="/WEB-INF/views/inc/header.jspf"%>

	<%-- main area --%>
	<main class="container my-4">
		<div class="card shadow-sm review-card">
			<div class="card-body p-4">

				<!-- 제목 -->
				<h1 class="h4 mb-4">맞춤법 검사</h1>

				<!-- 입력/출력 2열 -->
				<div class="row g-3 textarea-wrap">
					<div class="col-12 col-lg-6">
						<label for="inputText" class="form-label">입력창</label>
						<textarea id="inputText" name="inputText" class="form-control"
							placeholder="검사할 내용을 입력하세요."></textarea>
					</div>
					<div class="col-12 col-lg-6">
						<label for="outputText" class="form-label">출력창</label>
						<div id="outputText" class="form-control"
							style="height: 520px; overflow-y: auto; background-color: #f8f9fa;"></div>
					</div>
				</div>

				<!-- 버튼 영역 -->
				<div class="d-flex justify-content-end gap-2 mt-4">
					<button type="button" id="generateBtn" name="generateBtn"
						class="btn btn-primary">검사하기</button>
					<button type="button" id="copyBtn" name="generateBtn"
						class="btn btn-outline-secondary">복사하기</button>
				</div>

			</div>
		</div>
		<%--ChatGPT 교정 요청 시 응답 돌아올 때 까지 작업 중 오버레이 화면 --%>
		<div id="loadingOverlay"
			class="position-fixed top-0 start-0 w-100 h-100 d-none"
			style="background: rgba(0, 0, 0, 0.4); z-index: 9999">
			<div class="d-flex justify-content-center align-items-center h-100">
				<div class="text-center text-white">
					<div class="spinner-border" role="status"></div>
					<div class="mt-3">맞춤법 체크하는 중...</div>
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
	
	    // 2) 검사하기 버튼
	    document.getElementById("generateBtn").addEventListener('click', () => {
	        const inputContent = document.getElementById("inputText").value;
	        
	        if(!inputContent.trim()){
	            alert("내용을 입력해주세요.");
	            return;
	        }
	
	        document.getElementById("loadingOverlay").classList.remove("d-none");
	
	        async function requestGenerate() {
	            try {
	                const response = await fetch("<c:url value='/gpt/spellCheck' />", {
	                    method: "POST",
	                    headers: {
	                        "Content-type": "application/json"
	                    },
	                    body: JSON.stringify({
	                        inputText: inputContent
	                    })
	                });
	
	                if (!response.ok) {
	                    throw new Error("서버 응답 오류");
	                }
	
	                const result = await response.json();
	                const outputArea = document.getElementById("outputText");
	                
	                // 결과 출력
	                outputArea.innerHTML = result.corrected;
	
	            } catch (error) {
	                console.error("Error:", error);
	                alert("맞춤법 검사 중 문제가 발생했습니다.");
	            } finally {
	                document.getElementById("loadingOverlay").classList.add("d-none");
	            }
	        }
	        requestGenerate();
	    });
	</script>
</body>
</html>

