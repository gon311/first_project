<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<c:url var="urlApplyList" value="/my/apply"/>
<c:url var="urlJobDetail" value="/job/JobDetail"/>
<c:url var="urlCancelApply" value="/my/apply/cancel"/>

<style>
  body{ background:#f6f7fb; }
  .mypage-wrap{ min-height:100vh; }

  /* ✅ 사이드바(기존 틀 유지) */
  .mySidebar{ background:#fff; border-right:1px solid #e9edf3; min-height:100vh; }
  .mySidebar-inner{ position:sticky; top:0; padding:18px 14px; }
  .mySidebar-brand{ padding:6px 8px 16px; display:flex; align-items:center; gap:10px; }
  .brandText{ font-weight:900; letter-spacing:-.4px; color:#2563eb; font-size:1.2rem; }
  .myNav{ display:flex; flex-direction:column; gap:4px; }
  .myNav-link{
    display:flex; align-items:center; gap:10px;
    padding:10px 10px; border-radius:10px;
    text-decoration:none; color:#334155; font-weight:600; position:relative;
  }
  .myNav-link i{ font-size:1.05rem; color:#94a3b8; width:20px; text-align:center; }
  .myNav-link:hover{ background:#f3f6fb; }
  .myNav-link.active{ background:#eaf2ff; color:#1d4ed8; font-weight:800; }
  .myNav-link.active i{ color:#1d4ed8; }
  .myNav-link.active::before{
    content:""; position:absolute; left:-6px; top:10px; bottom:10px;
    width:3px; border-radius:999px; background:#1d4ed8;
  }

  /* ✅ 오른쪽 컨텐츠 카드 */
  .myContent{ padding:22px; }
  .myContent-inner{
    background:#fff;
    border:1px solid #eef2f7;
    border-radius:16px;
    box-shadow:0 10px 30px rgba(15,23,42,.04);
    padding:22px;
    min-height: calc(100vh - 80px);
  }

  .page-title{ font-size:1.6rem; font-weight:900; letter-spacing:-.6px; margin:0; }
  .page-desc{ color:#6b7280; font-size:.92rem; margin-top:8px; }

  /* 탭 */
  .tabs{
    margin-top: 14px;
    display:flex;
    gap: 18px;
    align-items:flex-end;
  }
  .tab{
    text-decoration:none;
    color:#6b7280;
    font-weight:900;
    padding: 10px 2px;
    border-bottom: 3px solid transparent;
  }
  .tab.active{
    color:#111827;
    border-bottom-color:#111827;
  }
  .tab-badge{
    display:inline-block;
    margin-left:6px;
    padding: 2px 8px;
    border-radius:999px;
    background:#eef2f7;
    color:#374151;
    font-size:.85rem;
    font-weight:900;
  }

  .summary{
    margin-top: 12px;
    display:flex;
    gap: 12px;
  }
  .summary-box{
    flex: 1;
    background:#f3f6fb;
    border:1px solid #eef2f7;
    border-radius:14px;
    padding: 14px 16px;
    display:flex;
    justify-content:space-between;
    align-items:center;
  }
  .summary-title{ color:#6b7280; font-weight:900; }
  .summary-num{ font-size:1.4rem; font-weight:900; color:#111827; }

  /* 필터바 */
  .filterbar{
    margin-top: 16px;
    display:flex;
    justify-content:space-between;
    gap: 10px;
    padding: 12px;
    border:1px solid #eef2f7;
    border-radius: 12px;
    background:#fff;
    flex-wrap:wrap;
  }
  .filter-left, .filter-right{
    display:flex; gap:10px; align-items:center; flex-wrap:wrap;
  }
  .select{
    border:1px solid #dbe2ee;
    border-radius:10px;
    padding:8px 12px;
    font-weight:900;
    color:#334155;
    background:#fff;
  }
  .search-wrap{
    display:flex;
    align-items:center;
    gap:8px;
    border:1px solid #dbe2ee;
    border-radius:10px;
    padding: 8px 12px;
    min-width: 280px;
  }
  .search-wrap input{ border:0; outline:none; width:220px; }
  .search-ico{ color:#94a3b8; font-size:1.1rem; }

  /* 리스트 */
  .list{
    margin-top: 14px;
    border-top: 1px solid #eef2f7;
  }
  .row-item{
    display:flex;
    align-items:flex-start;
    gap: 14px;
    padding: 18px 6px;
    border-bottom: 1px solid #eef2f7;
  }
  .row-date{
    width: 96px;
    color:#6b7280;
    font-weight:900;
    font-size:.92rem;
    padding-top: 3px;
  }
  .row-mid{ flex:1; min-width:0; }
  .title-link{
    display:inline-block;
    font-weight:900;
    font-size:1.1rem;
    color:#111827;
    text-decoration:none;
    max-width:100%;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
  }
  .title-link:hover{ text-decoration:underline; }
  .subline{
    margin-top:6px;
    color:#6b7280;
    font-size:.92rem;
  }
  .row-right{
    min-width: 220px;
    display:flex;
    justify-content:flex-end;
    align-items:center;
    gap: 10px;
    padding-top: 2px;
  }
  .status{
    font-weight:900;
    color:#111827;
    white-space:nowrap;
  }
  .badge-closed{
    display:inline-block;
    margin-left:8px;
    padding: 3px 10px;
    border-radius:999px;
    font-size:.82rem;
    font-weight:900;
    background:#f1f5f9;
    color:#64748b;
    border:1px solid #e2e8f0;
  }

  /* 페이지네이션 */
  .pager{
    margin-top: 18px;
    display:flex;
    justify-content:center;
    gap: 8px;
    flex-wrap:wrap;
  }
  .pager a{
    display:inline-block;
    min-width: 34px;
    text-align:center;
    padding: 8px 10px;
    border:1px solid #e5e7eb;
    border-radius: 10px;
    text-decoration:none;
    color:#374151;
    font-weight:900;
    background:#fff;
  }
  .pager a.active{
    background:#2563eb;
    border-color:#2563eb;
    color:#fff;
  }
  .pager a.disabled{
    pointer-events:none;
    opacity:.45;
  }

  /* 빈 상태 */
  .empty{
    margin-top: 34px;
    padding: 60px 0;
    text-align:center;
    color:#6b7280;
  }
  .empty .big{ font-weight:900; font-size:1.1rem; color:#111827; margin-top:10px; }
  
  .btn-cancel{
  background:#fff;
  border:1px solid #cbd5e1;
  color:#334155;
  font-weight:900;
  border-radius: 10px;
  padding: 10px 16px;
  }
	.btn-cancel:hover{ background:#f7f9fc; }
</style>

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
                  <div class="row-date">${row.applyDateStr}</div>

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

<script>
  function confirmCancel(){
    return confirm("지원을 취소할까요?");
  }
</script>



<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

