<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>배너 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<div class="container-fluid mt-4">
	<div class="card shadow-sm p-3">
	<div class="container w-75 my-4 mx-auto">
	<h4 class = "fw-bold"> 배너관리</h4>
			<br>
			
	<table class="table align-middle">
	    <thead class="table-light">
	        <tr>
	            <th>No</th>
<!-- 	            <th>광고 Id</th> -->
	            <th>기업 Id</th>
	            <th>기업 공고명</th>
	            <th>이용권 시작 일시</th>
	            <th>이용권 종료 일시</th>
	            <th>게시 상태</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach var="ad" items="${adList}" varStatus="status">
	            <tr>
	            	<td>${status.count }
<%-- 	                <td>${ad.adId}</td> --%>
	                <td>${ad.compId}</td>
	                <td>${ad.title}</td>
	                <td><fmt:formatDate value="${ad.startDate}" pattern="yyyy.MM.dd"/></td>
	                <td><fmt:formatDate value="${ad.endDate}" pattern="yyyy.MM.dd"/></td>
	                <td>
	                    <div class="form-check form-switch">
	                        <input class="form-check-input" type="checkbox" 
	                               ${ad.isDisplay == 1 ? 'checked' : ''}
	                               onchange="updateStatus(${ad.adId}, this.checked)">
	                        <label class="form-check-label" for="switch_${ad.adId }" id ="label_${ad.adId}">
	                        	${ad.isDisplay == 1 ? 'On' : 'Off'}
                        	</label>
	                    </div>
	                </td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	</div></div></div>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		function updateStatus(adId, isChecked) {
    // 1: On, 0: Off 로 값 변환
    const status = isChecked ? 1 : 0;
    const label = document.getElementById('label_' + adId);

    // jQuery AJAX 시작
    $.ajax({
        url: '${pageContext.request.contextPath}/admin/updateAdStatus',
        type: 'POST',
        data: { 
            adId: adId, 
            isDisplay: status 
        },
        success: function(response) {
            if(response === "success") {
                label.innerText = isChecked ? 'On' : 'Off';
                console.log(adId + "배너 상태 변경 성공: " + status);
            }
        },
        error: function() {
            alert("상태 변경에 실패했습니다. 다시 시도해주세요.");
            document.getElementById('switch_' + adId).checked = !isChecked;
        }
    });
}

	</script>
	
</body>
</html>