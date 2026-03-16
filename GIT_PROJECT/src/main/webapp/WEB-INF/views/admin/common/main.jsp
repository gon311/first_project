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
		        <div class="chart-box" style="padding-top: 25px;">
               		<canvas id="weekly-revenue-chart"></canvas>
            	</div>
		      </div>
		    </div>
		    <div class="col-md-4 ">
				<div class="card p-3 shadow-sm border-0 h-100 text-center d-flex flex-column justify-content-center" 
					style="background: linear-gradient(135deg, #0d6efd 0%, #004aad 100%); color: white;">
		            <h5 class="mb-2" style="opacity: 0.9;">누적 결제 총액</h5>
		            <div class="display-5 fw-bold mb-2" id="total-revenue-sum">0원</div>
	            	<p class="small mb-0" style="opacity: 0.8;">최근 7일 기준 합계</p>
       			</div>
		    </div>
		  </div>
		</div>
		
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
<script src="${pageContext.request.contextPath}/resources/js/admin-stats.js"></script> 

<script>
// 페이지 로드시 기본값 실행
document.addEventListener("DOMContentLoaded", function() {
	initMainDashboard();
});
</script>   

				
</body>
</html>
