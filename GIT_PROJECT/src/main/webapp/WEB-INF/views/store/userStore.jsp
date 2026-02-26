<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jspf" %>

    <main class="container mt-5">
        <div class="row">
            <div class="col-lg-10 mx-auto"> 

                <!-- 헤더 영역 -->
                <div class="text-center mb-5 mb-7"> 
                    <p class="mt-4">
                        <span class="display-5 fw-bold text-primary">신속</span>
                        <span class="fs-3 text-dark fw-semibold">하고</span>
                        <span class="display-5 fw-bold text-primary">편리</span>
                        <span class="fs-3 text-dark fw-semibold">하게</span><br>
                        <span class="display-5 fw-bold text-primary">퀄리티 높은 이력서</span>
                        <span class="fs-3 text-dark fw-semibold">를 작성하고 싶은</span><br>
                        <span class="display-5 fw-bold text-primary">구직자</span>
                        <span class="fs-3 text-dark fw-semibold">회원을 위한 이용권</span>
                    </p>
                </div>

                <!-- 요금제 카드 영역 -->
                <div class="row row-cols-1 row-cols-md-3 g-4 mb-5 mb-7"> 
                    
                    <!-- 10회권 -->
                    <div class="col">
                        <div class="card subscription-card h-100 shadow-lg border-0">
                            <div class="card-header bg-light text-center">
                                <h4 class="fw-semibold">10회권</h4>
                            </div>
                            <div class="card-body d-flex flex-column justify-content-between">
                                <ul class="list-unstyled mb-5 text-center">
                                    <li class="fs-6 text-dark fw-semibold">✔ AI를 활용한 자소서 첨삭 시</li>
                                    <li class="fs-6 text-dark fw-semibold">추가적인 첨삭을 통해 퀄리티 향상</li>
                                </ul>
                                <p class="small text-muted text-center mb-0">
                                    기본 첨삭 5회 + 10회 추가 제공
                                </p>
                                <hr class="mt-1 mb-2"> 
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="fs-4 fw-bold text-primary">5,000원</span>
                                    <button type="button" class="btn btn-primary btn-lg" onclick="location.href='pay?productId=P-U10'">구매하기</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 30회권 -->
                    <div class="col">
                        <div class="card subscription-card h-100 shadow-lg border-0">
                            <div class="card-header bg-secondary text-white text-center">
                                <h4 class="fw-semibold">30회권</h4>
                            </div>
                            <div class="card-body d-flex flex-column justify-content-between">
                                <ul class="list-unstyled mb-5 text-center">
                                    <li class="fs-6 text-dark fw-semibold">✔ AI를 활용한 자소서 첨삭 시</li>
                                    <li class="fs-6 text-dark fw-semibold">추가적인 첨삭을 통해 퀄리티 향상</li>
                                </ul>

                                <p class="small text-muted text-center mb-0">
                                    기본 첨삭 5회 + 30회 추가 제공
                                </p>
<<<<<<< HEAD
                                <hr class="mt-1 mb-2">
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="fs-4 fw-bold text-primary">8,000원</span>
                                    <button type="button" class="btn btn-primary btn-lg" onclick="location.href='pay?productId=30'">구매하기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 60회권 -->
                    <div class="col">
                        <div class="card subscription-card h-100 shadow-lg border-0">
                            <div class="card-header bg-light text-center">
                                <h4 class="fw-semibold">60회권</h4>
                            </div>
                            <div class="card-body d-flex flex-column justify-content-between">
                                <ul class="list-unstyled mb-5 text-center">
                                    <li class="fs-6 text-dark fw-semibold">✔ AI를 활용한 자소서 첨삭 시</li>
                                    <li class="fs-6 text-dark fw-semibold">추가적인 첨삭을 통해 퀄리티 향상</li>
                                </ul>
                                <p class="small text-muted text-center mb-0">
                                    기본 첨삭 5회 + 60회 추가 제공
                                </p>
                                <hr class="mt-1 mb-2"> <!-- 구분선 아래 간격 줄임 -->
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="fs-4 fw-bold text-primary">15,000원</span>
                                    <button type="button" class="btn btn-primary btn-lg" onclick="location.href='pay?productId=P-U60'">구매하기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 이용권 상세 안내 -->
=======
                                <hr class="mt-1 mb-2"> <!-- 구분선 아래 간격 줄임 -->
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="fs-4 fw-bold text-primary">8,000원</span>
                                    <button type="button" class="btn btn-primary btn-lg" onclick="location.href='pay?productId=P-U30'">구매하기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 60회권 -->
                    <div class="col">
                        <div class="card subscription-card h-100 shadow-lg border-0">
                            <div class="card-header bg-light text-center">
                                <h4 class="fw-semibold">60회권</h4>
                            </div>
                            <div class="card-body d-flex flex-column justify-content-between">
                                <ul class="list-unstyled mb-5 text-center">
                                    <li class="fs-6 text-dark fw-semibold">✔ AI를 활용한 자소서 첨삭 시</li>
                                    <li class="fs-6 text-dark fw-semibold">추가적인 첨삭을 통해 퀄리티 향상</li>
                                </ul>
                                <p class="small text-muted text-center mb-0">
                                    기본 첨삭 5회 + 60회 추가 제공
                                </p>
                                <hr class="mt-1 mb-2"> <!-- 구분선 아래 간격 줄임 -->
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="fs-4 fw-bold text-primary">15,000원</span>
                                    <button type="button" class="btn btn-primary btn-lg" onclick="location.href='pay?productId=P-U60'">구매하기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 비교 테이블 대신 이용권 상세 안내 -->
>>>>>>> branch 'Team-1' of https://github.com/gon311/first_project.git
				<h2 class="display-7 text-center mt-5 mt-lg-7 mb-4 mb-lg-6">이용권 상세 안내</h2>
				<div class="bg-light p-4 p-lg-5 rounded shadow-sm mb-5 mb-lg-7">
				    <p class="fs-5 text-dark text-center mb-4">
				        본 이용권은 <strong>AI 자소서 첨삭 서비스</strong>를 이용할 때마다 
				        <span class="text-primary fw-bold">1회씩 차감</span>됩니다.
				    </p>
				    <ul class="list-unstyled fs-6 text-dark fw-normal mb-5 text-center">
				        <li class="mb-2">✔ 보유한 이용권 횟수 내에서 자유롭게 첨삭 서비스를 이용할 수 있습니다.</li>
				        <li class="mb-2">✔ 이용권은 기본 제공 횟수와 추가 구매 횟수를 합산하여 사용 가능합니다.</li>
				        <li class="mb-2">✔ 모든 이용권 횟수가 차감되면 더 이상 첨삭 서비스를 이용할 수 없습니다.</li>
				        <li class="mb-2">✔ 추가 이용을 원할 경우 새로운 이용권을 구매해야 합니다.</li>
				    </ul>
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