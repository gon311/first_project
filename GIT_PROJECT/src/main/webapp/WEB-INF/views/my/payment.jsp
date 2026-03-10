<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================
     URL (전부 c:url)
   ========================= --%>
<c:url var="urlPaymentList" value="/my/payment"/>
<c:url var="urlPaymentDetail" value="/my/payment/detail"/> <%-- ?orderId= --%>
<c:url var="urlPayAgain" value="/pay/again"/>               <%-- ?orderId= (미결제/실패 재결제용) --%>

<style>
  body{ background:#f6f7fb; }
  .mypage-wrap{ min-height:100vh; }

  /* ✅ (공통 톤) 사이드바 스타일 - 이전 페이지와 동일하게 유지 */
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

  /* ✅ 오른쪽 컨텐츠 카드 (공통 톤 유지) */
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

  /* ✅ 사람인 느낌의 상단 필터 + 검색 (하지만 카드톤은 유지) */
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

  .btn-search{
    border:1px solid #dbe2ee;
    background:#fff;
    border-radius:10px;
    padding:10px 14px;
    font-weight:900;
  }
  .btn-search:hover{ background:#f7f9fc; }

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

  /* ✅ 테이블(결제내역) */
  .table-wrap{
    margin-top: 14px;
    border: 1px solid #eef2f7;
    border-radius: 12px;
    overflow:hidden;
    background:#fff;
  }
  table{
    width:100%;
    border-collapse:collapse;
    font-size: .95rem;
  }
  thead th{
    background:#f7f9fc;
    color:#6b7280;
    font-weight:900;
    text-align:left;
    padding: 14px 14px;
    border-bottom: 1px solid #eef2f7;
  }
  tbody td{
    padding: 16px 14px;
    border-bottom: 1px solid #eef2f7;
    vertical-align: middle;
    color:#111827;
    font-weight:700;
  }
  tbody tr:hover{ background:#fbfdff; }

  /* (1) 상품명 클릭 -> 상세로 */
  .prod-link{
    color:#111827;
    text-decoration:none;
    font-weight:900;
  }
  .prod-link:hover{ text-decoration:underline; }

  /* 상태 배지 */
  .badge{
    display:inline-block;
    padding: 6px 10px;
    border-radius:999px;
    font-weight:900;
    font-size:.85rem;
  }
  .badge-paid{ background:#ecfdf5; color:#047857; border:1px solid #a7f3d0; }
  .badge-free{ background:#eff6ff; color:#1d4ed8; border:1px solid #bfdbfe; }
  .badge-unpaid{ background:#fff7ed; color:#9a3412; border:1px solid #fed7aa; }

  /* (2) 미결제일 때 재결제 버튼 */
  .btn-pay{
    background:#fff;
    border:1px solid #cbd5e1;
    color:#334155;
    font-weight:900;
    border-radius:10px;
    padding: 8px 12px;
    text-decoration:none;
    display:inline-block;
  }
  .btn-pay:hover{ background:#f7f9fc; }

  /* 빈 상태(사람인 느낌) */
  .empty{
    margin-top: 20px;
    padding: 80px 0;
    text-align:center;
    color:#6b7280;
  }
  .empty .big{
    font-weight:900;
    font-size:1.1rem;
    color:#111827;
    margin-top: 10px;
  }

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
</style>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 왼쪽 사이드바(inc) --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 오른쪽 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">결제내역</h2>
        <div class="page-desc">결제 내역을 조회하고, 주문 상세를 확인할 수 있어요.</div>

        <%-- =========================
             상단 필터/검색 (사람인 참고)
             - 기간, 결제상태, 검색
           ========================= --%>
        <form action="${urlPaymentList}" method="get" class="toolbar">
          <div class="toolbar-left">
            <select class="select" name="period">
              <option value="3m">최근 3개월</option>
              <option value="6m">최근 6개월</option>
              <option value="1y">최근 1년</option>
              <option value="5y">최근 5년</option>
            </select>

            <select class="select" name="status">
              <option value="ALL">전체</option>
              <option value="PAID">결제완료</option>
              <option value="UNPAID">미결제</option>
              <option value="FREE">무료결제</option>
            </select>

            <button type="submit" class="btn-search">조회</button>
          </div>

          <div class="toolbar-right">
            <div class="search-wrap">
              <i class="bi bi-search search-ico"></i>
              <input type="text" name="q" placeholder="주문한 상품명을 검색해 보세요">
            </div>
          </div>
        </form>

        <%-- =========================
             ✅ 결제내역 테이블(뼈대)
             - (1) 상품명 클릭 -> 상세
             - (2) 미결제일 때 '결제하기' 버튼
             - 나중에 c:forEach로 교체하면 자동으로 행 추가됨
           ========================= --%>

        <%-- ✅ 데이터 없을 때(사람인처럼 빈 화면) --%>
        <%-- 
        <div class="empty">
          <div style="font-size:48px;">🧾</div>
          <div class="big">해당 기간 내에 주문하신 내역이 없습니다</div>
          <div>기간을 변경하여 확인해 보세요</div>
        </div>
        --%>

        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th style="width:140px;">결제일시</th>
                <th>결제상품</th>
                <th style="width:120px;">결제금액</th>
                <th style="width:110px;">결제상태</th>
                <th style="width:160px;">결제수단/증빙</th>
                <th style="width:140px;">비고</th>
              </tr>
            </thead>

            <tbody>
              <%-- ===== 샘플 Row 1 (결제완료) ===== --%>
              <tr>
                <td>26.02.09 03:11</td>

                <td>
                  <%-- (1) 상품명 클릭 -> 상세보기 --%>
                  <a class="prod-link" href="${urlPaymentDetail}?orderId=1001">
                    AI 이력서 100회
                  </a>
                </td>

                <td>20,000원</td>

                <td><span class="badge badge-paid">결제완료</span></td>

                <td>카드결제</td>

                <td>-</td>
              </tr>

              <%-- ===== 샘플 Row 2 (무료결제) ===== --%>
              <tr>
                <td>26.02.01 10:20</td>
                <td>
                  <a class="prod-link" href="${urlPaymentDetail}?orderId=1002">
                    체험 이용권
                  </a>
                </td>
                <td>0원</td>
                <td><span class="badge badge-free">무료결제</span></td>
                <td>-</td>
                <td>-</td>
              </tr>

              <%-- ===== 샘플 Row 3 (미결제 -> 결제하기 버튼) ===== --%>
              <tr>
                <td>26.01.15 19:05</td>
                <td>
                  <a class="prod-link" href="${urlPaymentDetail}?orderId=1003">
                    프리미엄 구독권(1개월)
                  </a>
                </td>
                <td>15,000원</td>
                <td><span class="badge badge-unpaid">미결제</span></td>
                <td>계좌이체</td>
                <td>
                  <%-- (2) 미결제일 때 결제하기 --%>
                  <a class="btn-pay" href="${urlPayAgain}?orderId=1003">결제하기</a>
                </td>
              </tr>

            </tbody>
          </table>
        </div>

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
