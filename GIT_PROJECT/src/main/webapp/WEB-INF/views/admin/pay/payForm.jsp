<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>

    <%-- 헤더 영역 --%>
    <%@ include file="/WEB-INF/views/inc/header.jspf" %>
    
    <main>
        <div class="container mt-5">
            <h2 class="mb-4 text-center">결제 페이지</h2>

            <form action="<c:url value='/admin/pay' />" method="post" class="needs-validation" novalidate>

                <!-- 주문자 정보 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-3">주문자 정보</h4>
                        <div class="mb-3">
                            <label class="form-label">주문자명</label>
                            <input type="text" class="form-control" name="buyerName" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">전화번호</label>
                            <input type="text" class="form-control" name="buyerPhone" readonly>
                        </div>
                    </div>
                </div>

                <!-- 상품 정보 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-3">상품 정보</h4>
                        <div class="mb-3">
                            <label class="form-label">상품명</label>
                            <input type="text" class="form-control" name="productName" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">상품 가격</label>
                            <input type="text" class="form-control" name="productPrice" readonly>
                        </div>
                    </div>
                </div>

                <!-- 결제 수단 -->
                <div class="card mb-4">
                    <div class="card-header fw-bold">결제 수단</div>
                    <div class="card-body">
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="radio" name="payMethod" value="credit" id="credit" required>
                            <label class="form-check-label" for="credit">신용카드</label>
                        </div>
                        <!-- 신용카드를 선택한 경우 -->
                        <c:if test="">
                        
                        
                        </c:if>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">카드사 선택</label>
                                <select class="form-select" name="cardCompany">
                                    <option>삼성카드</option>
                                    <option>신한카드</option>
                                    <option>국민카드</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">할부 개월 수</label>
                                <select class="form-select" name="installment">
                                    <option>일시불</option>
                                    <option>3개월</option>
                                    <option>6개월</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-check mb-2">
                            <input class="form-check-input" type="radio" name="payMethod" value="bank" id="bank">
                            <label class="form-check-label" for="bank">무통장 입금</label>
                        </div>
                        <!-- 무통장 입금을 선택한 경우 -->
                        <c:if test="">
                        
                        
                        </c:if>
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label">은행 선택</label>
                                <select class="form-select" name="bankName">
                                    <option>국민은행</option>
                                    <option>우리은행</option>
                                    <option>신한은행</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">입금자명</label>
                                <input type="text" class="form-control" name="depositor">
                            </div>
                        </div>
                    </div>
                </div>


                <!-- 결제 금액 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-3">결제 금액</h4>
                        <div class="row mb-2">
                            <div class="col-6">상품 금액</div>
                            <div class="col-6 text-end">0원</div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-6">할인 금액</div>
                            <div class="col-6 text-end">0원</div>
                        </div>
                        <div class="row fw-bold">
                            <div class="col-6">총 결제 금액</div>
                            <div class="col-6 text-end">0원</div>
                        </div>
                    </div>
                </div>

                <!-- 약관 -->
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="check" required>
                    <label class="form-check-label" for="check">(필수) 유료 서비스 이용 약관 동의</label>
                </div>

                <!-- 버튼 -->
                <div class="d-grid mb-4">
                    <button type="submit" class="btn btn-primary">구매하기</button>
                </div>
            </form>
        </div>
    </main>

</body>
</html>