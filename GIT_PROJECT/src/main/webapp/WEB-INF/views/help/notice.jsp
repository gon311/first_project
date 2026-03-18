<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<c:choose>
	    <c:when test="${sessionScope.memberType == 'company'}">
	        <%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>
	    </c:when>
	
	    <c:otherwise>
	        <%@ include file="/WEB-INF/views/inc/header.jspf" %>
	    </c:otherwise>
	</c:choose>
	
	<main class="container-fluid mt-4 pt-3">
	    <div class="card shadow-sm p-4">
	        <div class="row mb-3 align-items-center">
	            <div class="col-md-4">
	                <h4 class="fw-bold">공지사항</h4>
	            </div>
	            <div class="col-md-8 text-end">
	                <form class="d-inline-flex gap-2 md-4" action = "<c:url value = '/help/notice'/>" >
	                    <select class="form-select form-select-sm" style="width: 150px;" name = "type">
	                        <option value="all" ${searchDTO.type=='all' ? 'selected' : '' }>전체</option>
	                        <option value="noticeTitle" ${searchDTO.type=='title' ?  'selected' : ''}>제목</option>
	                        <option value="userType" ${searchDTO.type == 'userType' ? 'selected' : '' }>대상</option>
	                    </select>
	                    <div class="input-group input-group-sm" style="width: 300px;">
	                        <span class="input-group-text">
	                        	검색명 <span class="text-danger ms-1">*</span>
	                        </span>
	                        <input type="text" name = "keyword" value ="${searchDTO.keyword}" 
	                        	class="form-control" placeholder="검색어를 입력해 주세요.">
	                        <button class="btn btn-primary" type="submit">검색</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	
	        <div class="table-responsive mt-4 border-top">
	            <table class="table table-hover text-center align-middle border-top">
	                <thead class="table-light">
	                    <tr>
	                        <th>No</th>
	                        <th>공지사항 명 <i class="bi bi-caret-down-fill"></i></th> 
	                        <th>게시 일자 <i class="bi bi-caret-down-fill"></i></th>
	                        <th>대상 <i class="bi bi-caret-down-fill"></i></th>
	                    </tr>
	                </thead>
	                <tbody>
	                <c:choose>
	                <%-- 검색 결과(데이터) 있을 때 --%>
	                <%-- 구분 필요함!! --%>
	                	<c:when test="${not empty noticeList}">
	                    <c:forEach items="${noticeList}" var="notice" varStatus = "status">
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
	        <%-- pagenation --%>
       	 		 <c:if test="${not empty pageInfoDTO and not empty pageInfoDTO.maxPage and pageInfoDTO.maxPage > 0}">
			        <div class="d-flex flex-column align-items-center mt-5">
			            <nav aria-label="Page navigation">
			                <ul class="pagination pagination-sm m-0">
			                    <li class="page-item <c:if test="${pageInfoDTO.pageNum eq 1}">disabled</c:if>">
			                    	<a class="page-link" href="<c:url value="/help/notice?pageNum=${pageInfoDTO.pageNum - 1}" />">&lt;</a>
			                    </li>
			                    
			                    <c:forEach var="i" begin="${pageInfoDTO.startPage}" end="${pageInfoDTO.endPage}">
									<c:choose>
										<c:when test="${i eq pageInfoDTO.pageNum}">
											<a class="page-link active">${i}</a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="<c:url value="/help/notice?pageNum=${i}" />">${i}</a>
										</c:otherwise>
									</c:choose>
			                    </c:forEach>
			                    
			                    <li class="page-item <c:if test="${pageInfoDTO.pageNum eq pageInfoDTO.maxPage}">disabled</c:if>">
			                    	<a class="page-link" href="<c:url value="/help/notice?pageNum=${pageInfoDTO.pageNum + 1}" />">&gt;</a>
			                    </li>
			                </ul>
			            </nav>
					</div>
				</c:if>   
	            
	        </div>
	    </div>
	</main>
	
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>