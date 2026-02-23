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
    <h2 class="mb-5">기업회원 관리</h2>

	<!-- 탭 메뉴 -->
    <ul class="nav nav-tabs" id="memberTab" role="tablist">
        <li class="nav-item">
            <button class="nav-link ${activeTab eq 'all' ? 'active' : ''}"
                    data-bs-toggle="tab"
                    data-bs-target="#all"
                    type="button">전체 회원</button>
        </li>
        <li class="nav-item">
            <button class="nav-link ${activeTab eq 'withdraw' ? 'active' : ''}"
                    data-bs-toggle="tab"
                    data-bs-target="#withdraw"
                    type="button">탈퇴 회원</button>
        </li>
    </ul>

	<!-- 탭 컨텐츠 -->
    <div class="tab-content mt-3">
		
		<!-- 전체 회원 -->
        <div class="tab-pane fade ${activeTab eq 'all' ? 'show active' : ''}"
             id="all">

            <!-- 전체 회원 검색 -->
            <div class="container w-50 my-4 mx-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-3">검색</h5>

                        <form action="<c:url value='/admin/coms' />"
                              method="get"
                              class="row g-3 align-items-center">

                            <!-- 탭 유지용 -->
                            <input type="hidden" name="activeTab" value="all"/>

                            <div class="col-md-5">
                                <label class="form-label">기업명</label>
                                <input type="search" class="form-control"
                                       name="keyword"
                                       placeholder="기업명을 입력하세요">
                            </div>

                            <div class="col-md-3">
                                <label class="form-label">구분</label>
                                <select class="form-select" name="type">
                                    <option value="all">전체</option>
                                    <option value="basic">일반</option>
                                    <option value="premium">프리미엄</option>
                                </select>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label">상태</label>
                                <select class="form-select" name="status">
                                    <option value="">전체</option>
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
                <form action="<c:url value='/admin/coms' />" method="get">
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
                            <th>기업명</th>
                            <th>E-Mail</th>
                            <th>사업자번호</th>
                            <th>전화번호</th>
                            <th>구분</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="com" varStatus="status" items="${comList}">
                            <tr class="clickable-row"
                                onclick="location.href='coms/info?userId=${com.userId}'">
                                <td>${status.count}</td>
                                <td>${com.userId}</td>
                                <td>${com.userName}</td>
                                <td>${com.email}</td>
                                <td>-</td>
                                <td>${com.phone}</td>
                                <td>${com.userType}</td>
                                <td>${com.status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>


        <!-- 탈퇴 회원 -->
        <div class="tab-pane fade ${activeTab eq 'withdraw' ? 'show active' : ''}"
             id="withdraw">

            <!-- 탈퇴 회원 검색 -->
            <div class="container w-50 my-4 mx-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-3">검색</h5>

                        <form action="<c:url value='/admin/coms' />"
                              method="get"
                              class="row g-3 align-items-center">

                            <!-- 탭 유지용 -->
                            <input type="hidden" name="activeTab" value="withdraw"/>

                            <div class="col-md-5">
                                <label class="form-label">기업명</label>
                                <input type="search"
                                       class="form-control"
                                       name="keyword"
                                       placeholder="기업명을 입력하세요">
                            </div>

                            <div class="col-md-5">
                                <label class="form-label">탈퇴일</label>
                                <input type="date"
                                       class="form-control"
                                       name="withdrawDate">
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
                <form action="<c:url value='/admin/coms' />" method="get">
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
                            <th>기업명</th>
                            <th>E-Mail</th>
                            <th>사업자번호</th>
                            <th>탈퇴일자</th>
                            <th>회원삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="withdraw" varStatus="status" items="${comWithdraw}">
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