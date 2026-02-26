<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<title>FaQ 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	
	<div class="container w-75 my-4 mx-auto">
    <h4 class="fw-bold mb-4">FAQ 관리</h4>

    <ul class="nav nav-tabs border-bottom-0" id="faqTab">
        <li class="nav-item">
            <button class="nav-link ${category eq 'user' or empty category ? 'active fw-bold' : ''}" 
                    onclick="location.href='?category=user'">구직자</button>
        </li>
        <li class="nav-item">
            <button class="nav-link ${category eq 'com' ? 'active fw-bold' : ''}" 
                    onclick="location.href='?category=com'">기업회원</button>
        </li>
    </ul>

    <div class="card shadow-sm" style="border-top-left-radius: 0; border: 1px solid #dee2e6;">
        <div class="card-body p-4">
            
            <form action="/admin/faq" method="get" class="d-flex justify-content-end mb-4">
                <input type="hidden" name="category" value="${category}">
                <div class="input-group style="width: 300px;">
                    <input type="text" name="keyword" class="form-control form-control-sm" 
                           placeholder="제목 검색" value="${keyword}">
                    <button class="btn btn-outline-secondary btn-sm" type="submit">검색</button>
                </div>
            </form>

            <div class="table-responsive">
                <table class="table table-hover text-center align-middle">
                    <thead class="table-light">
                        <tr>
                            <th style="width: 15%;">글 번호</th>
                            <th style="width: 85%;">글 제목</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty faqList}">
                                <tr><td colspan="2" class="py-5 text-muted">등록된 FAQ가 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="faq" items="${faqList}">
                                    <tr onclick="location.href='/admin/faqMgmt?faqId=${faq.faqId}'" style="cursor:pointer;">
                                        <td>${faq.faqId}</td>
                                        <td class="text-start ps-4">${faq.faqTitle}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
	
	
	
</body>
</html>