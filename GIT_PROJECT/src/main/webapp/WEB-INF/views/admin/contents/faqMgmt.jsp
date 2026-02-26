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
  	<div class="container-fluid mt-4">
		<div class="card shadow-sm p-3">	
	<div class="container w-75 my-5 mx-auto">
    <h4 class="fw-bold mb-4">FAQ 상세 확인</h4>
    
    <div class="border border-primary rounded p-3 mb-4 d-flex align-items-center shadow-sm" style="border-width: 2px !important;">
        <span class="text-primary fw-bold fs-4 me-3">Q</span>
        <span class="fw-bold fs-5">${faq.faqTitle}</span>
    </div>

    <div class="bg-light rounded p-5 mb-4 border shadow-sm">
        <div class="text-secondary" style="line-height: 1.8; min-height: 200px;">
            ${faq.faqContent}
        </div>
        <hr class="my-4">
        <div class="d-flex justify-content-between text-muted small">
            <div>
<%--                 등록일 : ${faq.regDate} <span class="mx-2">|</span> 수정일 : ${faq.modDate} --%>
            </div>
<%--             <div>조회수 : ${faq.hitCount}</div> --%>
        </div>
    </div>

    <div class="text-end">
        <button class="btn btn-outline-dark" onclick="location.href='/admin/contents/faq'">목록으로</button>
        <button class="btn btn-warning" onclick="location.href='/admin/faqEdit?faqId=${faq.faqId}'">수정</button>
    </div>
</div></div></div>
	
	
	
</body>
</html>