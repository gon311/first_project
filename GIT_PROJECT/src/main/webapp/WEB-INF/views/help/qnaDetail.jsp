<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	<title>1:1 문의 상세</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/header.jspf" %>

	<main class="container mt-5 mb-5">
		<div class="card shadow-sm p-4">

			<h3 class="mb-3">${qnaDTO.qnaTitle}</h3>

			<div class="text-muted small mb-3">
				<span>글 번호 : ${qnaDTO.qnaId}</span>
				<span class="mx-2">|</span>
				<span>문의 유형 : ${qnaDTO.qnaCategory}</span>
				<span class="mx-2">|</span>
				<span>
					작성일 :
					<fmt:formatDate value="${qnaDTO.regDate}" pattern="yyyy년 MM월 dd일 HH:mm:ss" />
				</span>
				<span class="mx-2">|</span>
				<span>
					상태 :
					<c:choose>
						<c:when test="${qnaDTO.reStatus eq 'completed'}">
							<span class="text-primary fw-bold">답변 완료</span>
						</c:when>
						<c:otherwise>
							<span class="text-secondary">답변 대기</span>
						</c:otherwise>
					</c:choose>
				</span>
			</div>

			<hr>

			<div class="mb-4" style="white-space: pre-wrap; min-height: 180px;">${qnaDTO.qnaContent}</div>

			<div class="mb-4">
				<div class="fw-semibold mb-2">
					첨부파일
				</div>

				<c:choose>
					<c:when test="${not empty qnaDTO.fileList}">
						<ul class="list-unstyled mb-0">
							<c:forEach var="fileDTO" items="${qnaDTO.fileList}">
								<li class="mb-2">
									<span>${fileDTO.originName}</span>
									<a href="<c:url value='/file/${fileDTO.fileId}' />" class="btn btn-sm btn-outline-primary ms-2">
										다운로드
									</a>
								</li>
							</c:forEach>
						</ul>
					</c:when>
					<c:otherwise>
						<div class="text-muted small">첨부된 파일이 없습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>

			<hr class="my-4">

			<div class="card bg-light border-0">
				<div class="card-body">
					<h5 class="fw-bold mb-3">관리자 답변</h5>

					<c:choose>
						<c:when test="${qnaDTO.reStatus eq 'completed' and not empty qnaDTO.reContent}">
							<div class="text-muted small mb-2">
								답변일 :
								<c:choose>
									<c:when test="${not empty qnaDTO.reDate}">
										<fmt:formatDate value="${qnaDTO.reDate}" pattern="yyyy년 MM월 dd일 HH:mm:ss" />
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</div>

							<div class="p-3 bg-white border rounded" style="white-space: pre-wrap; min-height: 120px;">${qnaDTO.reContent}</div>
						</c:when>
						<c:otherwise>
							<div class="p-3 bg-white border rounded text-muted">
								아직 답변이 등록되지 않았습니다.
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="text-center mt-4">
				<a href="<c:url value='/my/qna' />" class="btn btn-secondary">목록으로</a>
			</div>

		</div>
	</main>

	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>