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
        <h2 class="mb-5">구직자회원 관리</h2>

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

        <!-- 탭 컨텐츠 -->
        <div class="tab-content mt-3" id="memberTabContent">

            <!-- 전체 회원 -->
            <div class="tab-pane fade ${activeTab eq 'all' ? 'show active' : ''}" 
                 id="all" role="tabpanel">

                <!-- 전체 회원 검색 -->
                <div class="container w-50 my-4 mx-3">
                    <h5 class="card-title mb-3">검색</h5>
                    <div class="card">
                        <div class="card-body">
                            <form action="<c:url value='/admin/users' />" method="get" class="row g-3 align-items-center">
                                
                                <div class="col-md-4">
                                    <label class="form-label">이름</label>
                                    <input type="text" class="form-control" name="keyword" placeholder="이름을 입력하세요">
                                </div>

                                <div class="col-md-3">
                                    <label class="form-label">구분</label>
                                    <select class="form-select" name="type">
                                        <option value="" selected>전체</option>
                                        <option value="p">기본</option>
                                        <option value="P-U10">10회권</option>
                                        <option value="P-U30">30회권</option>
                                        <option value="P-U60">60회권</option>
                                    </select>
                                </div>

                                <div class="col-md-3">
                                    <label class="form-label">상태</label>
                                    <select class="form-select" name="status">
                                        <option value="" selected>전체</option>
                                        <option value="active">활성</option>
                                        <option value="suspended">차단</option>
                                    </select>
                                </div>

                                <div class="col-12 d-flex justify-content-end mt-2">
				                    <button type="submit" class="btn btn-primary">검색</button>
				                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <!-- 정렬 -->
	            <div class="d-flex justify-content-end mt-3 mb-2">
	                <form action="<c:url value='/admin/users' />" method="get">
	                    <input type="hidden" name="activeTab" value="all"/>
	                    <input type="hidden" name="keyword" value="${param.keyword}">
	                    <input type="hidden" name="type" value="${param.type}">
	                    <input type="hidden" name="status" value="${param.status}">
	
	                    <select class="form-select w-auto"
	                            name="sort"
	                            onchange="">
	                        <option value="">전체</option>
	                        <option value="new" ${param.sort eq 'new' ? 'selected' : ''}>최근 일자순</option>
	                        <option value="old" ${param.sort eq 'old' ? 'selected' : ''}>오래된 순</option>
	                        <option value="abc" ${param.sort eq 'abc' ? 'selected' : ''}>가나다 순</option>
	                    </select>
	                </form>
	            </div>

                <!-- 전체 회원 테이블 -->
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
                        <tbody>
                            <c:forEach var="user" varStatus="status" items="${userList}">
                                <tr class="clickable-row" onclick="location.href='users/info?userId=${user.userId}'">
                                    <td>${status.count}</td>
                                    <td>${user.userId}</td>
                                    <td>${user.userName}</td>
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
                 id="withdraw" role="tabpanel">

                <!-- 탈퇴 회원 검색 -->
                <div class="container w-50 my-4 mx-3">
                    <h5 class="card-title mb-3">검색</h5>
                    <div class="card">
                        <div class="card-body">
                            <form action="<c:url value='/admin/users' />" method="get" class="row g-3 align-items-center">
                                
                                <div class="col-md-5">
                                    <label class="form-label">이름</label>
                                    <input type="text" class="form-control" name="keyword" placeholder="이름을 입력하세요">
                                </div>

                                <div class="col-md-5">
                                    <label class="form-label">탈퇴일</label>
                                    <input type="date" class="form-control" name="withdrawDate">
                                </div>

                                <div class="col-12 d-flex justify-content-end mt-2">
				                    <button type="submit" class="btn btn-primary">검색</button>
				                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <!-- 정렬 -->
	            <div class="d-flex justify-content-end mt-3 mb-2">
	                <form action="<c:url value='/admin/users' />" method="get">
	                    <input type="hidden" name="activeTab" value="withdraw"/>
	                    <input type="hidden" name="keyword" value="${param.keyword}">
	                    <input type="hidden" name="withdrawDate" value="${param.withdrawDate}">
	
	                    <select class="form-select w-auto"
	                            name="sort"
	                            onchange="">
	                        <option value="">전체</option>
	                        <option value="new" ${param.sort eq 'new' ? 'selected' : ''}>최근 탈퇴순</option>
	                        <option value="old" ${param.sort eq 'old' ? 'selected' : ''}>오래된 탈퇴순</option>
	                        <option value="abc" ${param.sort eq 'abc' ? 'selected' : ''}>가나다 순</option>
	                    </select>
	                </form>
	            </div>

                <!-- 탈퇴 회원 테이블 -->
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
                        <tbody>
                            <c:forEach var="withdraw" varStatus="status" items="${userWithdraw}">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${withdraw.userId}</td>
                                    <td>${withdraw.userName}</td>
                                    <td>${withdraw.email}</td>
                                    <td>${withdraw.phone}</td>
                                    <td>${withdraw.withdrawnAt}</td>
                                    <td>
                                        <button class="btn btn-danger">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>
    </main>

</body>
</html>