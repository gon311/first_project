<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fcfcfc; /* 아주 연한 회색으로 고급스러운 느낌 */
        }
        .payment-card {
            max-width: 500px;
            margin: 100px auto;
            border: none;
            border-radius: 24px;
        }
        .success-container {
            padding: 40px 30px;
        }
        /* 성공 아이콘 애니메이션 및 스타일 */
        .success-icon-wrapper {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 100px;
            height: 100px;
            background-color: #f6ffed; /* 연한 초록색 배경 */
            border-radius: 50%;
            margin-bottom: 25px;
            animation: bounceIn 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }
        .success-icon {
            font-size: 50px;
            color: #52c41a; /* 포트원/토스 스타일의 세련된 초록색 */
        }
        .summary-box {
            background-color: #f8f9fa;
            border-radius: 16px;
            padding: 24px;
            margin: 30px 0;
            border: 1px dashed #d9d9d9; /* 영수증 느낌의 점선 보더 */
        }
        .label-text {
            font-size: 0.9rem;
            color: #8c8c8c;
        }
        .value-text {
            font-weight: 600;
            color: #262626;
        }
        .total-amount {
            font-size: 1.25rem;
            color: #1677ff; /* 포인트 컬러 파란색 */
            font-weight: 700;
        }
        /* 버튼 커스텀 */
        .btn-main {
            background-color: #262626;
            border: none;
            padding: 14px;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-main:hover {
            background-color: #434343;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .btn-sub {
            border: 1px solid #d9d9d9;
            padding: 14px;
            border-radius: 12px;
            color: #595959;
            font-weight: 500;
            background-color: #fff;
        }
        .btn-sub:hover {
            background-color: #f5f5f5;
        }

        /* 통통 튀는 등장 애니메이션 */
        @keyframes bounceIn {
            from { opacity: 0; transform: scale(0.5); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>

    <%@ include file="/WEB-INF/views/inc/header.jspf" %>
    
    <main>
        <div class="container">
            <div class="card shadow-sm payment-card">
                <div class="card-body text-center success-container">
                    
                    <div class="success-icon-wrapper">
                        <i class="bi bi-check-lg success-icon"></i>
                    </div>
            
                    <h3 class="fw-bold mb-2">결제가 성공적으로 완료되었습니다</h3>
                    <p class="text-secondary small">
                        결제 내역은 마이페이지에서 확인하실 수 있습니다.
                    </p>
            
<!--                     <div class="summary-box text-start"> -->
<!--                         <div class="d-flex justify-content-between mb-3 border-bottom pb-2"> -->
<!--                             <span class="label-text">주문번호</span> -->
<%--                             <span class="value-text">${payment.orderId}</span> --%>
<!--                         </div> -->
<!--                         <div class="d-flex justify-content-between mb-3"> -->
<!--                             <span class="label-text">결제수단</span> -->
<%--                             <span class="value-text">${payment.method != null ? payment.method : '카드 결제'}</span> --%>
<!--                         </div> -->
<!--                         <div class="d-flex justify-content-between mt-4"> -->
<!--                             <span class="label-text align-self-center">최종 결제금액</span> -->
<!--                             <span class="total-amount"> -->
<%--                                 <fmt:formatNumber value="${payment.amount}" pattern="#,###"/>원 --%>
<!--                             </span> -->
<!--                         </div> -->
<!--                     </div> -->
            
                    <div class="d-grid gap-3">
                        <a href="${pageContext.request.contextPath}/myPayments" class="btn btn-dark btn-main text-white text-decoration-none">
                            <i class="bi bi-receipt me-2"></i> 결제 내역 확인하기
                        </a>
            
                        <a href="${pageContext.request.contextPath}/" class="btn btn-sub text-decoration-none">
                            메인페이지로 이동
                        </a>
                    </div>
            
<!--                     <div class="mt-5 border-top pt-4"> -->
<!--                         <p class="small text-muted mb-0"> -->
<!--                             배송 관련 알림은 등록하신 이메일/연락처로 발송됩니다. -->
<!--                         </p> -->
<!--                     </div> -->
                </div>
            </div>
        </div>                              
    </main>

    <%@ include file="/WEB-INF/views/inc/footer.jspf" %>

</body>
</html>