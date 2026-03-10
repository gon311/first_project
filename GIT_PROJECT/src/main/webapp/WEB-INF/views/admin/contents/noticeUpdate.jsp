<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항 상세정보 조회</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-4">
	<div class="card shadow-sm p-5">
        <form action="<c:url value='/admin/contents/noticeUpdateSave' />" method="post">
		    <input type="hidden" name="noticeId" value="${noticeDTO.noticeId}">
		    
		    <div class="mb-3">
		        <label>제목</label>
		        <input type="text" name="noticeTitle" class="form-control" value="${noticeDTO.noticeTitle}">
		    </div>
		
		    <div class="mb-3">
		        <label>내용</label>
		        <textarea name="noticeContent" class="form-control" rows="10">${noticeDTO.noticeContent}</textarea>
		    </div>
		
		    <div class="mb-3">
		        <label>게시 유형</label>
		        <select name="userType" class="form-select">
		            <option value="all" ${noticeDTO.userType == 'all' ? 'selected' : ''}>전체</option>
		            <option value="com" ${noticeDTO.userType == 'com' ? 'selected' : ''}>기업회원</option>
		            <option value="user" ${noticeDTO.userType == 'user' ? 'selected' : ''}>구직자</option>
		        </select>
		    </div>
		    <div>
			    <select name="status" class="form-select">
				    <option value="Y" ${noticeDTO.status == 'Y' ? 'selected' : ''}>게시</option>
				    <option value="N" ${noticeDTO.status == 'N' ? 'selected' : ''}>임시저장</option>
				</select>
			</div>
			<br>
		    <button type="submit" class="btn btn-success">수정 완료</button>
		    <a href="javascript:history.back()" class="btn btn-secondary">취소</a>
		</form>
	</div>
	</main>
</body>
</html>