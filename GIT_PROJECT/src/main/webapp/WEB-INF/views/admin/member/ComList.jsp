<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

	<main class="container mt-4">
		<h2 class="mb-3">기업회원 관리</h2>
		<div class="container w-50 my-4 mx-3">
			<div class="card">
			    <div class="card-body">
				      <h5 class="card-title mb-3">조건별 검색</h5>
				      <form class="row g-3 align-items-center">
				        <!-- 제목 검색 -->
				        <div class="col-md-4">
				          <label for="keyword" class="form-label">제목</label>
				          <input type="search" class="form-control" id="keyword" placeholder="키워드를 입력하세요">
				        </div>
				
				        <!-- 구분 -->
				        <div class="col-md-3">
				          <label for="type" class="form-label">구분</label>
				          <select class="form-select" id="type" onchange="selectType()">
				            <option value="all">전체</option>
				            <option value="basic">일반</option>
				            <option value="premium">프리미엄</option>
				          </select>
				        </div>
				
				        <!-- 상태 -->
				        <div class="col-md-3">
				          <label for="status" class="form-label">상태</label>
				          <select class="form-select" id="status" onchange="selectStatus()">
				            <option value="">전체</option>
				            <option value="active">활성</option>
				            <option value="block">차단</option>
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
				<option value="all">전체</option>
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
							<th>기업명</th>
							<th>E-Mail</th>
							<th>사업자번호</th>
							<th>전화번호</th>
							<th>구분</th>
							<th>상태</th>
						</tr>
					</thead>
					<!-- tbody 필요 -->
		 

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
							<th>기업명</th>
							<th>E-Mail</th>
							<th>사업자번호</th>
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
</body>
</html>