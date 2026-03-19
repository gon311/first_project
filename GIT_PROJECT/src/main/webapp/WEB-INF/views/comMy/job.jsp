<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/comMyCss/job.css'/>" type="text/css">
</head>


<body>
<%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>

<!-- URL -->
<c:url var="urlJobList" value="/comMy/job"/>
<c:url var="urlJobCreate" value="/job/JobPosting"/>
<c:url var="urlApplicantManage" value="/job/ApplicantManage"/>   <%-- ?jobId= --%>
<c:url var="urlJobDetail" value="/job/JobDetail"/>               <%-- ?jobId= (있으면 사용) --%>
<c:url var="urlJobEdit" value="/job/edit"/>                   <%-- ?jobId= (있으면 사용) --%>
<c:url var="urlJobDelete" value="/comMy/delete"/>				  <!-- 삭제 -->

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 왼쪽 사이드바(inc) --%>
    <%@ include file="/WEB-INF/views/inc/comMySidebar.jspf" %>

    <%-- ✅ 오른쪽 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <div class="page-top">
          <div>
            <h2 class="page-title">공고 관리</h2>
            <div class="page-desc">내 공고를 확인하고, 공고별로 지원자를 관리할 수 있어요.</div>
          </div>

          <%-- 공고 등록 버튼 --%>
          <a class="btn-primaryish" href="${urlJobCreate}">
            + 공고 등록
          </a>
        </div>

        <%-- =========================
             상단 필터/검색
           ========================= --%>
        <form action="${urlJobList}" method="get" class="toolbar">

          <div class="toolbar-left">

            <select class="select" name="size" onchange="this.form.page.value=1; this.form.submit()">
              <option value="5"  ${pager.size==5  ? 'selected' : ''}>5개씩</option>
              <option value="10" ${pager.size==10 ? 'selected' : ''}>10개씩</option>
              <option value="15" ${pager.size==15 ? 'selected' : ''}>15개씩</option>
            </select>

            <%-- 상태: OPEN/CLOSED/DRAFT 등 컨트롤러랑 맞춰줘 --%>
            <select class="select" name="status" onchange="this.form.page.value=1; this.form.submit()">
              <option value="all" ${status=='all' ? 'selected' : ''}>전체</option>
              <option value="open" ${status=='open' ? 'selected' : ''}>진행중</option>
              <option value="closed" ${status=='closed' ? 'selected' : ''}>마감</option>
            </select>

            <input type="hidden" name="page" value="${pager.page}">
          </div>

          <div class="toolbar-right">
            <div class="search-wrap">
              <i class="bi bi-search search-ico"></i>
              <input type="text" name="q" value="${q}" placeholder="공고 제목/키워드를 검색해 보세요">
            </div>
          </div>

        </form>

        <%-- =========================
             공고 목록
           ========================= --%>

        <c:if test="${empty jobs}">
          <div class="empty">
            <div style="font-size:48px;">📄</div>
            <div class="big">등록된 공고가 없습니다</div>
            <div class="sub">지금 바로 공고를 등록하고 지원자를 받아보세요.</div>
            <div class="actions">
              <a class="btn-primaryish" href="${urlJobCreate}">+ 공고 등록</a>
            </div>
          </div>
        </c:if>

        <c:if test="${not empty jobs}">
          <div class="list-wrap">

            <c:forEach var="j" items="${jobs}">
              <div class="jobCard">

                <div class="jobLeft">
                  <%-- 제목 클릭: 공고 상세가 있으면 사용 --%>
                  <a class="jobTitle" href="${urlJobDetail}?jobId=${j.jobId}">
                    ${j.title}
                  </a>

                  <div class="jobMeta">
                    <span>📍 ${j.address}</span>
                    <span>🧩 ${j.empType}</span>
                    <span>🗓 ${j.openDateText} ~ ${j.closeDateText}</span>
                    <span>👥 지원자 ${j.applyCount}명</span>
                  </div>
                </div>

                <div class="jobRight">
                  <%-- 상태 배지 --%>
                  <div class="jobStatus">
                    <c:choose>
                      <c:when test="${j.postStatus == 'OPEN'}">
                        <span class="badge badge-open">진행중</span>
                      </c:when>
                      <c:when test="${j.postStatus == 'CLOSED'}">
                        <span class="badge badge-closed">마감</span>
                      </c:when>
                    </c:choose>
                  </div>

                  <%-- 액션 버튼들 --%>
                  <div class="btns">
                    <a class="btn-strong" href="${urlApplicantManage}?jobId=${j.jobId}">
                      지원자 관리
                    </a>

                    <%-- 수정 페이지가 있으면 살리고, 없으면 지워도 됨 --%>
                    <a class="btn-lite" href="${urlJobEdit}?jobId=${j.jobId}">
                      공고 수정
                    </a>

                    <!-- 삭제버튼 -->
                    <form action="${urlJobDelete}" method="post" class="delete-form"
                          onsubmit="return confirm('이 공고를 삭제하시겠습니까?');">
                      <input type="hidden" name="jobId" value="${j.jobId}">
                      <button type="submit" class="btn-danger">공고 삭제</button>
                    </form>

                  </div>

                </div>

              </div>
            </c:forEach>

          </div>

          <%-- ✅ 페이저 --%>
          <div class="pager">
            <c:if test="${pager.hasPrev}">
              <a href="?period=${period}&status=${status}&q=${q}&page=${pager.page-1}&size=${pager.size}">이전</a>
            </c:if>

            <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
              <a href="?period=${period}&status=${status}&q=${q}&page=${i}&size=${pager.size}"
                 class="${i == pager.page ? 'active' : ''}">
                ${i}
              </a>
            </c:forEach>

            <c:if test="${pager.hasNext}">
              <a href="?period=${period}&status=${status}&q=${q}&page=${pager.page+1}&size=${pager.size}">다음</a>
            </c:if>
          </div>

        </c:if>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script type="text/javascript">
    var msg = "${msg}";
    if (msg && msg !== "") {
        alert(msg);
    }
</script>
</body>
</html>
