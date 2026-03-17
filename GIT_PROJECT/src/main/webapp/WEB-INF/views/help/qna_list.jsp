<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <style>
        .list-container { max-width: 900px; margin: 50px auto; padding: 20px; }
        .qna-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .qna-table th, .qna-table td { border-bottom: 1px solid #eee; padding: 15px; text-align: center; }
        .qna-table th { background-color: #f8f9fa; color: #333; }
        .status-pending { color: #ffc107; font-weight: bold; } /* 답변대기 */
        .status-completed { color: #28a745; font-weight: bold; } /* 답변완료 */
        .btn-write { float: right; padding: 10px 20px; background: #007bff; color: #fff; text-decoration: none; border-radius: 5px; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<div class="list-container">
    <h2>내 문의 내역</h2>
    <a href="<c:url value='/help/QnAWrite' />" class="btn-write">새 문의하기</a>
    
    <table class="qna-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>카테고리</th>
                <th>제목</th>
                <th>작성일</th>
                <th>답변상태</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty qnaList}">
                    <tr>
                        <td colspan="5">문의 내역이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="qna" items="${qnaList}">
                        <tr>
                            <td>${qna.qnaId}</td>
                            <td>
							    <c:choose>
							        <c:when test="${qna.qnaCategory eq 'job'}">입사지원 관련</c:when>
							        <c:when test="${qna.qnaCategory eq 'account'}">계정/인증 관련</c:when>
							        <c:when test="${qna.qnaCategory eq 'error'}">오류 신고</c:when>
							        <c:when test="${qna.qnaCategory eq 'etc'}">기타 문의</c:when>
							        <c:otherwise>${qna.qnaCategory}</c:otherwise> <%-- 혹시 모를 예외 대비 --%>
							    </c:choose>
							</td>
                            <td style="text-align: left;">
                                <a href="<c:url value='/help/detail?qnaId=${qna.qnaId}' />">${qna.qnaTitle}</a>
                            </td>
                            <td><fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${qna.reStatus eq 'pending'}">
                                        <span class="status-pending">답변대기</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-completed">답변완료</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>