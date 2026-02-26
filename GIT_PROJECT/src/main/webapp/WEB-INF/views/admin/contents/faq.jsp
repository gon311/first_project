<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ 관리자</title>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
    	<div class="container-fluid mt-4">
		<div class="card shadow-sm p-3">
    <div class="container w-75 my-4 mx-auto">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold m-0">FAQ 관리</h4>
            <%-- 새 글 등록 페이지로 이동하는 버튼 --%>
            <button class="btn btn-primary" onclick="location.href='<c:url value='/admin/contents/FaqWrite' />'">새 FAQ 등록</button>
        </div>
        <%-- 카테고리 탭 (기존 유지) --%>
        <ul class="nav nav-tabs border-bottom-0">
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
                <%-- 검색 영역 --%>
                <form action="/admin/faq" method="get" class="d-flex justify-content-end mb-4">
                    <div class="input-group" style="width: 300px;">
                        <input type="text" name="keyword" class="form-control form-control-sm" placeholder="제목 검색" value="${keyword}">
                        <button class="btn btn-outline-secondary btn-sm" type="submit">검색</button>
                    </div>
                </form>

                <div class="table-responsive">
                    <table class="table table-hover text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 15%;">글 번호</th>
                                <th style="width: 70%;">글 제목</th>
                                <th style="width: 15%;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="faq" items="${faqList}">
                                <tr>
                                    <td>${faq.faqId}</td>
                                    <td class="text-start ps-4">
                                        <%-- 제목 클릭 시 상세 정보(아코디언 스타일) 확인 페이지로 이동 --%>
                                        <a href="/admin/faqDetail?faqId=${faq.faqId}" class="text-decoration-none text-dark">${faq.faqTitle}</a>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-danger" onclick="deleteFaq(${faq.faqId})">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div></div></div>
</body>
</html>