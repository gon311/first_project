<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<title>채용공고 게시판 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-4">
	    <div class="card shadow-sm p-3">
			<h4 class = "fw-bold"> 채용공고 게시판 관리</h4>
		<div class="container w-50 my-4 mx-3">
		
		<!-- 검색 항목 ㅋ -->
        <h5 class="card-title mb-3">검색</h5>
			<div class="card">
			    <div class="card-body">
			    	 <form action="<c:url value="/admin/search" />" name="searchForm" method="post" class="row g-3 align-items-center">
				        <div class="row my-3">
					        <!-- 기간별 검색 - 시작일자 -->
					        <div class="col-md-4">
					          <label for="period" class="form-label">기간별</label>
					          <input type="text" class="form-control" name="startDate" placeholder="시작 일자">
					          
					        </div>
					        
					        <!-- 키워드 검색 -->
					        <div class="col-md-4">
					          <label for="keyword" class="form-label">키워드</label>
					          <input type="text" class="form-control" name="keyword" placeholder="키워드를 입력하세요">
					        </div>
					
					        <!-- 구분 -->
					        <div class="col-md-4">
					          <label for="type" class="form-label">구분</label>
					          <select class="form-select" name="user_type">
					            <option value="" selected>전체</option>
					            <option value="approval">승인</option>
					            <option value="wait">검토전</option>
					            <option value="defer">보류</option>
					          </select>
					        </div>
					
					        
				        </div>
				        <div class="row my-0.5">
				        	<!-- 기간별 검색 - 종료일자 -->
				        	<div class="col-md-4">
					          <input type="text" class="form-control" name="endDate" placeholder="종료 일자">
					          
					        </div>
				        </div>
				
				        <!-- 검색 버튼 -->
				        <div class="col-12 d-flex justify-content-end mt-3">
							<button type="submit" class="btn btn-primary">검색</button>
						</div>

					</form>
				</div>
			</div>
		</div>
	

	
		<!-- 정렬 Select Box -->
		<div class="d-flex justify-content-end mt-3">
			<select class="form-select w-auto" id="sort" onchange="selectSort()">
				<option value="all">전체</option>
				<option value="new">최근 일자순</option>
				<option value="old">오래된 순</option>
				<option value="abc">가나다 순</option>
			</select>
		</div>
	
	    
	    
	    
		<div class="tab-content mt-3" id="memberTabContent">
			<table class="table table-hover table-bordered align-middle text-center">
				<thead class="table-light">
					<tr>
						<th>No</th>
						<th>공고ID</th> 
						<th>기업 회원 ID</th>
						<th>공고 제목</th>
						<th>모집 분야</th>
						<th>접수 기한</th>
						<th>공고 상태</th>
					</tr>
				</thead>
				<!-- tbody 필요 -->
	 			<tbody>
					<c:forEach var="jobPost" varStatus="status" items="${jobPostList}">
						<tr class="clickable-row" onclick="location.href='info?job_id=${jobPost.job_id}'">
							<td>${status.count }</td>
							<td>${jobPost.job_id }</td>
							<td>${jobPost.comp_id}</td>
							<td>${jobPost.title }</td>
							<td>${jobPost.field }</td>
							<td>${jobPost.period }</td>
							<td>${jobPost.post_status }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			
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
		</div>	
	</main>
</body>
</html>