<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 이력서</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
<!--     <link rel="stylesheet" href="/resources/css/resumeList.css"> -->
    <link href="<c:url value="/resources/css/resumeList.css" />"
			rel="stylesheet" type="text/css">
    
</head>
<body class="resumeList-body">

<div class="container-fluid resumeList-container">

    <div class="row resumeList-row">

        <!-- =======================
            사이드바
        ======================== -->
        <div class="col-lg-3 col-md-4 col-12 resumeList-sidebar">

            <div class="resumeList-profileCard">

                <div class="resumeList-profileImageArea">
                    <img src="/resources/images/profile_base_1.png"
                    	
                         class="resumeList-profileImage"
                         alt="profile">
                    <button class="resumeList-profileEditBtn">✎</button>
                </div>

                <div class="resumeList-profileName">테츠야</div>

                <hr class="resumeList-divider">

                <ul class="resumeList-menu">
                    <li class="resumeList-menuItem">마이페이지</li>
                    <li class="resumeList-menuItem">내정보</li>
                    <li class="resumeList-menuItem">내 자기소개서</li>
                    <li class="resumeList-menuItem active">내 이력서</li>
                </ul>

            </div>
        </div>


        <!-- =======================
            콘텐츠 영역
        ======================== -->
        <div class="col-lg-9 col-md-8 col-12 resumeList-content">

            <h4 class="resumeList-title mb-4">내 이력서</h4>

            <div class="row resumeList-cardGrid">

                <!-- 새 이력서 카드 -->
                <div class="col-xl-6 col-lg-6 col-md-12 mb-4">
                    <div class="resumeList-card resumeList-createCard">
                        <div class="resumeList-createInner">
                            <div class="resumeList-createIcon">＋</div>
                            <div class="resumeList-createText">새 이력서 작성</div>
                        </div>
                    </div>
                </div>


                <!-- 대표 이력서 카드 -->
                <div class="col-xl-6 col-lg-6 col-md-12 mb-4">

					<div class="resumeList-card resumeList-itemCard" onclick="location.href='view?idx=${resume.idx}'">
                        <!-- 대표 리본 -->
                        <div class="resumeList-badge">1st</div>

                        <div class="resumeList-cardHeader">
                            <div class="resumeList-cardTitle">IT 프로그래머</div>
                            <div class="resumeList-cardDate">2026.02.09</div>
                        </div>

                        <div class="resumeList-cardBody">
                            <p class="resumeList-cardText">직종: IT·전자·통신</p>
                            <p class="resumeList-cardText">업종: IT·전자</p>
                            <p class="resumeList-cardText">기업: 스타트업</p>
                        </div>

                        <div class="resumeList-cardFooter">
                            <span class="resumeList-mainLabel">대표</span>
                            <button class="resumeList-moreBtn">⋮</button>
                        </div>
                    </div>
                    
                </div>


                <!-- 일반 카드 예시 -->
                <div class="col-xl-6 col-lg-6 col-md-12 mb-4">
                
                    <div class="resumeList-card resumeList-itemCard"  onclick="location.href='view?idx=${resume.idx}'">
                        <div class="resumeList-cardHeader">
                            <div class="resumeList-cardTitle">상세테스트 1</div>
                            <div class="resumeList-cardDate">2026.02.23</div>
                        </div>

                        <div class="resumeList-cardBody">
                            <p class="resumeList-cardText">직종: 영업·고객상담</p>
                            <p class="resumeList-cardText">업종: 서비스업</p>
                            <p class="resumeList-cardText">기업: 중소기업</p>
                        </div>

                        <div class="resumeList-cardFooter">
                            <button class="resumeList-setMainBtn">대표 설정</button>
                            <button class="resumeList-moreBtn">⋮</button>
                        </div>

                    </div>
                </div>


            </div>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<script src="/resources/js/resumeList.js"></script>

</body>
</html>