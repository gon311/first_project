<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>

    <main class="container mt-5">
        <div class="row">
            <div class="col-lg-8 mx-auto"> 

                <!-- 헤더 영역 -->
                <div class="text-center mb-5 mb-7"> 
                    <p class="mt-4">
                        <span class="display-5 fw-bold text-primary">간편</span>
                        <span class="fs-3 text-dark fw-semibold">하고</span>
                        <span class="display-5 fw-bold text-primary">효과</span>
                        <span class="fs-3 text-dark fw-semibold">적으로</span><br>
                        <span class="display-5 fw-bold text-primary">인재</span>
                        <span class="fs-3 text-dark fw-semibold">를 찾고 싶은</span><br>
                        <span class="display-5 fw-bold text-primary">기업</span>
                        <span class="fs-3 text-dark fw-semibold">회원을 위한 이용권</span>
                    </p>
                </div>

                <!-- 요금제 카드 영역 -->
                <div class="row row-cols-1 row-cols-md-2 g-4 mb-5 mb-7"> 
                    
                    <!-- 일반 이용권 -->
                    <div class="col">
                        <div class="card subscription-card h-100 shadow-lg border-0">
                            <div class="card-header bg-light text-center">
                                <h4 class="fw-semibold">일반 이용권</h4>
                            </div>
                            <div class="card-body d-flex flex-column justify-content-between">
                                <ul class="list-unstyled mb-5 text-center">
                                    <li class="fs-5">✔ 채용공고 등록 및 관리</li>
                                    <li class="fs-5">✔ 지원자 관리 시스템</li>
                                </ul>
                                <p class="small text-muted mb-0">
                                    ※ 해당 이용권 구매자는 기업 서비스를 이용할 수 있습니다.
                                </p>
                                <hr class="mt-1 mb-2"> 
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="fs-4 fw-bold text-primary">500,000원</span>
                                    <button type="button" class="btn btn-primary btn-lg" onclick="location.href='pay?productId=P-C1'">구매하기</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 프리미엄 이용권 -->
                    <div class="col">
                        <div class="card subscription-card h-100 shadow-lg border-primary">
                            <div class="card-header bg-primary text-white text-center">
                                <h4 class="fw-semibold">프리미엄 이용권</h4>
                            </div>
                            <div class="card-body d-flex flex-column justify-content-between">
                                <ul class="list-unstyled mb-5 text-center">
                                    <li class="fs-5">✔ 채용공고 등록 및 관리</li>
                                    <li class="fs-5">✔ 지원자 관리 시스템</li>
                                    <li class="fs-5">✔ 배너 광고 게재 서비스</li>
                                </ul>
                                <p class="small text-muted mb-0 text-center">
                                    ※ 이용권 기간 내 홈 화면 배너에 채용공고 게재
                                </p>
                                <hr class="mt-1 mb-2"> 
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="fs-4 fw-bold text-primary">1,000,000원</span>
                                    <button type="button" class="btn btn-primary btn-lg" onclick="location.href='pay?productId=P-C2'">구매하기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 비교 테이블 -->
                <h2 class="display-7 text-center mt-5 mt-lg-7 mb-4 mb-lg-6">이용권 한 눈에 보기</h2>
                <div class="table-responsive mb-5 mb-lg-7">
                  <table class="table table-bordered text-center align-middle">
                    <thead class="table-primary">
                      <tr>
                        <th style="width: 20%"></th>
                        <th style="width: 40%">일반</th>
                        <th style="width: 40%">프리미엄</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <th scope="row">채용공고 등록</th>
                        <td>✓</td>
                        <td>✓</td>
                      </tr>
                      <tr>
                        <th scope="row">지원자 관리</th>
                        <td>✓</td>
                        <td>✓</td>
                      </tr>
                      <tr>
                        <th scope="row">배너 광고</th>
                        <td></td>
                        <td>✓</td>
                      </tr>
                      <tr>
                        <th scope="row">이용 기간</th>
                        <td>90일</td>
                        <td>180일</td>
                      </tr>
                    </tbody>
                  </table>
                  <p class="small text-muted text-center">
			      	※ 본 이용권은 회원 계정에 자동으로 등록되며, 이용권 구매 즉시 사용 가능합니다.<br>
			        ※ 이용권과 관련하여 문의 사항이 있는 경우 고객센터를 통해 문의 바랍니다.
				  </p>
                </div>

            </div>
        </div>
    </main>
    
    <%-- footer area --%>
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>