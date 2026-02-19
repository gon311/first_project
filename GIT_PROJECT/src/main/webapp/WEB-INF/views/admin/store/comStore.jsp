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
            <h1 class="display-4 fw-bold">기업회원 요금제</h1>
            <p class="fs-5 text-muted">
                간편하고 효과적으로 인재를 찾고 싶은 기업 회원을 위한 이용권
            </p>
        </div>

        <!-- 요금제 카드 영역 -->
        <div class="row row-cols-1 row-cols-md-2 mb-3 text-center">
            
            <!-- 일반 이용권 -->
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm h-100">
                    <div class="card-header py-3 bg-light">
                        <h4 class="my-0 fw-semibold">일반 이용권</h4>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mt-3 mb-4 text-center">
                            <li>✔ 채용공고 등록 및 관리</li>
                            <li>✔ 지원자 관리 시스템</li>
                        </ul>
                        <div class="small text-muted">
                            ※ 해당 이용권 구매자는 기업 서비스를 이용할 수 있습니다.
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="fs-5 fw-bold text-primary">500,000원</span>
                            <button type="button" class="btn btn-lg btn-primary">구매하기</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 프리미엄 이용권 -->
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm h-100 border-primary">
                    <div class="card-header py-3 bg-primary text-white">
                        <h4 class="my-0 fw-semibold">프리미엄 이용권</h4>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mt-3 mb-4 text-center">
                            <li>✔ 채용공고 등록 및 관리</li>
                            <li>✔ 지원자 관리 시스템</li>
                            <li>✔ 배너 광고 게재 서비스</li>
                        </ul>
                        <div class="small text-muted">
                            ※ 이용권 기간 내 홈 화면 배너에 채용공고 게재
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="fs-5 fw-bold text-primary">1,000,000원</span>
                            <button type="button" class="btn btn-lg btn-primary">구매하기</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        
        <div class="table-responsive">
          <table class="table text-center">
            <thead>
              <tr>
                <th style="width: 34%"></th>
                <th style="width: 22%">Free</th>
                <th style="width: 22%">Pro</th>
                <th style="width: 22%">Enterprise</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row" class="text-start">Public</th>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
              </tr>
              <tr>
                <th scope="row" class="text-start">Private</th>
                <td></td>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
              </tr>
            </tbody>
            <tbody>
              <tr>
                <th scope="row" class="text-start">Permissions</th>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
              </tr>
              <tr>
                <th scope="row" class="text-start">Sharing</th>
                <td></td>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
                <td>
                  <svg
                    class="bi"
                    width="24"
                    height="24"
                    role="img"
                    aria-label="Included"
                  >
                    <use xlink:href="#check"></use>
                  </svg>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
    </main>
</body>
</html>