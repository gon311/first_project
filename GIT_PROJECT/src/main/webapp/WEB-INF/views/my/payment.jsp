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
		    <select class="select" name="period" onchange="this.form.page.value=1; this.form.submit()">
		      <option value="3m" ${period=='3m' ? 'selected' : ''}>최근 3개월</option>
		      <option value="6m" ${period=='6m' ? 'selected' : ''}>최근 6개월</option>
		      <option value="1y" ${period=='1y' ? 'selected' : ''}>최근 1년</option>
		      <option value="5y" ${period=='5y' ? 'selected' : ''}>최근 5년</option>
		    </select>
		
		    <!-- size: 5/10/15 -->
		    <select class="select" name="size" onchange="this.form.page.value=1; this.form.submit()">
		      <option value="5"  ${pager.size==5  ? 'selected' : ''}>5개씩</option>
		      <option value="10" ${pager.size==10 ? 'selected' : ''}>10개씩</option>
		      <option value="15" ${pager.size==15 ? 'selected' : ''}>15개씩</option>
		    </select>
		
		    <!-- ✅ 컨트롤러 param명(status)과 통일 -->
		    <select class="select" name="status" onchange="this.form.page.value=1; this.form.submit()">
		      <option value="all" ${status=='all' ? 'selected' : ''}>전체</option>
		      <option value="ready" ${status=='ready' ? 'selected' : ''}>준비중</option>
		      <option value="paid" ${status=='paid' ? 'selected' : ''}>결제됨</option>
		      <option value="cancelled" ${status=='cancelled' ? 'selected' : ''}>취소됨</option>
		    </select>
		
		    <!-- page hidden (없으면 컨트롤러 default 1로 가긴 하는데, 확실하게 두는 편 추천) -->
		    <input type="hidden" name="page" value="${pager.page}">
		  </div>
		
		  <div class="toolbar-right">
		    <div class="search-wrap">
		      <i class="bi bi-search search-ico"></i>
		      <input type="text" name="q" value="${q}" placeholder="주문한 상품명을 검색해 보세요">
		    </div>
		  </div>
		
		</form>

   
		 <!-- =========================
		       결제내역 테이블(실데이터)
		     - 상품명 클릭 -> 상세
		     - ready면 '결제하기'
		 ========================= -->
		 
		<!--  데이터 없을 때 -->
		<c:if test="${empty payments}">
		  <div class="empty">
		    <div style="font-size:48px;">🧾</div>
		    <div class="big">해당 기간 내에 주문하신 내역이 없습니다</div>
		    <div>기간을 변경하여 확인해 보세요</div>
		  </div>
		</c:if>

		<c:if test="${not empty payments}">
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
		        <c:forEach var="p" items="${payments}">
		          <tr>
		            <!-- 결제일시 -->
		            <td>${p.payDateText}</td>
		
		            <!-- 상품명(상세 링크) -->
		            <td>
		              <a class="prod-link" href="${urlPaymentDetail}?payId=${p.payId}">
		                ${p.productName}
		              </a>
		            </td>
		
		            <!-- 금액 -->
		            <td>${p.payPrice}원</td>
		
		            <!-- 상태 배지 -->
		            <td>
		              <c:choose>
		                <c:when test="${p.payStatus == 'paid' && p.payPrice == 0}">
		                  <span class="badge badge-free">무료결제</span>
		                </c:when>
		                <c:when test="${p.payStatus == 'paid'}">
		                  <span class="badge badge-paid">결제완료</span>
		                </c:when>
		                <c:when test="${p.payStatus == 'ready'}">
		                  <span class="badge badge-unpaid">미결제</span>
		                </c:when>
		                <c:otherwise>
		                  <span class="badge badge-cancelled">취소됨</span>
		                </c:otherwise>
		              </c:choose>
		            </td>
		
		            <!-- 수단/증빙 -->
		            <td>
		              <c:choose>
		                <c:when test="${empty p.payMethod}">-</c:when>
		                <c:otherwise>${p.payMethod}</c:otherwise>
		              </c:choose>
		            </td>
		
		            <!-- 비고 -->
		            <td>
		              <c:choose>
		                <c:when test="${p.payStatus == 'ready'}">
		                  <a class="btn-pay" href="${urlPayAgain}?payId=${p.payId}">결제하기</a>
		                </c:when>
		                <c:otherwise>-</c:otherwise>
		              </c:choose>
		            </td>
		          </tr>
		        </c:forEach>
		      </tbody>
		    </table>
		  </div>

		  <!-- ✅ 페이저 -->
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
