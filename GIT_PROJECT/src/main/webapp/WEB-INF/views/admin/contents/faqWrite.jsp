<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ 등록</title>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
   	<div class="container-fluid mt-4">
	<div class="card shadow-sm p-3">
    <div class="container w-50 my-5 mx-auto">
        <h4 class="fw-bold mb-4">새 FAQ 등록</h4>
        <div class="card shadow-sm border p-4">
            <form action="/admin/insertFaq" method="post">
                <div class="row mb-3">
              		<%--userType 구분(구직자/기업회원) --%>
                	<div class="col-md-6">
                    <label class="form-label fw-bold small text-muted">대상 구분</label>
                    <select name="userType" class="form-select">
                    	<option value="">선택</option>
                        <option value="user" ${userType eq 'user' ? 'selected' : '' }>구직자</option>
                        <option value="com" ${userType eq 'com' ? 'selected' : '' }>기업회원</option>
                    </select>
                	</div>
                	<%--카테고리(글 분류) --%>
                	<div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">질문 카테고리</label>
                        <select name="category" class="form-select">
                        	<option value="">선택</option>
                            <option value="account">계정/로그인</option>
                            <option value="service">이용문의</option>
                            <option value="error">오류보고</option>
                            <option value="etc">기타</option>
                        </select>
                    </div>
                </div> 	
                	
                	
                <div class="mb-3">
                    <label class="form-label fw-bold">질문 (제목)</label>
                    <input type="text" name="faqTitle" class="form-control" placeholder="질문을 입력하세요" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">답변 (내용)</label>
                    <textarea name="faqContent" class="form-control" rows="10" placeholder="상세 답변 내용을 입력하세요" required></textarea>
                </div>
                <div class="text-center mt-4">
                    <button type="button" class="btn btn-light border me-2" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-primary px-4">등록하기</button>
                </div>
            </form>
        </div>
    </div></div></div>
</body>
</html>