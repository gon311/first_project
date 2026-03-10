<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf"%>
		<%-- 현재 페이지 전용 CSS 영역--%>
		<style>
			.pane textarea {
				min-height: 240px; /* 우측 상/하 패널 높이 기본값 */
				resize: vertical;
			}
			
			.left-pane textarea {
				min-height: 520px; /* 좌측 입력창 큰 높이 */
			}
			
			@media ( max-width : 991.98px) {
				.left-pane textarea {
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
			<div class="card shadow-sm">
				<div class="card-body p-4">
	
					<!-- 제목 -->
					<h1 class="h4 mb-4">표절 검사</h1>
	
					<!-- 레이아웃: 좌(입력) / 우(수정결과 + 세부설명) -->
					<div class="row g-4">
						<!-- 좌측: 입력창 -->
						<div class="col-12 col-lg-6 left-pane">
							<label for="inputText" class="form-label">입력창</label>
							<textarea id="inputText" name="inputText" class="form-control"
								placeholder="표절 검사를 진행할 원문을 입력하세요."></textarea>
						</div>
	
						<!-- 우측: 위/아래 스택 -->
						<div class="col-12 col-lg-6">
							<!-- (위) 수정 결과물 출력창 -->
							<div class="pane mb-3">
								<label for="outputText" class="form-label">수정 결과물</label>
								<textarea id="outputText" class="form-control"
									placeholder="표절 검사 후 수정/개선된 결과가 표시됩니다."></textarea>
							</div>
	
							<!-- (아래) 수정 내역 세부 설명창 -->
							<div class="pane">
								<label for="diffText" class="form-label">수정 내역 세부 설명</label>
								<textarea id="diffText" class="form-control"
									placeholder="어떤 부분이 어떻게 변경되었는지 상세 설명이 표시됩니다."></textarea>
							</div>
						</div>
					</div>
	
					<!-- 버튼 영역 -->
					<div class="d-flex justify-content-end gap-2 mt-4">
						<button type="button" id="runCheck" class="btn btn-primary">
							검사하기</button>
						<button type="button" id="copyOutput"
							class="btn btn-outline-secondary">복사 하기</button>
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

		
			// 1) chatGPT로 표절 검사 
			// 2) 클립보드에 복사
		</script>
	</body>
</html>

