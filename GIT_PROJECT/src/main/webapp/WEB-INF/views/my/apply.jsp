<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/my/apply.css'/>" type="text/css">
</head>


<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<!-- URL 수정 -->
<c:url var="urlApplyList" value="/my/apply"/>
<c:url var="urlJobDetail" value="/job/JobDetail"/>
<c:url var="urlCancelApply" value="/my/apply/cancel"/>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 왼쪽 사이드바(inc) --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 오른쪽 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">지원 내역</h2>
        <div class="page-desc">지원한 공고를 확인할 수 있어요.</div>

        <%-- =========================
             탭(전체/지원완료/최종발표)
           ========================= --%>
        <div class="tabs">
          <a class="tab ${currentTab=='all' ? 'active' : ''}"
             href="${urlApplyList}?tab=all&status=${status}&sort=${sort}&keyword=${keyword}&page=1&size=${pager.size}">
            전체 <span class="tab-badge">${cntAll}</span>
          </a>
          <a class="tab ${currentTab=='done' ? 'active' : ''}"
             href="${urlApplyList}?tab=done&status=${status}&sort=${sort}&keyword=${keyword}&page=1&size=${pager.size}">
            지원완료 <span class="tab-badge">${cntDone}</span>
          </a>
          <a class="tab ${currentTab=='final' ? 'active' : ''}"
             href="${urlApplyList}?tab=final&status=${status}&sort=${sort}&keyword=${keyword}&page=1&size=${pager.size}">
            최종발표 <span class="tab-badge">${cntFinal}</span>
          </a>
        </div>

        <%-- 요약 박스 --%>
        <div class="summary">
          <div class="summary-box">
            <div class="summary-title">지원완료</div>
            <div class="summary-num">${cntDone}</div>
          </div>
          <div class="summary-box">
            <div class="summary-title">최종발표</div>
            <div class="summary-num">${cntFinal}</div>
          </div>
        </div>

        <%-- =========================
             필터바 (GET 폼)
             - status/sort/keyword/page/size 유지
           ========================= --%>
        <form class="filterbar" method="get" action="${urlApplyList}">
          <input type="hidden" name="tab" value="${currentTab}" />
          <input type="hidden" name="page" value="1" /> <%-- 필터 바꾸면 1페이지로 --%>

          <div class="filter-left">
            <%-- 진행중/마감 --%>
            <select class="select" name="status" onchange="this.form.submit()">
              <option value="ALL"   ${status=='ALL' ? 'selected' : ''}>전체</option>
              <option value="OPEN"  ${status=='OPEN' ? 'selected' : ''}>진행중</option>
              <option value="CLOSED"${status=='CLOSED' ? 'selected' : ''}>마감</option>
            </select>

            <%-- 페이지 사이즈 (PageReq는 5/10/15만 허용이었지) --%>
            <select class="select" name="size" onchange="this.form.submit()">
              <option value="5"  ${pager.size==5 ? 'selected' : ''}>5개씩</option>
              <option value="10" ${pager.size==10 ? 'selected' : ''}>10개씩</option>
              <option value="15" ${pager.size==15 ? 'selected' : ''}>15개씩</option>
            </select>

            <%-- 정렬 --%>
            <select class="select" name="sort" onchange="this.form.submit()">
              <option value="APPLY_DESC"     ${sort=='APPLY_DESC' ? 'selected' : ''}>지원일 최신순</option>
              <option value="DEADLINE_ASC"   ${sort=='DEADLINE_ASC' ? 'selected' : ''}>마감 임박순</option>
              <option value="DEADLINE_DESC"  ${sort=='DEADLINE_DESC' ? 'selected' : ''}>마감 늦은순</option>
            </select>
          </div>

          <div class="filter-right">
            <div class="search-wrap">
              <i class="bi bi-search search-ico"></i>
              <input type="text" name="keyword" value="${keyword}" placeholder="회사명/공고명 검색">
            </div>
            <button type="submit" class="select" style="cursor:pointer;">검색</button>
          </div>
        </form>

        <%-- =========================
             리스트
           ========================= --%>
        <c:choose>
          <c:when test="${empty list}">
            <div class="empty">
              <div style="font-size:48px;">🧑‍💻</div>
              <div class="big">입사지원 내역이 없어요</div>
              <div>원하는 공고에 지원하면 여기에 기록돼요.</div>
            </div>
          </c:when>

          <c:otherwise>
            <div class="list">

              <c:forEach var="row" items="${list}">
                <div class="row-item">
					<div class="row-date">
					  <span>${row.applyDateStr}</span>
					  <span>~ ${row.closeDate}</span>
					</div>

                  <div class="row-mid">
                    <a class="title-link" href="${urlJobDetail}?jobId=${row.jobId}">
                      <c:out value="${row.title}" />
                    </a>

                    <div class="subline">
                      <c:out value="${row.companyName}" />
                      &nbsp;·&nbsp;
                      <c:out value="${row.expType}" />
                      <c:if test="${not empty row.expYear}">
                        &nbsp;(<c:out value="${row.expYear}" />)
                      </c:if>
                      &nbsp;·&nbsp;
                      <c:out value="${row.edu}" />
                      &nbsp;·&nbsp;
                      <c:out value="${row.address}" />
                      &nbsp;·&nbsp;
                      <c:out value="${row.empType}" />
                    </div>

                    <div class="subline" style="margin-top:6px;">
                      전형: <b><c:out value="${row.step}" /></b>
                    </div>
                  </div>

                  <div class="row-right">
                    <div class="status">
                      <c:out value="${row.statusLabel}" />
                      <c:if test="${row.closed}">
                        <span class="badge-closed">마감</span>
                      </c:if>
                    </div>
                    
					<c:if test="${row.statusLabel != '최종발표'}">
					  <form action="${urlCancelApply}" method="post" style="margin:0;"
					        onsubmit="return confirmCancel();">
					    <input type="hidden" name="applyId" value="${row.appId}" />
					    <button type="submit" class="btn-cancel">지원취소</button>
					  </form>
					</c:if>
								
                  </div>
                </div>
              </c:forEach>

            </div>

            <%-- =========================
                 페이지네이션
               ========================= --%>
            <div class="pager">
              <%-- 이전 --%>
              <c:url var="prevUrl" value="/my/apply">
                <c:param name="tab" value="${currentTab}"/>
                <c:param name="status" value="${status}"/>
                <c:param name="sort" value="${sort}"/>
                <c:param name="keyword" value="${keyword}"/>
                <c:param name="size" value="${pager.size}"/>
                <c:param name="page" value="${pager.page - 1}"/>
              </c:url>

              <a href="${prevUrl}" class="${pager.hasPrev ? '' : 'disabled'}">이전</a>

              <%-- 숫자 페이지 --%>
              <c:forEach var="p" begin="${pager.startPage}" end="${pager.endPage}">
                <c:url var="pageUrl" value="/my/apply">
                  <c:param name="tab" value="${currentTab}"/>
                  <c:param name="status" value="${status}"/>
                  <c:param name="sort" value="${sort}"/>
                  <c:param name="keyword" value="${keyword}"/>
                  <c:param name="size" value="${pager.size}"/>
                  <c:param name="page" value="${p}"/>
                </c:url>

                <a href="${pageUrl}" class="${pager.page == p ? 'active' : ''}">
                  ${p}
                </a>
              </c:forEach>

              <%-- 다음 --%>
              <c:url var="nextUrl" value="/my/apply">
                <c:param name="tab" value="${currentTab}"/>
                <c:param name="status" value="${status}"/>
                <c:param name="sort" value="${sort}"/>
                <c:param name="keyword" value="${keyword}"/>
                <c:param name="size" value="${pager.size}"/>
                <c:param name="page" value="${pager.page + 1}"/>
              </c:url>

              <a href="${nextUrl}" class="${pager.hasNext ? '' : 'disabled'}">다음</a>
            </div>
          </c:otherwise>
        </c:choose>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
  function confirmCancel(){
    return confirm("지원을 취소할까요?");
  }
</script>
</body>
</html>



