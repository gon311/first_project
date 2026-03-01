<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ 수정</title>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
   	<div class="container-fluid mt-4">
	<div class="card shadow-sm p-3">
    <div class="container w-50 my-5 mx-auto">
        <h4 class="fw-bold mb-4">faq 수정</h4>
        <div class="card shadow-sm border p-4">
           <form action="<c:url value='/admin/contents/faqUpdateSave' />" method="post">
		    <input type="hidden" name="fqaId" value="${faq.faqId}">
		    
		    <div class="mb-3">
		        <label>제목</label>
		        <input type="text" name="faqTitle" class="form-control" value="${faq.faqTitle}">
		    </div>
		
		    <div class="mb-3">
		        <label>내용</label>
		        <textarea name="faqContent" class="form-control" rows="10">${faq.faqContent}</textarea>
		    </div>
		
		    <div class="mb-3">
		        <label>게시 유형</label>
		        <select name="userType" class="form-select">
		            <option value="all" ${faq.userType == 'all' ? 'selected' : ''}>전체</option>
		            <option value="com" ${faq.userType == 'com' ? 'selected' : ''}>기업회원</option>
		            <option value="user" ${faq.userType == 'user' ? 'selected' : ''}>구직자</option>
		        </select>
		    </div>
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
                    <br>
		    <button type="submit" class="btn btn-success">수정 완료</button>
		    <a href="javascript:history.back()" class="btn btn-secondary">취소</a>
		</form>
        </div>
    </div></div></div>
</body>
</html>