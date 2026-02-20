<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

    <main class="container mt-4">
        <!-- 헤더 영역 -->
        <div class="pricing-header p-3 pb-md-4 mx-auto text-center">
            <h1 class="display-4 fw-bold">구직자회원 요금제</h1>
            <p class="fs-5 text-muted">
                신속하고 편리하게
                퀄리티 높은 이력서를 작성하고 싶은
                구직자 회원을 위한 이용권
            </p>
        </div>
        
        <div>
        
        </div>

        <!-- 요금제 카드 영역 -->
        <div class="row row-cols-1 row-cols-md-3 mb-5 text-center">
            
            <!-- 10회권 -->
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm h-100">
                    <div class="card-header py-3 bg-light">
                        <h4 class="my-0 fw-semibold">10회권</h4>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mt-3 mb-4 text-center">
                            <li>✔ AI를 활용한 자소서 첨삭 시</li>
                            <li>추가적인 첨삭을 통해 퀄리티 향상</li>
                        </ul>
                        <div class="small text-muted">
                            기본 첨삭 5회 + 10회 추가 제공
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="fs-5 fw-bold text-primary">5,000원</span>
                            <button type="button" class="btn btn-lg btn-primary">구매하기</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 30회권 -->
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm h-100 border-primary">
                    <div class="card-header py-3 bg-primary text-white">
                        <h4 class="my-0 fw-semibold">30회권</h4>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mt-3 mb-4 text-center">
                            <li>✔ AI를 활용한 자소서 첨삭 시</li>
                            <li>추가적인 첨삭을 통해 퀄리티 향상</li>
                        </ul>
                        <div class="small text-muted">
                            기본 첨삭 5회 + 30회 추가 제공
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="fs-5 fw-bold text-primary">8,000원</span>
                            <button type="button" class="btn btn-lg btn-primary">구매하기</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 60회권 -->
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm h-100 border-primary">
                    <div class="card-header py-3 bg-primary text-white">
                        <h4 class="my-0 fw-semibold">60회권</h4>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mt-3 mb-4 text-center">
                            <li>✔ AI를 활용한 자소서 첨삭 시</li>
                            <li>추가적인 첨삭을 통해 퀄리티 향상</li>
                        </ul>
                        <div class="small text-muted">
                            기본 첨삭 5회 + 60회 추가 제공
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="fs-5 fw-bold text-primary">15,000원</span>
                            <button type="button" class="btn btn-lg btn-primary">구매하기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <h2 class="display-6 text-center mb-4">이용권 한 눈에 보기</h2>
        <div class="table-responsive">
          <table class="table text-center">
            <thead>
              <tr>
                <th style="width: 15%"></th>
                <th style="width: 22%">10회권</th>
                <th style="width: 22%">30회권</th>
                <th style="width: 22%">60회권</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row" class="text-center">AI 자소서 첨삭</th>
                <td>✓</td>
                <td>✓</td>
                <td>✓</td>
              </tr>
              <tr>
                <th scope="row" class="text-center">지원자 관리</th>
                <td>✓</td>
                <td>✓</td>
              </tr>
            </tbody>
            <tbody>
              <tr>
                <th scope="row" class="text-center">배너 광고</th>
                <td></td>
                <td>✓</td>
              </tr>
              <tr>
                <th scope="row" class="text-center">이용 기간</th>
                <td>90일</td>
                <td>180일</td>
              </tr>
            </tbody>
          </table>
        </div>
    </main>
</body>
</html>