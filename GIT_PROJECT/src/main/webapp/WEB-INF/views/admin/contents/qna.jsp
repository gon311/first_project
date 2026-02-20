<%@page import="lombok.EqualsAndHashCode.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>1:1 문의글 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<div class="container-fluid mt-4">
		<div class="card shadow-sm p-3">
			<h4 class = "fw-bold"> 1:1문의글 관리</h4>
			<div class=" container w-50 my-4 mx-3">
			<!-- body영역  -->

			<!-- 상태별 구분 탭  -->
				<ul class="nav nav-tabs" id="qnaTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link ${re_status eq 'all' ? 'active' : ''}" 
						        id="all-tab" 
						        data-bs-toggle="tab" 
						        data-bs-target="#all" 
						        type="button" role="tab">전체 문의글</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link ${re_status eq 'pending' ? 'active' : ''}" 
						        id="pendingtab" 
						        data-bs-toggle="tab" 
						        data-bs-target="#pending" 
						        type="button" role="tab">미답변</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link ${re_status eq 'completed' ? 'active' : ''}" 
						        id="completed-tab" 
						        data-bs-toggle="tab" 
						        data-bs-target="#completed" 
						        type="button" role="tab">답변 완료</button>
					</li>
				</ul>
				

				<div class="d-flex justify-content-end mt-3">
					<select class="form-select w-auto" id="sort" onchange="selectSort()">
						<option value="all">전체</option>
						<option value="new">최근 일자순</option>
						<option value="old">오래된 순</option>
						<option value="abc">가나다 순</option>
					</select>
				</div>
				
				<div class="tab-content" id="qnaTabContent" style="padding-top: 20px;">
				    <div class="tab-pane fade show active">
				        <table class="table">
<%-- 				        	<c:if test ="${re_status == 'all' }" --%>
<%-- 					        	<%@include file = "/WEB-INF/views/admin/contents/qnaAll" %> --%>
<%-- 				        	</c:if> --%>
				        
<%-- 				        	<%@include file = "/WEB-INF/views/admin/contents/qnaPending" %> --%>
<%-- 				        	<%@include file = "/WEB-INF/views/admin/contents/qnaCompleted" %> --%>
				        
				        
				        </table>
				    </div>
				</div>

					
				
				
		
					
			
			</div>
	
			
			
			
			
			
			
			
			
			
		<!-- 페이지네이션 구현 -->	
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
			</div>
		</div>   <!-- card showdow  끝 -->
	</div>
</body>
</html>