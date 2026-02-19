<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/WEB-INF/views/inc/head.jspf" %>	
<header class="border-bottom">
    <div class="d-flex justify-content-between align-items-center p-3 bg-white">
        <a href = "<c:url value ='/admin/main '/>" class = "text-decoration-none">
        	<h4 class="m-0 text-primary fw-bold">Main DashBoard</h4>
        </a>
        <div class="header-util">
            <a href="/project/" class="btn btn-sm btn-outline-secondary">사용자 페이지</a>
            <span class="badge bg-light text-dark mx-2">관리자 모드</span>
            <a href="/logout" class="btn btn-sm btn-danger">로그아웃</a>
        </div>
    </div>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="adminNav">
                <ul class="navbar-nav w-100 d-flex justify-content-around">
                	<!-- (변경사항) href 주소 변경 -->
                	<li class="nav-item dropdown">
                    	<a class="nav-link dropdown-toggle" href="#" id="contentDrop" role="button" 
                    	data-bs-toggle="dropdown" aria-expanded="false">사용자 관리</a>
                    	<ul class="dropdown-menu" aria-labelledby="contentDrop">
		                    <li><a class="dropdown-item" href="<c:url value="/admin/users" />">구직자 관리</a></li>
		                    <li><a class="dropdown-item" href="<c:url value="/admin/coms" />">기업회원 관리</a></li>
                    	</ul>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value="/admin/submits" />">기업 공고 관리</a></li>
<%--                     <li class="nav-item"><a class="nav-link" href="<c:url value="/admin/payments" />">결제 관리</a></li> --%>
                    
                    <!-- 사용자페이지의 요금제, 결제하기 페이지 확인을 위한 임시 하위 메뉴 -->
                    <li class="nav-item dropdown">
                    	<a class="nav-link dropdown-toggle" href="#" id="contentDrop" role="button" 
                    	data-bs-toggle="dropdown" aria-expanded="false">결제 관리</a>
                    	<ul class="dropdown-menu" aria-labelledby="contentDrop">
		                    <li><a class="dropdown-item" href="<c:url value="/admin/payments" />">결제 관리</a></li>
		                    <li><a class="dropdown-item" href="<c:url value="/admin/store" />">요금제</a></li>
		                    <li><a class="dropdown-item" href="<c:url value="/admin/pay" />">결제하기</a></li>
                    	</ul>
                    </li>
                    
                    <!-- (변경사항) 26.02.16 SYC dropdownlist 정리 -->
                    <li class="nav-item dropdown">
                    	<a class="nav-link dropdown-toggle" href="#" id="contentDrop" role="button" 
                    	data-bs-t
                    	
                    	
                    	
                    	
                    	
                    	
                    	
                    	oggle="dropdown" aria-expanded="false">컨텐츠 관리</a>
                    	<ul class="dropdown-menu" aria-labelledby="contentDrop">
		                    <li><a class="dropdown-item" href="<c:url value="/admin/contents/JobPost" />">채용공고 게시판 관리</a></li>
		                    <li><a class="dropdown-item" href="<c:url value="/admin/contents/notice" />">공지사항 관리</a></li>
		                    <li><a class="dropdown-item" href="<c:url value="/admin/contents/Board" />">커뮤니티 관리</a></li>
		                    <li><a class="dropdown-item" href="<c:url value="/admin/contents/QnA" />">문의글 관리</a></li>
		                    <li><a class="dropdown-item" href="<c:url value="/admin/contents/FnQ" />">FNQ 관리</a></li>
                    	</ul>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value="/admin/banners" />">배너 관리</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value="/admin/data" />">데이터 관리</a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>
