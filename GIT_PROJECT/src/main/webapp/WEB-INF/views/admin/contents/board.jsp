<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>자유게시판 관리</title>
    <%-- 기존 헤더 설정 포함 (Bootstrap 포함된 곳) --%>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%-- 공통 헤더 --%>
    <%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
    <div class="container-fluid mt-4">
		<div class="card shadow-sm p-3">
			<div class="container w-75 my-4 mx-auto">
        <h4 class="fw-bold mb-4">자유게시판 관리</h4>

        <div class="card shadow-sm border">
            <div class="card-body p-4">
                
                <%-- 검색 영역: FAQ 관리와 동일한 스타일 --%>
                <form action="${pageContext.request.contextPath}/admin/board" class="d-flex justify-content-end mb-4">
                    <div class="input-group" style="width: 350px;">
                        <input type="text" name="searchKeyword" class="form-control form-control-sm" 
                               placeholder="글 제목 검색" value="${param.searchKeyword}">
                        <button class="btn btn-outline-secondary btn-sm" type="submit">검색</button>
                    </div>
                </form>

                <%-- 게시글 테이블 --%>
                <div class="table-responsive">
                    <table class="table table-hover text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 10%;">글 번호</th>
                                <th style="width: 50%;">글 제목</th>
                                <th style="width: 10%;">작성자명</th>
                                <th style="width: 10%;">작성일자</th>
                                <th style="width: 10%">게시 상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty boardList}">
                                    <tr>
                                        <td colspan="4" class="py-5 text-muted text-center">게시글이 존재하지 않습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="board" items="${boardList}">
                                        <%-- 클릭 시 상세 페이지로 이동 --%>
                                        <tr onclick="location.href='${pageContext.request.contextPath}/admin/contents/boardDetail?postId=${board.postId}'" style="cursor:pointer;">
                                            <td>${board.postId}</td>
                                            <td class="text-start ps-4 text-center">${board.title}</td>
                                            <td>${board.authorMemberId}</td>
                                            <td class="text-muted small">
                                       			<fmt:parseDate var="createDate" value="${board.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
                                                <fmt:formatDate value="${createDate}" pattern="yyyy-MM-dd"/>
                                            </td>
                                            <td>
                                            <c:if test= '${board.status == "ACTIVE"}'>
                                            	게시
                                            </c:if>
                                            <c:if test = '${board.status == "DELETED"}'>
                                            	삭제
                                            </c:if>
                                           	</td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div> <%-- table-responsive 끝 --%>
                
            </div> <%-- card-body 끝 --%>
        </div> <%-- card 끝 --%>
    </div> <%-- container 끝 --%>
    </div></div>
</body>
</html>