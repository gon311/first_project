<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================
     URL (전부 c:url)
     - 컨트롤러 매핑에 맞춰 value만 바꾸면 됨
   ========================= --%>
<c:url var="urlApplyList" value="/my/apply"/>               <%-- GET 목록 --%>
<c:url var="urlJobDetail" value="/job/detail"/>            <%-- ?jobId= --%>
<c:url var="urlCancelApply" value="/my/apply/cancel"/>     <%-- POST(추천) --%>

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

  /* =========================
     탭/요약 영역 (전체/지원완료/최종발표)
     ========================= */
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

  /* =========================
     필터 바 (기간/상태/정렬/검색) : 화면정의서 기반 뼈대
     ========================= */
  .filterbar{
    margin-top: 16px;
    display:flex;
    justify-content:flex-end;
    gap: 10px;
    padding: 12px;
    border:1px solid #eef2f7;
    border-radius: 12px;
    background:#fff;
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
    min-width: 260px;
  }
  .search-wrap input{ border:0; outline:none; width:220px; }
  .search-ico{ color:#94a3b8; font-size:1.1rem; }

  /* =========================
     지원내역 리스트(행)
     ========================= */
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

  /* (1) 제목 클릭 → 채용상세 이동 */
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
    min-width: 240px;
    display:flex;
    justify-content:flex-end;
    align-items:center;
    gap: 10px;
    padding-top: 2px;
  }
  .status{
    font-weight:900;
    color:#111827;
    margin-right: 8px;
    white-space:nowrap;
  }

  /* (2) 지원취소 버튼 */
  .btn-cancel{
    background:#fff;
    border:1px solid #cbd5e1;
    color:#334155;
    font-weight:900;
    border-radius: 10px;
    padding: 10px 16px;
  }
  .btn-cancel:hover{ background:#f7f9fc; }

  /* 페이지네이션(뼈대) */
  .pager{
    margin-top: 18px;
    display:flex;
    justify-content:center;
    gap: 8px;
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

  /* ✅ 빈 상태(사람인처럼 중앙 안내) */
  .empty{
    margin-top: 34px;
    padding: 60px 0;
    text-align:center;
    color:#6b7280;
  }
  .empty .big{ font-weight:900; font-size:1.1rem; color:#111827; margin-top:10px; }
</style>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 왼쪽 사이드바(inc) --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 오른쪽 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">지원 내역</h2>
        <div class="page-desc">지원한 공고를 확인하고, 필요 시 지원 취소를 할 수 있어요.</div>

        <%-- =========================
             탭(전체/지원완료/최종발표)
             - active는 컨트롤러에서 currentTab 내려서 처리하면 편함
           ========================= --%>
        <div class="tabs">
          <a class="tab ${currentTab=='all' ? 'active' : ''}" href="${urlApplyList}?tab=all">
            전체 <span class="tab-badge">${cntAll}</span>
          </a>
          <a class="tab ${currentTab=='done' ? 'active' : ''}" href="${urlApplyList}?tab=done">
            지원완료 <span class="tab-badge">${cntDone}</span>
          </a>
          <a class="tab ${currentTab=='final' ? 'active' : ''}" href="${urlApplyList}?tab=final">
            최종발표 <span class="tab-badge">${cntFinal}</span>
          </a>
        </div>

        <%-- 요약 박스(화면정의서처럼 숫자 보여주기) --%>
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

        <%-- 필터(기간/상태/정렬/검색) 뼈대 --%>
        <div class="filterbar">
          <select class="select">
            <option>전체</option>
            <option>진행중</option>
            <option>마감</option>
          </select>

          <select class="select">
            <option>5개씩</option>
            <option>10개씩</option>
            <option>20개씩</option>
          </select>

          <select class="select">
            <option>업데이트순</option>
            <option>마감순</option>
            <option>지원자수순</option>
            <option>회사순</option>
          </select>

          <div class="search-wrap">
            <i class="bi bi-search search-ico"></i>
            <input type="text" placeholder="키워드 입력">
          </div>
        </div>

        <%-- =========================
             리스트
             - 지금은 샘플 3줄
             - 나중에 c:forEach로 바꾸면 자동 추가됨
             - 화면정의서 포인트:
               (1) 제목 클릭 → 채용 페이지 이동
               (2) 지원취소 버튼 → confirm
               (3) confirm 후 취소 처리 → alert (임시로 JS alert)
           ========================= --%>
        <div class="list">

          <%-- ===== 샘플 Row 1 ===== --%>
          <div class="row-item">
            <div class="row-date">2026-02-08</div>

            <div class="row-mid">
              <a class="title-link" href="${urlJobDetail}?jobId=101">
                [코스닥 상장사] 2026년 에이티E 부문별 채용
              </a>
              <div class="subline">신입 · 경력 · 학력무관 · 서울 송파구 · 계약직</div>
            </div>

            <div class="row-right">
              <div class="status">지원완료</div>

              <%-- (2) 지원취소: confirm -> POST 전송 --%>
              <form action="${urlCancelApply}" method="post" style="margin:0;"
                    onsubmit="return confirmCancel();">
                <input type="hidden" name="applyId" value="5001"/>
                <button type="submit" class="btn-cancel">지원취소</button>
              </form>
            </div>
          </div>

          <%-- ===== 샘플 Row 2 ===== --%>
          <div class="row-item">
            <div class="row-date">2026-02-08</div>

            <div class="row-mid">
              <a class="title-link" href="${urlJobDetail}?jobId=102">
                [코스닥 상장사] 2026년 에이티E 부문별 채용
              </a>
              <div class="subline">신입 · 경력 · 학력무관 · 서울 송파구 · 계약직</div>
            </div>

            <div class="row-right">
              <div class="status">지원완료</div>
              <form action="${urlCancelApply}" method="post" style="margin:0;"
                    onsubmit="return confirmCancel();">
                <input type="hidden" name="applyId" value="5002"/>
                <button type="submit" class="btn-cancel">지원취소</button>
              </form>
            </div>
          </div>

          <%-- ===== 샘플 Row 3 ===== --%>
          <div class="row-item">
            <div class="row-date">2026-02-08</div>

            <div class="row-mid">
              <a class="title-link" href="${urlJobDetail}?jobId=103">
                [코스닥 상장사] 2026년 에이티E 부문별 채용
              </a>
              <div class="subline">신입 · 경력 · 학력무관 · 서울 송파구 · 계약직</div>
            </div>

            <div class="row-right">
              <div class="status">지원완료</div>
              <form action="${urlCancelApply}" method="post" style="margin:0;"
                    onsubmit="return confirmCancel();">
                <input type="hidden" name="applyId" value="5003"/>
                <button type="submit" class="btn-cancel">지원취소</button>
              </form>
            </div>
          </div>

        </div>

        <%-- 빈 상태(데이터 없을 때 쓰려고 준비해둔 영역)
            - 나중에 cntAll==0 이면 이걸 보여주고 list 숨기면 됨 --%>
        <%-- 
        <div class="empty">
          <div style="font-size:48px;">🧑‍💻</div>
          <div class="big">입사지원 내역이 없어요</div>
          <div>이재우님에게 맞는 공고를 소개해줄게요!</div>
        </div>
        --%>

        <div class="pager">
          <a href="#" class="active">1</a>
          <a href="#">2</a>
          <a href="#">3</a>
          <a href="#">다음</a>
        </div>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
  // ✅ 화면정의서: "지원취소 confirm" -> 확인이면 서버로 POST, 아니면 취소
  function confirmCancel(){
    return confirm("지원을 취소할까요?");
  }

  // ✅ 서버에서 취소 성공 후 redirect하면서 flash 메시지로 내려주면
  //    아래처럼 alert 띄우는 방식으로 화면정의서(alert) 맞출 수 있음.
  //    예) model.addAttribute("msg","지원이 정상적으로 취소 되었습니다.");
  <c:if test="${not empty msg}">
    alert("${msg}");
  </c:if>
</script>
