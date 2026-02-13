<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
    <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />

    <main class="container mt-4">
        </main>
</body>

<div class="container-fluid mt-4">
  <div class="row">
    <div class="col-md-8">
      <div class="card p-3">
        <h5>주간 수익 현황</h5>
        <canvas id="revenueChart"></canvas>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card p-3 text-center">
        <h5>일간 트래픽 현황</h5>
        <h2 class="text-primary">${trafficCount} <small>방문자</small></h2>
        <canvas id="trafficChart"></canvas>
      </div>
    </div>
  </div>
</div>
</body>
</html>
