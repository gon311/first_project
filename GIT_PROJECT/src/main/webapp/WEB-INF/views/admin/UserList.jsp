<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<%-- inc/head.jspf 파일을 현재 위치에 포함시키기 --%>
	<%-- JSP 문법이므로 루트(/)는 webapp 경로를 가리킴(잘못 지정했을 경우 오류 발생) --%>
	<%-- include 디렉티브 사용하여 페이지를 포함시키기(=정적 include) --%>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	
	<%-- 현재 페이지(main.jsp) 전용 CSS 영역 --%>
	
</head>
<body>
<%-- 헤더 영역 --%>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

	<main>
		<!-- 조건별 검색 -->
		<div>
		
		</div>
		
		<div class="container">
		  <div class="row justify-content-md-center">
<!-- 		    <div class="col col-lg-2"> -->
<!-- 		      1 of 3 -->
<!-- 		    </div> -->
		    <div class="col">
		      <div class="container text-center">
				  <div class="row">
				    <div class="col">
				      제목
				    </div>
				    <div class="col">
				      구분
				    </div>
				    <div class="col">
				      상태
				    </div>
				  </div>
				  <div class="row">
				    <div class="col">
				      <input type="search" placeholder="키워드를 입력하세요">
				    </div>
				    <div class="col">
				      <select class="form-select" id="type" onchange="selectType()"> <!-- form-select: 드롭다운 기본 스타일 -->
							<option value="">전체</option>
							<option value="new">기본</option>
							<option value="old">10회권</option>
							<option value="ganada">30회권</option>
							<option value="ganada">60회권</option>
						</select>
				    </div>
				    <div class="col">
				      <select class="form-select" id="type" onchange="selectType()"> <!-- form-select: 드롭다운 기본 스타일 -->
							<option value="">전체</option>
							<option value="new">활성</option>
							<option value="old">차단</option>
						</select>
				    </div>
				    <div class="row">
				    	<div class="col col-lg-2">
				      		<input type="button" value="검색">
				    	
				    	</div>
				    </div>
				    
				  </div>
				</div>
		    </div>
		    <div class="col-6 col-lg-2">
		      3 of 3
		    </div>
		  </div>
		  
		  <div class="row">
			   <div class="col">
			      <div>
					<ul class="nav nav-underline ms-4">
					  <li class="nav-item">
					    <a class="nav-link active" aria-current="page" href="#">Active</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link" href="#">Link</a>
					  </li>
					</ul>
				</div>
		    </div>
<!-- 		    <div class="col-md-auto"> -->
<!-- 		      <input type="search"> -->
<!-- 		    </div> -->
		    <div class="col col-lg-2">
		     	<select class="form-select" id="sort" onchange="selectSort()"> <!-- form-select: 드롭다운 기본 스타일 -->
					<option value="">전체</option>
					<option value="new">최근 일자순</option>
					<option value="old">오래된 순</option>
					<option value="ganada">가나다 순</option>
				</select>
		    </div>
		  </div>
		</div>
		
<!-- 		<div class="container text-center"> -->
<!-- 		  <div class="row"> -->
<!-- 		    <div> -->
<!-- 				<ul class="nav nav-underline ms-4"> -->
<!-- 				  <li class="nav-item"> -->
<!-- 				    <a class="nav-link active" aria-current="page" href="#">Active</a> -->
<!-- 				  </li> -->
<!-- 				  <li class="nav-item"> -->
<!-- 				    <a class="nav-link" href="#">Link</a> -->
<!-- 				  </li> -->
				  
<!-- 				</ul> -->
<!-- 			</div> -->
<!-- 		    <div class="col"> -->
<!-- 		      Column -->
<!-- 		    </div> -->
<!-- 		    <div class="col"> -->
<!-- 		      Column -->
<!-- 		    </div> -->
<!-- 		  </div> -->
<!-- 		</div> -->
		
		<!-- 탭 -->
<!-- 		<div> -->
<!-- 			<ul class="nav nav-underline ms-4"> -->
<!-- 			  <li class="nav-item"> -->
<!-- 			    <a class="nav-link active" aria-current="page" href="#">Active</a> -->
<!-- 			  </li> -->
<!-- 			  <li class="nav-item"> -->
<!-- 			    <a class="nav-link" href="#">Link</a> -->
<!-- 			  </li> -->
			  
<!-- 			</ul> -->
<!-- 		</div> -->
	
		<div align="center">
			<h1>구직자 목록</h1>
			
			<table border="1">
				<thead>
					<tr>
						<th>No</th>
						<th>아이디</th>
						<th>이름</th>
						<th>E-Mail</th>
						<th>전화번호</th>
						<th>구분</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<%-- 반복문(JSTL의 c:forEach 태그)을 사용하여 studentList 객체 반복 => tr 태그 반복을 통해 데이터 출력 --%>
					<c:forEach var="user" items="${userList }">
						<%-- row 클릭 시 /student/info?idx=xxx 형식으로 해당 학생 정보 조회 요청 --%>
						<tr class="clickable-row" onclick="location.href='info?idx=${user.idx}'">
							<td>${user.idx }</td>
							<td>${student.id }</td>
							<td>${student.name }</td>
							<td>${student.email }</td>
							<td>${student.phone }</td>
							<td>${student.type }</td>
							<td>${student.status }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<hr>
		</div>
	</main>
</body>
</html>