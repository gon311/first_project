<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>

<%-- =========================
     URL (전부 c:url)
   ========================= --%>
<c:url var="urlJobList" value="/comMy/job"/>
<c:url var="urlJobCreate" value="/job/JobPosting"/>
<c:url var="urlApplicantManage" value="/job/ApplicantManage"/>   <%-- ?jobId= --%>
<c:url var="urlJobDetail" value="/job/JobDetail"/>               <%-- ?jobId= (있으면 사용) --%>
<c:url var="urlJobEdit" value="/job/edit"/>                   <%-- ?jobId= (있으면 사용) --%>
<c:url var="urlJobDelete" value="/comMy/delete"/>				  <!-- 삭제 -->

<style>
  body{ background:#f6f7fb; }
  .mypage-wrap{ min-height:100vh; }

  /* ✅ 사이드바(공통 톤) */
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

  /* ✅ 오른쪽 컨텐츠 카드(공통 톤 유지) */
  .myContent{ padding:22px; }
  .myContent-inner{
    background:#fff;
    border:1px solid #eef2f7;
    border-radius:16px;
    box-shadow:0 10px 30px rgba(15,23,42,.04);
    padding:22px;
    min-height: calc(100vh - 80px);
  }

  .page-top{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    gap:12px;
  }
  .page-title{ font-size:1.6rem; font-weight:900; letter-spacing:-.6px; margin:0; }
  .page-desc{ color:#6b7280; font-size:.92rem; margin-top:8px; }

  .btn-primaryish{
    border:1px solid #1d4ed8;
    background:#2563eb;
    color:#fff;
    padding:10px 14px;
    border-radius:12px;
    font-weight:900;
    text-decoration:none;
    white-space:nowrap;
  }
  .btn-primaryish:hover{ filter:brightness(.96); }

  /* ✅ 상단 필터/검색 */
  .toolbar{
    margin-top: 18px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:12px;
    padding: 14px;
    border:1px solid #eef2f7;
    border-radius: 12px;
    background:#fff;
  }
  .toolbar-left, .toolbar-right{ display:flex; align-items:center; gap:10px; }
  .select{
    border:1px solid #dbe2ee;
    border-radius:10px;
    padding:10px 12px;
    font-weight:900;
    color:#334155;
    background:#fff;
    min-width: 140px;
  }
  .search-wrap{
    display:flex;
    align-items:center;
    gap:8px;
    border:1px solid #dbe2ee;
    border-radius:10px;
    padding: 10px 12px;
    min-width: 340px;
  }
  .search-wrap input{ border:0; outline:none; width: 300px; }
  .search-ico{ color:#94a3b8; font-size:1.1rem; }

  /* ✅ 목록 카드 */
  .list-wrap{ margin-top: 14px; display:flex; flex-direction:column; gap:12px; }
  .jobCard{
    border:1px solid #eef2f7;
    border-radius:14px;
    background:#fff;
    padding:16px 18px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:18px;
  }
  .jobLeft{
    flex:1;
    min-width:0;
    display:flex;
    flex-direction:column;
    justify-content:center;
  }
  .jobTitle{
    font-weight:900;
    font-size:1.05rem;
    margin:0;
    color:#111827;
    text-decoration:none;
    display:inline-block;
    line-height:1.35;
  }
  .jobTitle:hover{ text-decoration:underline; }

  .jobMeta{
    margin-top:8px;
    display:flex;
    flex-wrap:wrap;
    align-items:center;
    gap:8px 14px;
    color:#6b7280;
    font-weight:700;
    font-size:.9rem;
    line-height:1.5;
  }
  .jobMeta span{
    display:inline-flex;
    align-items:center;
    gap:6px;
    white-space:nowrap;
  }

  .jobRight{
    display:flex;
    flex-direction:column;
    align-items:flex-end;
    justify-content:center;
    gap:12px;
    min-width:220px;
    flex-shrink:0;
  }

  .jobStatus{
    display:flex;
    justify-content:flex-end;
    width:100%;
    min-height:32px;
    align-items:center;
  }

  .badge{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    padding:6px 10px;
    border-radius:999px;
    font-weight:900;
    font-size:.85rem;
    border:1px solid transparent;
    white-space:nowrap;
    line-height:1;
  }
  .badge-open{ background:#ecfdf5; color:#047857; border-color:#a7f3d0; }
  .badge-closed{ background:#fff7ed; color:#9a3412; border-color:#fed7aa; }
  .badge-draft{ background:#eff6ff; color:#1d4ed8; border-color:#bfdbfe; }

  .btns{
    display:flex;
    gap:8px;
    flex-wrap:wrap;
    justify-content:flex-end;
    align-items:center;
  }

  .delete-form{
    display:inline-flex;
    align-items:center;
    margin:0;
  }

  .delete-form input[type="hidden"]{
    display:none;
  }

  .btn-lite,
  .btn-strong,
  .btn-danger{
    min-width:96px;
    height:42px;
    padding:0 14px;
    font-size:14px;
    font-weight:900;
    border-radius:10px;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    box-sizing:border-box;
    line-height:1;
    white-space:nowrap;
    cursor:pointer;
    margin:0;
    vertical-align:middle;
  }

  .btn-lite{
    background:#fff;
    border:1px solid #cbd5e1;
    color:#334155;
  }
  .btn-lite:hover{
    background:#f7f9fc;
  }

  .btn-strong{
    background:#111827;
    border:1px solid #111827;
    color:#fff;
  }
  .btn-strong:hover{
    filter:brightness(.96);
  }

  .btn-danger{
    background:#dc3545;
    border:1px solid #dc3545;
    color:#fff;
    appearance:none;
  }
  .btn-danger:hover{
    background:#c82333;
  }

  /* 빈 상태 */
  .empty{
    margin-top:20px;
    padding:80px 0;
    text-align:center;
    color:#6b7280;
    border:1px solid #eef2f7;
    border-radius:14px;
    background:#fff;
  }
  .empty .big{
    font-weight:900;
    font-size:1.1rem;
    color:#111827;
    margin-top:10px;
  }
  .empty .sub{ margin-top:6px; }
  .empty .actions{ margin-top:16px; }

  /* 페이지네이션 */
  .pager{
    margin-top:18px;
    display:flex;
    justify-content:center;
    gap:8px;
  }
  .pager a{
    display:inline-block;
    min-width:34px;
    text-align:center;
    padding:8px 10px;
    border:1px solid #e5e7eb;
    border-radius:10px;
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

  @media (max-width: 992px){
    .toolbar{
      flex-direction:column;
      align-items:stretch;
    }

    .toolbar-left,
    .toolbar-right{
      width:100%;
    }

    .search-wrap{
      min-width:100%;
      width:100%;
    }

    .search-wrap input{
      width:100%;
    }

    .jobCard{
      flex-direction:column;
      align-items:flex-start;
    }

    .jobRight{
      width:100%;
      align-items:flex-start;
    }

    .jobStatus{
      justify-content:flex-start;
    }

    .btns{
      justify-content:flex-start;
    }
  }
</style>

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