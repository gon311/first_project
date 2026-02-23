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
		<h2 class="mb-3">구직자회원 관리</h2>
		<div class="container w-50 my-4 mx-3">
        <h5 class="card-title mb-3">검색</h5>
			<div class="card">
			    <div class="card-body">
				      <form action="<c:url value="/admin/users" />" name="searchForm" method="post" class="row g-3 align-items-center">
				        <!-- 이름 검색 -->
				        <div class="col-md-4">
				          <label for="keyword" class="form-label">이름</label>
				          <input type="text" class="form-control" name="keyword" placeholder="이름을 입력하세요">
				        </div>
				
				        <!-- 구분 -->
				        <div class="col-md-3">
				          <label for="type" class="form-label">구분</label>
				          <select class="form-select" name="type">
				            <option value="" selected>전체</option>
				            <option value="p">기본</option>
				            <option value="c">10회권</option>
				            <option value="30">30회권</option>
				            <option value="60">60회권</option>
				          </select>
				        </div>
				
				        <!-- 상태 -->
				        <div class="col-md-3">
				          <label for="status" class="form-label">상태</label>
				          <select class="form-select" name="status">
				            <option value="" selected>전체</option>
				            <option value="active">활성</option>
				            <option value="suspended">차단</option>
				          </select>
				        </div>
				
				        <!-- 검색 버튼 -->
				        <div class="col-md-2 d-grid">
				          <button type="submit" class="btn btn-primary">검색</button>
				        </div>
				      </form>
				</div>
			</div>
		</div>
	
		<!-- 탭 메뉴 -->
		<ul class="nav nav-tabs" id="memberTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link ${activeTab eq 'all' ? 'active' : ''}" 
				        id="all-tab" 
				        data-bs-toggle="tab" 
				        data-bs-target="#all" 
				        type="button" role="tab">전체 회원</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link ${activeTab eq 'withdraw' ? 'active' : ''}" 
				        id="withdraw-tab" 
				        data-bs-toggle="tab" 
				        data-bs-target="#withdraw" 
				        type="button" role="tab">탈퇴 회원</button>
			</li>
		</ul>

	
		<!-- 정렬 Select Box -->
		<div class="d-flex justify-content-end mt-3">
			<select class="form-select w-auto" id="sort" onchange="selectSort()">
				<option value="">전체</option>
				<option value="new">최근 일자순</option>
				<option value="old">오래된 순</option>
				<option value="abc">가나다 순</option>
			</select>
		</div>
	
		<!-- 탭 콘텐츠 -->
		<div class="tab-content mt-3" id="memberTabContent">
			<!-- 전체 회원 -->
			<div class="tab-pane fade ${activeTab eq 'all' ? 'show active' : ''}" 
			     id="all" role="tabpanel" aria-labelledby="all-tab">
				<div class="table-responsive">
					<table class="table table-hover table-bordered align-middle text-center">
						<thead class="table-light">
							<tr>
								<th>No</th>
								<th>아이디</th>
								<th>이름</th>
								<th>E-Mail</th>
								<th>전화번호</th>
								<th>구분</th>
								<th>상태</th>
							</tr>
						</thead>
						<!-- tbody 필요 -->
			 			<tbody>
							<c:forEach var="user" varStatus="status" items="${userList}">
								<tr class="clickable-row" onclick="location.href='users/info?id=${user.id}'">
									<td>${status.count}</td>
									<td>${user.id}</td>
									<td>${user.name}</td>
									<td>${user.email}</td>
									<td>${user.phone}</td>
									<td>${user.userType}</td>
									<td>${user.status}</td>
								</tr>
							</c:forEach>
						</tbody>
	
					</table>
				</div>
			</div>
	
			<!-- 탈퇴 회원 -->
			<div class="tab-pane fade ${activeTab eq 'withdraw' ? 'show active' : ''}" 
			     id="withdraw" role="tabpanel" aria-labelledby="withdraw-tab">
				<div class="table-responsive">
					<table class="table table-hover table-bordered align-middle text-center">
						<thead class="table-light">
							<tr>
								<th>No</th>
								<th>아이디</th>
								<th>이름</th>
								<th>E-Mail</th>
								<th>전화번호</th>
								<th>탈퇴일자</th>
								<th>회원삭제</th>
							</tr>
						</thead>
						<!-- 데이터가 아직 없으므로 tbody는 주석 처리 -->
						
		
					</table>
				</div>
			</div>
		</div>
	</main>
	
	<script type="text/javascript">
		function selectSort(){
			if(document.getElementById("sort").value == "new") {
 				location.href="<c:url value="/admin/users" />" + "&sort=new";
			} else if(document.getElementById("sort").value == "old") {
 				location.href="<c:url value="/admin/users" />" + "&sort=old";
 			} else if(document.getElementById("sort").value == "abc") {
				location.href="<c:url value="/admin/users" />" + "&sort=abc";
 		}
	
	</script>
	
</body>
</html>