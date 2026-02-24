<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />

        
		<div class="container-fluid mt-4">
		<div class="row">
			<div class="col-md-8">
		      <div class="card p-3">
		        <h5>주간 수익 현황</h5>
		      </div>
		    </div>
		    <div class="col-md-4 ">
		      <div class="card p-3 text-center">
		        <h5>일간 트래픽 현황</h5>
		      </div>
		    </div>
		  </div>
		</div>
		
</body>
</html>
