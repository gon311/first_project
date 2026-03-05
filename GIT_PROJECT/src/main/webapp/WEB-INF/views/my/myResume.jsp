<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/my/myResume.css'/>" type="text/css">
</head>



<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<!-- 수정 URL들 -->
<c:url var="urlMyResume" value="/my/myResume"/>
<c:url var="urlResumeCreate" value="/my/resume/create"/>   <%-- 새 이력서 작성 --%>
<c:url var="urlResumeEdit" value="/my/resume/edit"/>       <%-- 수정 --%>
<c:url var="urlResumeDelete" value="/my/resume/delete"/>   <%-- 삭제(나중에 POST) --%>
<c:url var="urlResumeDetail" value="/my/resume/detail"/>   <%-- 디테일 --%>


<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 좌측 사이드바 include --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 우측 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <%-- 타이틀 --%>
        <h2 class="page-title">내 이력서</h2>
        <div class="page-desc">이력서를 관리하고, 필요할 때 빠르게 수정할 수 있어요.</div>

        <%-- 상태 필터 (ALL/DRAFT/COMPLETE) --%>
        <c:set var="filter" value="${empty param.filter ? 'ALL' : param.filter}"/>

        <div class="topbar">
          <div class="countText">
            총 <strong><c:out value="${empty myResumes ? 0 : fn:length(myResumes)}"/></strong>건
          </div>

          <div class="d-flex align-items-center gap-2">
            <%-- 새 이력서 (POST 추천이면 form으로 바꾸면 됨) --%>
            <a class="btn btn-outline-primary" href="${urlResumeCreate}">
              이력서 만들기
            </a>

            <select class="form-select filterSelect"
                    aria-label="filter"
                    onchange="location.href='${urlMyResume}?filter=' + this.value;">
              <option value="ALL"      ${filter eq 'ALL' ? 'selected' : ''}>전체</option>
              <option value="DRAFT"    ${filter eq 'DRAFT' ? 'selected' : ''}>미완성</option>
              <option value="COMPLETE" ${filter eq 'COMPLETE' ? 'selected' : ''}>완성</option>
            </select>
          </div>
        </div>

        <%-- 리스트: myResumes + 필터 적용 --%>
        <div class="resumeList">
          <c:choose>
            <c:when test="${empty myResumes}">
              <div class="resumeCard" style="margin-top:16px;">
                아직 등록된 이력서가 없습니다.
              </div>
            </c:when>

            <c:otherwise>
              <c:forEach var="r" items="${myResumes}">
                <c:set var="isComplete" value="${r.status eq 'COMPLETE'}"/>

                <%-- 필터 통과 조건 --%>
                <c:if test="${filter eq 'ALL'
                              || (filter eq 'COMPLETE' && isComplete)
                              || (filter eq 'DRAFT' && not isComplete)}">

                  <div class="resumeCard">
                    <div class="resumeHeader">
                      <div>
                        <div>
                          <%-- 상태 배지 --%>
                          <c:choose>
                            <c:when test="${isComplete}">
                              <span class="badgeComplete">완성</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badgeDraft">미완성</span>
                            </c:otherwise>
                          </c:choose>

                          <%-- 제목 --%>
                          <span class="resumeTitle"><c:out value="${r.title}"/></span>
                        </div>

                        <%-- 메타 정보 --%>
                        <div class="metaRow">
                          <div class="metaItem">
                            <i class="bi bi-clock"></i>
                            <span>최종수정: <c:out value="${r.updatedAtStr}"/></span>
                          </div>

<%--                           <c:if test="${not empty r.memo}"> --%>
<!--                             <div class="metaItem"> -->
<!--                               <i class="bi bi-card-text"></i> -->
<%--                               <span>메모: <c:out value="${r.memo}"/></span> --%>
<!--                             </div> -->
<%--                           </c:if> --%>
                        </div>
                      </div>

                      <%-- 액션 --%>
                      <div class="d-flex align-items-center gap-2">
                        <a class="btn btn-outline-primary"
                           href="${urlResumeEdit}?resumeId=${r.resumeId}"
                           onclick="return confirm('이력서를 수정하시겠습니까?');">
                          수정
                        </a>

                        <form action="${urlResumeDelete}" method="post" style="display:inline;"
                              onsubmit="return confirm('정말 삭제할까요?');">
                          <input type="hidden" name="resumeId" value="${r.resumeId}" />
                          <button type="submit" class="btn btn-outline-danger">삭제</button>
                        </form>
                      </div>
                    </div>

                    <%-- 메모 바(선택) --%>
<%--                     <c:if test="${not empty r.memo}"> --%>
<!--                       <div class="memoBar"> -->
<!--                         <i class="bi bi-card-text"></i> -->
<%--                         <span><c:out value="${r.memo}"/></span> --%>
<!--                       </div> -->
<%--                     </c:if> --%>
                  </div>

                </c:if>
              </c:forEach>
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







