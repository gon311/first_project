<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>배너 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<div class="container-fluid mt-4">
	<div class="card shadow-sm p-3">
	<div class="container w-75 my-4 mx-auto">
	<h4 class = "fw-bold"> 배너관리</h4>
			<br>
			
	<table class="table align-middle">
	    <thead class="table-light">
	        <tr>
	            <th>No</th>
	            <th>기업 명</th>
	            <th>기업 공고명</th>
	            <th>결제일</th>
	            <th>이용권 종료 일시</th>
	            <th>게시 상태</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach var="ad" items="${adList}" varStatus="status">
	            <tr>
	                <td>${ad.adId}</td>
	                <td>${ad.companyName}</td>
	                <td>${ad.jobTitle}</td>
	                <td><fmt:formatDate value="${ad.payDate}" pattern="yyyy.MM.dd"/></td>
	                <td><fmt:formatDate value="${ad.expiryDate}" pattern="yyyy.MM.dd"/></td>
	                <td>
	                    <div class="form-check form-switch">
	                        <input class="form-check-input" type="checkbox" 
	                               ${ad.isDisplay == 1 ? 'checked' : ''}
	                               onchange="updateStatus(${ad.adId}, this.checked)">
	                        <label class="form-check-label">${ad.isDisplay == 1 ? 'On' : 'off'}</label>
	                    </div>
	                </td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	</div></div></div>
</body>
</html>