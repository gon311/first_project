<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
	<html>
	<head>
		 <%@ include file="/WEB-INF/views/inc/head.jspf" %>
		 
		 <%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf" %>
		
		<%-- main area --%>
		<main>
		<form action="/review/reviewSave" name ="registText" method="post">
			<!-- 자소서 제목 영역 -->
			<div class="form-area"> 
				<div class="title">
				    <label>자소서 제목 <span class="text-danger">*</span></label>
				    <input type="text" id="title" name="title" value="${sessionScope.title}" required>
				</div>
				<!-- 질문선택 콤보박스 -->
				<div class="questions">
					<select>
						<option value=""></option>
					</select>
				</div>
				<!-- 글자수 표시  -->
				<!-- 입력창 -->
				<!-- 출력창 -->
				<!-- 버튼 -->
				
			</div>
		</form>
		
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
	
	</body>
</html>

