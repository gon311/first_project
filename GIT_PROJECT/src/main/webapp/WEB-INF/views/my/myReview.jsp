<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/my/myReview.css'/>">
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<!-- 수정 URL들 -->
<c:url var="urlMyReview" value="/my/myReview"/>
<c:url var="urlReviewCreate" value="/review/registForm"/>   <%-- 새 자소서 작성 --%>
<c:url var="urlReviewDelete" value="/my/review/delete"/>   <%-- 삭제 (나중에 POST 추천) --%>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">
	<!-- 사이드바 -->
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <section class="col-10 myContent">
      <div class="myContent-inner">

        <!-- 타이틀 -->
        <h2 class="page-title">내 자기소개서</h2>
        <div class="page-desc">자기소개서를 작성/관리하고, 필요할 때 빠르게 수정할 수 있어요.</div>

        <!-- 필터 기본값 -->
        <c:set var="filter" value="${empty param.filter ? 'ALL' : param.filter}"/>

        <!-- 상단: 총 건수 + 작성 버튼 + 상태 필터 -->
        <div class="topbar">
          <div class="countText">
            총 <strong><c:out value="${empty myReviews ? 0 : fn:length(myReviews)}"/></strong>건
          </div>

          <div class="d-flex align-items-center gap-2">
            <a class="btn btn-outline-primary" href="${urlReviewCreate}">
              새 자기소개서 작성
            </a>

            <select class="form-select filterSelect"
                    aria-label="filter"
                    onchange="location.href='${urlMyReview}?filter=' + this.value;">
              <option value="ALL"      ${filter eq 'ALL' ? 'selected' : ''}>전체</option>
              <option value="DRAFT"    ${filter eq 'DRAFT' ? 'selected' : ''}>미완성</option>
              <option value="COMPLETE" ${filter eq 'COMPLETE' ? 'selected' : ''}>완성</option>
            </select>
          </div>
        </div>

        <!-- 리스트 -->
        <div class="reviewList">
          <c:choose>
            <c:when test="${not empty myReviews}">
              <c:forEach var="rv" items="${myReviews}">

                <!-- 필터 조건: COMPLETE(0) / DRAFT(1,2) -->
                <c:if test="${filter eq 'ALL'
                              || (filter eq 'COMPLETE' && rv.status == 0)
                              || (filter eq 'DRAFT' && rv.status != 0)}">

                  <div class="reviewCard">
                    <div class="reviewHeader">

                      <div>
                        <div>
                          <!-- 상태 배지 -->
                          <c:choose>
                            <c:when test="${rv.status == 0}">
                              <span class="badgeComplete">완성</span>
                            </c:when>
                            <c:when test="${rv.status == 1}">
                              <span class="badgeDraft">작성중</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badgeDraft">임시저장</span>
                            </c:otherwise>
                          </c:choose>

                          <!-- 제목 -->
                          <span class="reviewTitle"><c:out value="${rv.title}"/></span>
                        </div>

                        <!-- 메타 -->
                        <div class="metaRow">
                          <div class="metaItem">
                            <i class="bi bi-building"></i>
                            <span>기업: <c:out value="${rv.companyName}"/></span>
                          </div>
                          <div class="metaItem">
                            <i class="bi bi-calendar3"></i>
                            <span>작성일: <c:out value="${rv.createdAtStr}"/></span>
                          </div>
                        </div>
                      </div>

                      <!-- 액션 -->
                      <div class="d-flex align-items-center gap-2">
                        <a class="btn btn-outline-primary"
                           href="<c:url value="/review/${rv.coverLetterIdx}/registText" />"
                           onclick="return confirm('자기소개서를 수정하시겠습니까?');">
                          수정
                        </a>
						
						<!-- 삭제 -->
						<form action="${urlReviewDelete}" method="post" style="display:inline;"
						      onsubmit="return confirm('정말 삭제하시겠습니까? 삭제 후 복구가 어려울 수 있어요.');">
						  <input type="hidden" name="coverLetterIdx" value="${rv.coverLetterIdx}" />
						  <button type="submit" class="btn btn-outline-danger">삭제</button>
						</form>
						
                      </div>

                    </div>
                  </div>

                </c:if>
              </c:forEach>
            </c:when>

            <c:otherwise>
              <div class="reviewCard">
                아직 작성한 자기소개서가 없습니다.
              </div>
            </c:otherwise>

          </c:choose>
        </div>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

</body>
</html>


