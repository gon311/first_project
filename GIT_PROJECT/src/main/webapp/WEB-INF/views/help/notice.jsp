<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/header.jspf" %>
	<main class="container-fluid mt-4">
	    <div class="card shadow-sm p-3">
	        <div class="row mb-3 align-items-center">
	            <div class="col-md-4">
	                <h4 class="fw-bold">공지사항</h4>
	            </div>
	            <div class="col-md-8 text-end">
	                <form class="d-inline-flex gap-2" action = "<c:url value = '/admin/contents/notice'/>" >
	                    <select class="form-select form-select-sm" style="width: 150px;" name = "searchType">
	                        <option value="noticeTitle" ${param.searchType=='noticeTitle' ? 'selected' : '' }>제목</option>
	                        <option value="content" ${param.searchType=='content' ?  'selected' : ''}>내용</option>
	                        <option value="subject_content" ${param.searchType=='subject_content' ?  'selected' : ''}>제목 + 내용</option>
	                    </select>
	                    <div class="input-group input-group-sm" style="width: 300px;">
	                        <span class="input-group-text">
	                        	검색명 <span class="text-danger ms-1">*</span>
	                        </span>
	                        <input type="text" name = "searchKeyword" value ="${param.searchKeyword }" 
	                        	class="form-control" placeholder="검색어를 입력해 주세요.">
	                        <button class="btn btn-primary" type="submit">검색</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	
	        <div class="table-responsive">
	            <table class="table table-hover text-center align-middle border-top">
	                <thead class="table-light">
	                    <tr>
	                        <th>No</th>
	                        <th>제목 <i class="bi bi-caret-down-fill"></i></th> 
	                        <th>게시 일자 <i class="bi bi-caret-down-fill"></i></th>
	                        <th>대상 <i class="bi bi-caret-down-fill"></i></th>
	                        <th>조회수 <i class="bi bi-caret-down-fill"></i></th>
	                    </tr>
	                </thead>
	                <tbody>
	                <c:choose>
	                <%-- 검색 결과(데이터) 있을 때 --%>
	                <%-- 구분 필요함!! --%>
	                	<c:when test="${not empty noticeList}">
	                    <c:forEach items="${noticeList}" var="notice" varStatus = "status">
	                    	<c:if test="${notice.status == 'Y' }">
		                        <tr>
		                            <td>${status.count}</td>
		                            <td class="text-start text-center">
		                                <a href="<c:url value='/help/noticeDetail?noticeId=${notice.noticeId}' />" class="  text-decoration-none text-dark">
		                                    ${notice.noticeTitle}
		                                </a>
		                            </td>
		                            <td>
		                            <fmt:formatDate value="${notice.regDate}" pattern="yyyy-MM-dd"/>
		                            </td>
		                            <td>
										<c:if test="${notice.userType == 'all' }">전체</c:if>
		                            	<c:if test="${notice.userType == 'user' }">구직자</c:if>
		                            	<c:if test="${notice.userType == 'com' }">기업회원</c:if>
									</td>
		                            <td>
		                            	${notice.readcount } 회
		                            </td>
		                        </tr>
	                        </c:if>
	                    </c:forEach>
	                    </c:when>
	                    <%-- 검색 결과 없는 경우 --%>
	                    <c:otherwise>
	                    	<tr>
	                    		<td colspan="5" class="text-center py-5 text-muted">
	                    			<i class="bi bi-exclamation-circle fs-2 d-bold mb-2"></i>
	                    			검색 결과가 없습니다.
	                    		</td>
	                    	</tr>
	                    </c:otherwise>
	                    </c:choose>
	                </tbody>
	            </table>
	        </div>
	        
			<c:if test="${not empty param.searchKeyword}">
				<c:set var="searchParams" 
						value="searchType=${param.searchType}&searchKeyword=${param.searchKeyword}" />
			</c:if>
			<%-- 최대페이지번호가 존재하고, 0보다 클 경우에만 페이지 목록 표시 --%>
			<c:if test="${not empty pageInfoDTO and not empty pageInfoDTO.maxPage and pageInfoDTO.maxPage > 0}">
				<nav>
					<ul class="pagination justify-content-center">
						<%-- 이전 버튼은 현재 페이지 번호가 1보다 클 경우에만 동작하고, 1일 경우에는 비활성화(또는 1보다 작거나 같을 때) --%>
						<li class="page-item <c:if test="${pageInfoDTO.pageNum eq 1}">disabled</c:if>">
							<a class="page-link" href="<c:url value="/board/list?pageNum=${pageInfoDTO.pageNum - 1}&${searchParams}" />">이전</a>
						</li>
						
						<%-- startPage 부터 endPage 까지 1씩 증가하면서 페이지번호 출력 --%>
						<c:forEach var="i" begin="${pageInfoDTO.startPage}" end="${pageInfoDTO.endPage}">
							<%-- 페이지번호가 현재페이지와 같은 항목은 active 클래스 추가 --%>
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
						
						<%-- 다음 버튼은 현재 페이지 번호가 최대 페이지 번호보다 작을 경우에만 동작하고, 같을 경우에는 비활성화(또는 이상일 경우) --%>
						<li class="page-item <c:if test="${pageInfoDTO.pageNum eq pageInfoDTO.maxPage}">disabled</c:if>">
							<a class="page-link" href="<c:url value="/board/list?pageNum=${pageInfoDTO.pageNum + 1}&${searchParams}" />">다음</a>
						</li>
					</ul>
				</nav>
			</c:if>
	    </div>
	</main>
</body>
</html>