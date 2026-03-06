<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이력서</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
<!--     <link rel="stylesheet" href="/resources/css/resumeView.css"> -->
    <link href="<c:url value="/resources/css/resumeView.css" />"
			rel="stylesheet" type="text/css">
</head>
<body class="resume-body">

<div class="container resume-container mt-4 mb-5">

    <!-- 상단 타이틀 -->
    <div class="resume-header mb-3">
        <h4 class="resume-title">IT 프로그래머</h4>
        <hr class="resume-divider">
    </div>

    <div class="row resume-main">

        <!-- 좌측 내용 -->
        <div class="col-lg-9 col-md-8 col-12 resume-left">

            <!-- 기본 정보 -->
            <div class="card resume-card mb-4">
                <div class="card-body resume-profile">

                    <div class="row align-items-center">

                        <!-- 프로필 이미지 -->
                        <div class="col-md-3 col-4 text-center resume-photo-area">
                            <img src="/resources/images/default-profile.png"
                                 class="img-fluid rounded resume-photo"
                                 alt="프로필">
                        </div>

                        <!-- 개인정보 -->
                        <div class="col-md-9 col-8 resume-info">
                            <h5 class="resume-name">박성팔</h5>
                            <p class="resume-text">📧 tearaaa312@gmail.com</p>
                            <p class="resume-text">📞 010-2118-3982</p>
                            <p class="resume-text">📍 부산 동구 고관로 51</p>
                        </div>

                    </div>

                </div>
            </div>

            <!-- 사회형평성 -->
            <div class="card resume-card mb-4">
                <div class="card-header resume-section-title">
                    사회형평적 인재 우대사항
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered resume-table text-center">
                            <thead>
                            <tr>
                                <th>보훈대상</th>
                                <th>장애여부</th>
                                <th>기초생활 수급</th>
                                <th>다문화가정</th>
                                <th>북한이탈주민</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>비대상</td>
                                <td>비대상</td>
                                <td>비대상</td>
                                <td>비대상</td>
                                <td>비대상</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- 병역 -->
            <div class="card resume-card mb-4">
                <div class="card-header resume-section-title">
                    병역사항
                </div>
                <div class="card-body">
                    <p class="resume-text">
                        육군 | 병장 | 만기전역 | 2005.09.20 - 2007.11.21
                    </p>
                </div>
            </div>

            <!-- 학력 -->
            <div class="card resume-card mb-4">
                <div class="card-header resume-section-title">
                    학력사항
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered resume-table text-center">
                            <thead>
                            <tr>
                                <th>학교명</th>
                                <th>전공</th>
                                <th>구분</th>
                                <th>기간</th>
                                <th>학점</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>국립대학교</td>
                                <td>컴퓨터응용기계</td>
                                <td>졸업</td>
                                <td>-</td>
                                <td>3.5 / 4.0</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>

        <!-- 우측 메뉴 -->
        <div class="col-lg-3 col-md-4 col-12 resume-right">
            <div class="card resume-menu p-3">

                <button class="btn btn-outline-secondary resume-btn mb-2">수정</button>
                <button class="btn btn-outline-danger resume-btn mb-2">삭제</button>
                <button class="btn btn-outline-secondary resume-btn mb-2">복사</button>
                <button class="btn btn-outline-secondary resume-btn mb-2">인쇄 / PDF</button>
                <button class="btn btn-outline-secondary resume-btn mb-3">내 이력서</button>

                <button class="btn btn-warning resume-btn-consult">
                    컨설턴트 컨설팅
                </button>

            </div>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<script src="/resources/js/resumeView.js"></script>

</body>
</html>