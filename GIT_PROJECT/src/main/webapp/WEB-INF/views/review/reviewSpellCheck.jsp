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
							<textarea id="outputText" class="form-control"
								placeholder="검사 결과가 여기에 표시됩니다."></textarea>
						</div>
					</div>
	
					<!-- 버튼 영역 -->
					<div class="d-flex justify-content-end gap-2 mt-4">
						<button type="button" id="generate" class="btn btn-primary">
							검사하기</button>
						<button type="button" id="copyBtn" class="btn btn-outline-secondary">
							복사하기</button>
					</div>
	
				</div>
			</div>
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf"%>
	
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", () => {
			    const input = document.getElementById("inputText");
			    if (input) input.focus();
			});
		
		// 1) chatGPT로 맞춤법 검사 
		// 2) 클립보드에 복사 
			document.getElementById("copyBtn").addEventListener("click", () => {
				con text = document.getElementById("outputText").innerText;
				
				navigator.clipboard.writeText(text).then(() => {
					alter("클립보드에 복사되었습니다. ctrl+v로 붙여넣기 해주세요.");
				}).catch(err => {
					console.error("복사 실패", err);
				}); 
			});
		
		</script>
	</body>
</html>

