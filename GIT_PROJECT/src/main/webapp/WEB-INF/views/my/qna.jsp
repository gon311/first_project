<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/my/qna.css'/>" type="text/css">
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<c:url var="urlQnaList" value="/my/qna"/>
<c:url var="urlQnaWrite" value="/help/QnAWrite"/>
<c:url var="urlQnaDetail" value="/help/QnADetail"/>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <section class="col-10 myContent">
      <div class="myContent-inner">

        <div class="page-head">
          <div>
            <h2 class="page-title">내 문의 내역</h2>
            <div class="page-desc">작성한 문의를 조회하고 답변 상태를 확인할 수 있어요.</div>
            <div class="page-desc">평일 09시 에서 17시 까지 문의하신 내용은 당일 답변해드립니다.</div>
            <div class="page-desc">17시 이후에 문의하신 내용은 다음날에 답변, 주말에 문의하신 내용은 그 다음주 월요일에 답변해 드립니다.</div>
          </div>

          <a href="${urlQnaWrite}" class="btn-write">새 문의하기</a>
        </div>

        <form action="${urlQnaList}" method="get" class="toolbar">
          <div class="toolbar-left">
            <select class="select" name="size" onchange="this.form.page.value=1; this.form.submit()">
              <option value="5"  ${pager.size==5  ? 'selected' : ''}>5개씩</option>
              <option value="10" ${pager.size==10 ? 'selected' : ''}>10개씩</option>
              <option value="15" ${pager.size==15 ? 'selected' : ''}>15개씩</option>
            </select>

            <select class="select" name="status" onchange="this.form.page.value=1; this.form.submit()">
              <option value="all" ${status=='all' ? 'selected' : ''}>전체</option>
              <option value="pending" ${status=='pending' ? 'selected' : ''}>답변대기</option>
              <option value="completed" ${status=='completed' ? 'selected' : ''}>답변완료</option>
            </select>

            <input type="hidden" name="page" value="${pager.page}">
          </div>

          <div class="toolbar-right">
            <div class="search-wrap">
              <i class="bi bi-search search-ico"></i>
              <input type="text" name="q" value="${q}" placeholder="제목을 검색해 보세요">
            </div>
            <button type="submit" class="btn-search">검색</button>
          </div>
        </form>

        <c:if test="${empty qnaList}">
          <div class="empty">
            <div style="font-size:48px;">📩</div>
            <div class="big">등록된 문의 내역이 없습니다</div>
            <div>문의 작성 후 답변 상태를 여기서 확인할 수 있어요</div>
          </div>
        </c:if>

        <c:if test="${not empty qnaList}">
          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th style="width:90px;">번호</th>
                  <th style="width:140px;">카테고리</th>
                  <th>제목</th>
                  <th style="width:140px;">작성일</th>
                  <th style="width:140px;">답변상태</th>
                </tr>
              </thead>

              <tbody>
                <c:forEach var="qna" items="${qnaList}">
                  <tr>
                    <td>${qna.qnaId}</td>
                    <td>
                      <span class="category-text">${qna.qnaCategory}</span>
                    </td>
                    <td class="td-left">
                      <a class="qna-link" href="${urlQnaDetail}?qnaId=${qna.qnaId}">
                        ${qna.qnaTitle}
                      </a>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${not empty qna.regDateText}">
                          ${qna.regDateText}
                        </c:when>
                        <c:otherwise>
                          <fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd"/>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${qna.reStatus == 'completed'}">
                          <span class="badge badge-completed">답변완료</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge badge-pending">답변대기</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <div class="pager">
            <c:if test="${pager.hasPrev}">
              <a href="?status=${status}&q=${q}&page=${pager.page-1}&size=${pager.size}">이전</a>
            </c:if>

            <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
              <a href="?status=${status}&q=${q}&page=${i}&size=${pager.size}"
                 class="${i == pager.page ? 'active' : ''}">
                ${i}
              </a>
            </c:forEach>

            <c:if test="${pager.hasNext}">
              <a href="?status=${status}&q=${q}&page=${pager.page+1}&size=${pager.size}">다음</a>
            </c:if>
          </div>
        </c:if>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>