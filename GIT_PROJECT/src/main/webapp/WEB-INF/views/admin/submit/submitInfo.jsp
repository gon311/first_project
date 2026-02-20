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
		
            <h2 class="mb-4">기업 정보</h2>
		    <div class="row">
		        <div class="col border-end">
		        	<!-- 왼쪽 영역 -->
		        	<div class="row g-0">
						<table class="table mt-3">
						    <tr>
						        <th>아이디</th>
						        <td>${com.id}</td>
						    </tr>
						    <tr>
						        <th>회사명</th>
						        <td>${com.name}</td>
						    </tr>
						    <tr>
						        <th>사업자등록번호</th>
						        <td>${com.phone}</td>
						    </tr>
						    <tr>
						        <th>대표자명</th>
						        <td>${com.name}</td>
						    </tr>
						    <tr>
						        <th>전화번호</th>
						        <td>${com.phone}</td>
						    </tr>
						    <tr>
						        <th>이메일</th>
						        <td>${com.email}</td>
						    </tr>
						    <tr>
						        <th>회사 주소</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>담당자명</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>보유 이용권</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>상태</th>
						        <td>${com.status}</td>
						    </tr>
						</table>
			    	</div>
			    	<div class="text-end mt-2">
			    		<button type="button" id="block" class="btn btn-primary" onclick="block(${com.id})">승인</button>
						<button type="button" id="active" class="btn btn-secondary">보류</button>
						<button type="button" id="active" class="btn btn-danger">삭제</button>
			    		
					</div>
		        </div>
		        <div class="col">
		        	<!-- 오른쪽 영역 -->
		        	<div class="row">
						<!-- 공고명, 제출 일자, 게재 기간, 공고 상태, 공고 내용 -->
		        	</div>
		        </div>
		    </div>

		
	</main>
	
	<script type="text/javascript">
		// 승인, 보류 삭제 기능 구현
		
	</script>
	
</body>
</html>