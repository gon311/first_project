<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf"%>
		<%-- 현재 페이지 전용 CSS 영역--%>
		<style>
			.textarea-wrap textarea {
				min-height: 520px;
				resize: vertical;
			}
			
			@media ( max-width : 991.98px) {
				.textarea-wrap textarea {
					min-height: 360px;
				}
			}
		</style>
	
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
							<textarea id="outputText" name="outputText" class="form-control"
								placeholder="검사 결과가 여기에 표시됩니다."></textarea>
						</div>
					</div>
	
					<!-- 버튼 영역 -->
					<div class="d-flex justify-content-end gap-2 mt-4">
						<button type="button" id="generateBtn" name="generateBtn" class="btn btn-primary">
							검사하기</button>
						<button type="button" id="copyBtn" name="generateBtn" class="btn btn-outline-secondary">
							복사하기</button>
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
						<div class="mt-3">맞춤법 체크하는 중...</div>
					</div>
				</div>
			</div>
		
		
		</main>
		
		
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf"%>
	
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script type="text/javascript">
			// 1) 입력창 포커싱 
			document.addEventListener("DOMContentLoaded", () => {
			    const input = document.getElementById("inputText");
			    if (input) input.focus();
			});
			
			// 2) 검사하기 버튼 
			
			
			// 3) 복사하기 버튼 
			document.addEventListener("DOMContentLoaded", () => {
				const copyBtn = document.getElementById("copyBtn");
				const output = document.getElementById("outputText");
			
				if (copyBtn && output) {
					copyBtn.addEventListener("click", async () => {
						try {
							const text = output.value ?? "";
							if (!text) {
								alert("복사할 내용이 없습니다.");
								return;
							}
							await navigator.clipboard.writeText(text);
							alert("클립보드에 복사되었습니다. Ctrl+V로 붙여넣기 해주세요.");
						} catch (err) {
							// 일부 환경/권한 문제 대비: execCommand 폴백
							try {
								output.select();
								document.execCommand("copy");
								alert("클립보드에 복사되었습니다. Ctrl+V로 붙여넣기 해주세요.");
								window.getSelection().removeAllRanges();
							} catch (e) {
								console.error("복사 실패:", err, e);
								alert("복사에 실패했습니다. 직접 선택 후 Ctrl+C를 눌러 복사해 주세요.");
							}
						}
					});
				}
			});
			
		</script>
	</body>
</html>

