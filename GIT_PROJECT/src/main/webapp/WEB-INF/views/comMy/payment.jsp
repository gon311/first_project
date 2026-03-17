<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/comMyCss/payment.css'/>" type="text/css">
</head>

<body>
<%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>

<c:url var="urlPaymentList" value="/comMy/payment"/>
<c:url var="urlPayAgain" value="/pay/again"/>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%@ include file="/WEB-INF/views/inc/comMySidebar.jspf" %>

    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">결제내역</h2>
        <div class="page-desc">결제 내역을 조회하고, 주문 상세를 확인할 수 있어요.</div>

        <form action="${urlPaymentList}" method="get" class="toolbar">
          <div class="toolbar-left">
            <select class="select" name="period" onchange="this.form.page.value=1; this.form.submit()">
              <option value="3m" ${period=='3m' ? 'selected' : ''}>최근 3개월</option>
              <option value="6m" ${period=='6m' ? 'selected' : ''}>최근 6개월</option>
              <option value="1y" ${period=='1y' ? 'selected' : ''}>최근 1년</option>
              <option value="5y" ${period=='5y' ? 'selected' : ''}>최근 5년</option>
            </select>

            <select class="select" name="size" onchange="this.form.page.value=1; this.form.submit()">
              <option value="5"  ${pager.size==5 ? 'selected' : ''}>5개씩</option>
              <option value="10" ${pager.size==10 ? 'selected' : ''}>10개씩</option>
              <option value="15" ${pager.size==15 ? 'selected' : ''}>15개씩</option>
            </select>

            <select class="select" name="status" onchange="this.form.page.value=1; this.form.submit()">
              <option value="all" ${status=='all' ? 'selected' : ''}>전체</option>
              <option value="ready" ${status=='ready' ? 'selected' : ''}>준비중</option>
              <option value="paid" ${status=='paid' ? 'selected' : ''}>결제됨</option>
              <option value="cancelled" ${status=='cancelled' ? 'selected' : ''}>취소됨</option>
            </select>

            <input type="hidden" name="page" value="${pager.page}">
          </div>

          <div class="toolbar-right">
            <div class="search-wrap">
              <i class="bi bi-search search-ico"></i>
              <input type="text" name="q" value="${q}" placeholder="주문한 상품명을 검색해 보세요">
            </div>
          </div>
        </form>

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

                <c:forEach var="p" items="${payments}" varStatus="st">

                  <tr class="payment-row">
                    <td>${p.payDateText}</td>

                    <td>
                      <button type="button"
                              class="prod-link detail-toggle"
                              data-target="detail-${st.index}">
                        ${p.productName}
                      </button>
                    </td>

                    <td>${p.payPrice}원</td>

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
                          <span class="badge badge-unpaid">취소됨</span>
                        </c:otherwise>
                      </c:choose>
                    </td>

                    <td>
                      <c:choose>
                        <c:when test="${empty p.payMethod}">-</c:when>
                        <c:otherwise>${p.payMethod}</c:otherwise>
                      </c:choose>
                    </td>

                    <td>
                      <c:choose>
                        <c:when test="${p.payStatus == 'ready'}">
                          <a class="btn-pay" href="${urlPayAgain}?payId=${p.payId}">결제하기</a>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                      </c:choose>
                    </td>
                  </tr>

                  <tr id="detail-${st.index}" class="detail-row" style="display:none;">
                    <td colspan="6">
                      <div class="payment-mini-detail">
                        <div class="mini-grid">
                          <div>
                            <span class="label">상품명</span>
                            <span class="value">${p.productName}</span>
                          </div>
                          <div>
                            <span class="label">결제일</span>
                            <span class="value">${p.payDateText}</span>
                          </div>
                          <div>
                            <span class="label">결제금액</span>
                            <span class="value">${p.payPrice}원</span>
                          </div>
                          <div>
                            <span class="label">결제상태</span>
                            <span class="value">
                              <c:choose>
                                <c:when test="${p.payStatus == 'paid' && p.payPrice == 0}">무료결제</c:when>
                                <c:when test="${p.payStatus == 'paid'}">결제완료</c:when>
                                <c:when test="${p.payStatus == 'ready'}">미결제</c:when>
                                <c:otherwise>취소됨</c:otherwise>
                              </c:choose>
                            </span>
                          </div>
                          <div>
                            <span class="label">결제수단</span>
                            <span class="value">
                              <c:choose>
                                <c:when test="${empty p.payMethod}">-</c:when>
                                <c:otherwise>${p.payMethod}</c:otherwise>
                              </c:choose>
                            </span>
                          </div>
                          <div>
                            <span class="label">주문번호</span>
                            <span class="value">${p.payId}</span>
                          </div>
                        </div>
                      </div>
                    </td>
                  </tr>

                </c:forEach>

              </tbody>
            </table>
          </div>

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

<script>
document.querySelectorAll(".detail-toggle").forEach(function(btn) {
  btn.addEventListener("click", function() {
    const targetId = this.getAttribute("data-target");
    const targetRow = document.getElementById(targetId);

    if (!targetRow) return;

    if (targetRow.style.display === "table-row") {
      targetRow.style.display = "none";
      return;
    }

    document.querySelectorAll(".detail-row").forEach(function(row) {
      row.style.display = "none";
    });

    targetRow.style.display = "table-row";
  });
});
</script>

</body>
</html>