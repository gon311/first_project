<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<c:set var="pageTitle" value="자유게시판 글쓰기" />

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	
	<%-- 현재 페이지 전용 CSS 영역 --%>
	<link href="<c:url value="/resources/css/board/boardWrite.css" />" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- 헤더 영역 --%>
	<%@ include file="/WEB-INF/views/inc/header.jspf" %>
	
	<%-- 컨텐츠 영역 --%>
	<main>
		<div class="container mt-5">
			<h2 class="mb-4 text-center">게시물 등록</h2>
			<form action="<c:url value="/board/write" />" id="writeForm" method="post" enctype="multipart/form-data" class="container mt-5">
			
			    <!-- 화면 폭 제한 + 중앙 정렬 -->
			    <div class="row justify-content-center">
			        <div class="col-md-8 col-lg-6">
			
			            <!-- 카드 UI -->
			            <div class="card shadow-sm">
			                <div class="card-body">
			
			                    <!-- 작성자 -->
			                    <!-- 세션 아이디를 출력하고, 입력하지 못하도록 잠금(readonly or disabled) -->
			                    <div class="mb-3">
			                        <label for="writer" class="form-label">작성자</label>
			                        <input type="text" id="writer" name="writer" value="${sessionScope.sId}" class="form-control" placeholder="작성자 아이디" disabled>
			                    </div>
			
			                    <!-- 제목 -->
			                    <div class="mb-3">
			                        <label for="title" class="form-label">제목</label>
			                        <input type="text" id="title" name="title" class="form-control" placeholder="제목을 입력하세요" required>
			                    </div>
			
			                    <!-- 본문 -->
			                    <div class="mb-3">
			                        <label for="content" class="form-label">본문</label>
			                        <textarea id="content" rows="5"
			                                  name="content" class="form-control" placeholder="내용을 입력하세요" required></textarea>
			                    </div>
			
			                    <!-- 다중 첨부파일 -->
			                    <div class="mb-3">
			                        <label class="form-label">첨부파일</label>
			                        <input type="file" class="form-control" name="files" multiple>
			                    </div>

			
			                    <!-- 버튼 영역 -->
			                    <div class="d-flex justify-content-center gap-2 mt-4">
			                        <button type="submit" class="btn btn-primary">
			                            글쓰기
			                        </button>
			                        <button type="reset" class="btn btn-secondary">
			                            초기화
			                        </button>
			                        <button type="button"
			                                class="btn btn-outline-secondary"
			                                onclick="history.back()">
			                            취소
			                        </button>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			</form>
		</div>
		
	</main>
	
	<%-- 푸터 영역 --%>
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
	
	<%-- 개별 페이지 스크립트 영역 --%>
</body>
</html>
