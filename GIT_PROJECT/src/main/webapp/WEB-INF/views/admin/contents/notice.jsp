<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-4">
	    <div class="card shadow-sm p-3">
	        <div class="row mb-3 align-items-center">
	            <div class="col-md-4">
	                <h4 class="fw-bold">공지사항 관리</h4>
	            </div>
	            <div class="col-md-8 text-end">
	                <form class="d-inline-flex gap-2">
	                    <select class="form-select form-select-sm" style="width: 150px;">
	                        <option value="all">전체</option>
	                        <option value="notice_title">공지사항 명</option>
	                        <option value="reg_date">게시 일자</option>
	                        <option value="status">게시 상태</option>
	                        <option value="user_type">회원 유형</option>
	                    </select>
	                    <div class="input-group input-group-sm" style="width: 300px;">
	                        <span class="input-group-text">
	                        	검색명 <span class="text-danger ms-1">*</span>
	                        </span>
	                        <input type="text" class="form-control" placeholder="검색어를 입력해 주세요.">
	                        <button class="btn btn-primary" type="button">검색</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	
	        <div class="table-responsive">
	            <table class="table table-hover text-center align-middle border-top">
	                <thead class="table-light">
	                    <tr>
	                        <th>No</th>
	                        <th>공지사항 명 <i class="bi bi-caret-down-fill"></i></th> 
	                        <th>게시 일자 <i class="bi bi-caret-down-fill"></i></th>
	                        <th>상태 <i class="bi bi-caret-down-fill"></i></th>
	                        <th>회원 유형 <i class="bi bi-caret-down-fill"></i></th>
	                    </tr>
	                </thead>
	                <tbody>
	                <c:choose>
	                <%-- 검색 결과(데이터) 있을 때 --%>
	                <%-- 구분 필요함!! --%>
	                	<c:when test="${not empty noticeList}">
	                    <c:forEach items="${noticeList}" var="notice">
	                        <tr>
	                            <td>${notice.noticeId}</td>
	                            <td class="text-start">
	                                <a href="<c:url value='/admin/contents/noticeDetail?notice_id=${notice.noticeId}' />" class="  text-decoration-none text-dark">
	                                    ${notice.noticeTitle}
	                                </a>
	                            </td>
	                            <td>${notice.regDate}</td>
	                            <td><span>  ${notice.status == 'Y' ? '게시 중' : '임시저장'}</span></td>
	                            <td>${notice.userType}</td>
	                        </tr>
	                        

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
	
	        <div class="d-flex flex-column align-items-center mt-3">
	            <nav aria-label="Page navigation">
	                <ul class="pagination pagination-sm m-0">
	                    <li class="page-item"><a class="page-link" href="#">&lt;</a></li>
	                    <c:forEach begin="1" end="5" var="i">
	                        <li class="page-item ${i == 12 ? 'active' : ''}"><a class="page-link" href="#">${i}</a></li>
	                    </c:forEach>
	                    <li class="page-item"><a class="page-link" href="#">&gt;</a></li>
	                </ul>
	            </nav>
	            
	            <div class="w-100 text-end mt-2">
	                <a href="<c:url value='/admin/contents/noticeWrite' />" class="btn btn-outline-primary btn-sm">
	                    새로운 글 작성하기
	                </a>
	            </div>
	        </div>
	    </div>
	</main>
</body>
</html>