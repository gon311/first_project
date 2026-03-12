<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="pageTitle" value="자유게시판 게시물 목록" />

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	
	<%-- 현재 페이지 전용 CSS 영역 --%>
</head>
<body>
	<%-- 헤더 영역 --%>
	<%@ include file="/WEB-INF/views/inc/header.jspf" %>
	
	<%-- 컨텐츠 영역 --%>
	<main class="container mt-5">
		<h2 class="mb-4 text-center">자유게시판</h2>
		
		<!-- 검색 영역 -->
		<div class="card mb-3">
			<div class="card-body">
				<form action="<c:url value="/board/list" />" method="get" class="row g-2 align-items-center">
					<div class="col-auto">
						<select name="searchType" class="form-select">
							<option value="subject"
								<c:if test="${param.searchType eq 'subject'}">selected</c:if>>
								제목
							</option>
							<option value="content"
								<c:if test="${param.searchType eq 'content'}">selected</c:if>>
								내용
							</option>
							<option value="subject_content"
								<c:if test="${param.searchType eq 'subject_content'}">selected</c:if>>
								제목+내용
							</option>
							<option value="writer"
								<c:if test="${param.searchType eq 'writer'}">selected</c:if>>
								작성자
							</option>
						</select>
					</div>
	
					<div class="col-auto">
						<input type="text"
							name="searchKeyword"
							class="form-control"
							placeholder="검색어"
							value="${param.searchKeyword}">
					</div>
	
					<div class="col-auto">
						<button class="btn btn-primary">검색</button>
					</div>
					
					<div class="col-auto ms-auto">
						<button type="button"
							class="btn btn-success"
							onclick="location.href='<c:url value="/board/write" />'">
							글쓰기
						</button>
					</div>
				</form>
			</div>
		</div>
		
		<!-- 게시글 리스트 -->
		<table class="table table-hover align-middle">
			<thead class="table-info">
				<tr>
					<th style="width:100px">번호</th>
					<th>제목</th>
					<th style="width:150px">작성자</th>
					<th style="width:150px">날짜</th>
					<th style="width:100px">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty boardList}">
						<tr>
							<td colspan="5" class="text-center">
								게시물이 존재하지 않습니다. 
							</td>
						</tr>	
					</c:when>
					<c:otherwise>
						<!-- boardList 객체 크기만큼 반복 -->
						<c:forEach var="board" items="${boardList}">
							<tr>
								<td>${board.postId}</td>
								<td>${board.title}</td>
								<td>${board.authorMemberId}</td>
								<td>${board.strCreatedAt}</td>
								<td>${board.readcount}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		
		<%--페이지 번호 영역--%>
		<%--검색타입.검색어 결합한 변수(키워드 파라미터가 있을 경우에만)--%>
		<c:if test="${not empty param.searchKeyword}">
			<c:set var="searchParams" value="searchType=${param.searchType}&searchKeyword=${param.searchKeyword}" />
		</c:if>
		
		<%-- 최대 페이지 번호 존재 + 0보다 큰 경우에만 페이지 목록 표시  --%>
		<c:if test="${not empty pageInfoDTO and not empty pageInfoDTO.maxPage and pageInfoDTO.maxPage > 0}">
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item <c:if test="${pageInfoDTO.pageNum eq 1}">disabled</c:if>">
						<a class="page-link" href="<c:url value="/board/list?pageNum=${pageInfoDTO.pageNum -1}&${searchParams}" />">이전</a>
					</li>
					
					<%--starPage~endPage, 1씩 증가하면서 페이지번호 출력 --%>
					<c:forEach var="i" begin="${pageInfoDTO.startPage}" end="${pageInfoDTO.endPage}">
						<li class="page-item <c:if test="${i eq pageInfoDTO.pageNum}">active</c:if>">
							<c:choose>
								<c:when test="${i eq pageInfoDTO.pageNum}">
									<a class="page-link">${i}</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="<c:url value="/board/list?pageNum=${i}&${searchParams}" />">${i}</a>
								</c:otherwise>
							</c:choose>
						</li>
					</c:forEach>
					
					<li class="page-item <c:if test="${pageInfoDTO.pageNum eq pageInfoDTO.maxPage}">disabled</c:if>">
						<a class="page-link" href="<c:url value="/board/list?pageNum=${pageInfoDTO.pageNum + 1}&${searchParams}" />">다음</a>
					</li>
				</ul>
			</nav>
		</c:if>
	</main>
	
	<%-- 푸터 영역 --%>
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
	
	<%-- 개별 페이지 자바스크립트 영역 --%>
	
</body>
</html>

