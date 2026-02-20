<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

	<main class="container mt-4">
		<h2 class="mb-3">제출 공고 관리</h2>
		<div class="container w-50 my-4 mx-3">
        <h5 class="card-title mb-3">검색</h5>
			<div class="card">
			    <div class="card-body">
			    	 <form action="<c:url value="/admin/submits" />" name="searchForm" method="post" class="row g-3 align-items-center">
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
	
		<!-- 탭 콘텐츠 -->
		<div class="tab-content mt-3" id="memberTabContent">
			<!-- 전체 회원 -->
			<table class="table table-hover table-bordered align-middle text-center">
				<thead class="table-light">
					<tr>
						<th>No</th>
						<th>아이디</th>
						<th>제출일자</th>
						<th>제목</th>
						<th>기업명</th>
						<th>상태</th>
					</tr>
				</thead>
				<!-- tbody 필요 -->
	 			<tbody>
					<c:forEach var="submit" varStatus="status" items="${submitList}">
						<tr class="clickable-row" onclick="location.href='submits/info?id=${submit.id}'">
							<td>${status.count }</td>
							<td>${submit.id }</td>
							<td>${submit.openDate }</td>
							<td>${submit.title }</td>
							<td>${submit.compId }</td>
							<td>${submit.postStatus }</td>
						</tr>
					</c:forEach>
				</tbody>

			</table>
		</div>
	
	</main>
</body>
</html>