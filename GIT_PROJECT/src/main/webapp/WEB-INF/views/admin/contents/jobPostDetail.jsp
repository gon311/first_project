<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	<link href="<c:url value ="/resources/css/admin.css" />" rel="stylesheet" type="text/css">
	
<title>채용 공고 상세 페이지</title>
</head>
<body class = "bg-light">
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
<main class="container my-5">
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-2">
                                <li class="breadcrumb-item text-primary fw-bold">${jobPostDTO.companyName}</li>
                                <li class="breadcrumb-item active">채용공고</li>
                            </ol>
                        </nav>
                        <h2 class="fw-bold mb-2">${jobPostDTO.title}</h2>
                        <p class="text-muted small mb-0">
                            공고 ID: <span class="text-dark">${jobPostDTO.jobId}</span> | 
                            기업 ID: <span class="text-dark">${jobPostDTO.compId}</span>
                        </p>
                    </div>
                    <c:choose>
                        <c:when test="${jobPostDTO.postStatus == 1}">
                            <span class="badge bg-success px-3 py-2">모집중</span>
                        </c:when>
                        <c:when test="${jobPostDTO.postStatus == 2}">
                            <span class="badge bg-danger px-3 py-2">마감</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-warning text-dark px-3 py-2">보류</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <hr class="my-4">

                <div class="row g-3 p-3 bg-light rounded border mx-0">
                    <div class="col-md-6">
                        <div class="d-flex mb-2">
                            <span class="text-secondary fw-bold" style="width: 100px;">경력</span>
                            <span class="text-dark">${jobPostDTO.expYear}</span>
                        </div>
                        <div class="d-flex mb-2">
                            <span class="text-secondary fw-bold" style="width: 100px;">학력</span>
                            <span class="text-dark">${jobPostDTO.edu}</span>
                        </div>
                        <div class="d-flex">
                            <span class="text-secondary fw-bold" style="width: 100px;">근무형태</span>
                            <span class="text-dark">${jobPostDTO.empType} 
                                <c:if test="${post.probation == 'Y'}">
                                    <span class="badge rounded-pill bg-warning text-dark ms-2">수습 있음</span>
                                </c:if>
                            </span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex mb-2">
                            <span class="text-secondary fw-bold" style="width: 100px;">급여</span>
                            <span class="text-dark">${jobPostDTO.salary}</span>
                        </div>
                        <div class="d-flex">
                            <span class="text-secondary fw-bold" style="width: 100px;">근무지역</span>
                            <span class="text-dark">
                                ${jobPostDTO.address}
                                <a href="#map" class="btn btn-sm btn-outline-primary ms-2 py-0">지도보기</a>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="mt-5">
                    <h4 class="fw-bold mb-3"><i class="fa-solid fa-briefcase me-2"></i>모집 직무 및 상세 내용</h4>
                    <div class="alert alert-secondary py-2 px-3 d-inline-block mb-3">
                        분야: <strong>${jobPostDTO.field}</strong>
                    </div>
                    <div class="job-content-box p-2">
                        ${jobPostDTO.task}
                    </div>
                </div>

                <div class="mt-5 p-4 bg-white border rounded">
                    <h5 class="fw-bold mb-4"><i class="fa-solid fa-image me-2 text-primary"></i>직무 관련 이미지 및 첨부파일</h5>
                    <div class="row g-3">
                        <c:choose>
                            <c:when test="${not empty detailFile}">
                                <c:forEach var="file" items="${detailFile}">
                                    <div class="col-12">
                                        <c:choose>
                                            <c:when test="${file.fileExt.contains('image') || file.fileExt.contains('jpg') || file.fileExt.contains('png')}">
                                                <img src="/upload/board/${file.filePath}/${file.storedName}" 
                                                     class="img-fluid rounded border shadow-sm mb-3" 
                                                     alt="${file.originName}" style="max-height: 600px;">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="list-group">
                                                    <a href="/upload/board/${file.filePath}/${file.storedName}" 
                                                       download="${file.originName}" 
                                                       class="list-group-item list-group-item-action">
                                                        <i class="fa-regular fa-file-pdf me-2 text-danger"></i> ${file.originName} (다운로드)
                                                    </a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted small">등록된 상세 이미지가 없습니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">위치 정보</h5>
                        <div id="map"></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">기업 정보 요약</h5>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item px-0">
                                <small class="text-muted d-block">접수 기간</small>
                                <strong>
                                	 <fmt:formatDate value="${jobPostDTO.openDate}" pattern="yyyy-MM-dd" />
									~ <fmt:formatDate value="${jobPostDTO.closeDate}" pattern="yyyy-MM-dd" />
                                </strong>
                               
                            </li>
                            <li class="list-group-item px-0 text-truncate">
                                <small class="text-muted d-block">기업 주소</small>
                                <strong>${jobPostDTO.address}</strong>
                            </li>
                            <c:if test="${jobPostDTO.isPublic eq 'Y'}">
                                <li class="list-group-item px-0">
                                    <small class="text-muted d-block">담당자 정보</small>
                                    <strong>${jobPostDTO.mgrName}</strong> / ${jobPostDTO.mgrPhone}
                                    <br><span class="small">${jobPostDTO.mgrEmail}</span>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-center gap-2 mt-5">
            <a href="<c:url value='/admin/contents/JobPost' />" class="btn btn-outline-secondary px-4">
                <i class="fa-solid fa-list me-1"></i> 목록으로
            </a>
            <button type="button" class="btn btn-danger px-4" onclick="confirmDelete(${jobPostDTO.jobId})">
                <i class="fa-solid fa-trash-can me-1"></i> 삭제하기
            </button>
        </div>
    </main>

    <script type="text/javascript">
        // 삭제 확인 함수
        function confirmDelete(jobId) {
            if (confirm("정말로 이 채용공고를 삭제하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.")) {
                location.href = "JobPostDelete?jobId=" + jobId;
            }
        }

        // 지도 초기화
        const map = new maplibregl.Map({
            container: 'map',
            style: 'https://tiles.openfreemap.org/styles/liberty',
            center: [126.9780, 37.5665], 
            zoom: 15
        });

        // 주소 기반 마커 표시 로직 (기존 유지)
        let currentAddress = "${jobPostDTO.address}"; 
        if (currentAddress && currentAddress.trim() !== "") {
            const searchAddress = currentAddress.split(' ').slice(0, 4).join(' ');
            const apiUrl = "https://nominatim.openstreetmap.org/search?format=json&q=" + encodeURIComponent(searchAddress);

            fetch(apiUrl)
                .then(res => res.json())
                .then(data => {
                    if (data && data.length > 0) {
                        const lon = parseFloat(data[0].lon);
                        const lat = parseFloat(data[0].lat);
                        map.setCenter([lon, lat]);
                        new maplibregl.Marker({ color: '#ff4b4b' })
                            .setLngLat([lon, lat])
                            .setPopup(new maplibregl.Popup().setHTML("<div class='p-2'><b>" + currentAddress + "</b></div>"))
                            .addTo(map);
                    }
                })
                .catch(err => console.error('주소 변환 오류:', err));
        }
        map.addControl(new maplibregl.NavigationControl());

        // 부드러운 스크롤 함수
        function scrollToMap(event) {
            event.preventDefault();
            document.querySelector('#map').scrollIntoView({ behavior: 'smooth' });
        }
    </script>
</body>
</html>