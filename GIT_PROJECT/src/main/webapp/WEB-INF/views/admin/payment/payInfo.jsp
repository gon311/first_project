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
		<table class="table mt-3">
		    <tr>
		        <th>결제번호</th>
		        <td></td>
		    </tr>
		    <tr>
		        <th>아이디</th>
		        <td></td>
		    </tr>
		    <tr>
		        <th>이름</th>
		        <td></td>
		    </tr>
		    <tr>
		        <th>전화번호</th>
		        <td></td>
		    </tr>
		    <tr>
		        <th>회원유형</th>
		        <td></td>
		    </tr>
		    <tr>
		        <th>결제일시</th>
		        <td></td>
		    </tr>
		    <tr>
		        <th>결제 상품명</th>
		        <td></td>
		    </tr>
		    <tr>
		        <th>결제수단</th>
		        <td></td>
		    </tr>
		    <tr>
		        <th>결제금액</th>
		        <td></td>
		    </tr>
		    <tr>
		        <th>결제상태</th>
		        <td></td>
		    </tr>
		</table>
    	<div class="text-end mt-2">
			<button type="button" id="active" class="btn btn-danger">결제 취소</button>
    		
		</div>

		
	</main>
	
	<script type="text/javascript">
		// 승인, 보류 삭제 기능 구현
		
	</script>
	
</body>
</html>