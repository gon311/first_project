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
		
            <h2 class="mb-4">회원정보</h2>
		    <div class="row">
		        <div class="col border-end">
		        	<!-- 왼쪽 영역 -->
		        	<div class="row g-0">
						<table class="table mt-3">
						    <tr>
						        <th>아이디</th>
						        <td>${user.id}</td>
						    </tr>
						    <tr>
						        <th>이름</th>
						        <td>${user.name}</td>
						    </tr>
						    <tr>
						        <th>전화번호</th>
						        <td>${user.phone}</td>
						    </tr>
						    <tr>
						        <th>이메일</th>
						        <td>${user.email}</td>
						    </tr>
						    <tr>
						        <th>생년월일</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>성별</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>국적</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>가입일자</th>
						        <td>${user.joinedAt}</td>
						    </tr>
						    <tr>
						        <th>상태</th>
						        <td>${user.status}</td>
						    </tr>
						    <tr>
						        <th>신고횟수</th>
						        <td></td>
						    </tr>
						</table>
			    	</div>
			    	<div class="text-end mt-2">
			    		<c:choose>
			    			<c:when test="${user.status eq 'ACTIVE'}">
							    <button type="button" id="block" class="btn btn-danger" onclick="block(${user.id})">
							    차단</button>
			    			</c:when>
			    			<c:otherwise>
							    <button type="button" id="active" class="btn btn-danger">차단 해제</button>
			    			</c:otherwise>
			    		
			    		</c:choose>
					</div>
		        </div>
		        <div class="col">
		        	<!-- 오른쪽 영역 -->
		        	<div class="row">
		        	
		        	</div>
		        </div>
		    </div>

		
	</main>
	
	<script type="text/javascript">
		function block(id) {
			if(document.getElementById("block")) {
				if(confirm("차단하시겠습니까?")) {
					document.getElementById("block").innerText = "차단 해제";
				}
			} else {
				if(confirm("차단 해제하시겠습니까?")) {
					document.getElementById("active").innerText = "차단";
				}
			}
			
			location.href="<c:url value="/admin/block" />" + "?id=" + id;
			
		}
		
		
	</script>
	
</body>
</html>