<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="<c:url value="/resources/css/jobManagement.css" />" rel="stylesheet" type="text/css">
<style>
    /* 1. 배경 및 레이아웃 수정 */
    
</style>
</head>
<body>

<div class="manage-container">
    <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 25px;">
        <h2>지원자 관리 <small style="font-size:15px; color:#888; margin-left:10px; font-weight:400;">입사지원자를 검토하고 전형 상태를 업데이트하세요.</small></h2>
        <span style="font-size: 14px; color: #666;">공고명: <strong>[신입/경력] UI/UX 디자이너 채용</strong></span>
    </div>

    <section class="status-tabs">
        <div class="status-tab active"><span class="label">전체</span><span class="count">25</span></div>
        <div class="status-tab"><span class="label">서류대기</span><span class="count">10</span></div>
        <div class="status-tab"><span class="label">서류통과</span><span class="count">5</span></div>
        <div class="status-tab"><span class="label">면접진행</span><span class="count">5</span></div>
        <div class="status-tab"><span class="label">최종합격</span><span class="count">3</span></div>
        <div class="status-tab"><span class="label">불합격</span><span class="count">2</span></div>
    </section>

    <section class="filter-bar">
        <div class="filter-row">
            <input type="text" placeholder="지원자명/키워드 검색" style="width: 280px;">
            <select><option>경력전체</option></select>
            <select><option>학력전체</option></select>
            <button class="btn-secondary"><i class="fa-solid fa-rotate-left"></i> 초기화</button>
        </div>
        <div class="filter-row" style="margin-bottom: 0; border-top: 1px solid #f5f5f5; padding-top: 20px; align-items: center;">
            <span style="font-size: 14px; color: #555; margin-right: 15px;">선택한 인원을</span>
            <button class="btn-action">합격 통보</button>
            <button class="btn-action" style="background: #ff5252;">불합격 통보</button>
            <button class="btn-secondary">면접요청</button>
            <button class="btn-secondary" style="margin-left: auto;"><i class="fa-solid fa-file-pdf"></i> 명단 다운로드</button>
        </div>
    </section>

    <div class="applicant-table-wrap">
        <table class="applicant-table">
            <thead>
                <tr>
                    <th style="width: 50px; text-align: center;"><input type="checkbox"></th>
                    <th style="width: 80px;">번호</th>
                    <th>지원자 정보</th>
                    <th>지원 공고</th>
                    <th>지원일</th>
                    <th style="width: 150px;">전형 상태</th>
                    <th style="width: 80px; text-align: center;">관심</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="text-align: center;"><input type="checkbox"></td>
                    <td style="color: #888;">105</td>
                    <td>
                        <span class="name-tag">홍길동 (28세)</span>
                        <div class="doc-links">
                            <a href="#" class="doc-btn"><i class="fa-solid fa-file-user"></i> 이력서</a>
                            <a href="#" class="doc-btn"><i class="fa-solid fa-folder-open"></i> 포트폴리오</a>
                        </div>
                    </td>
                    <td style="font-size: 14px;">UI/UX 디자이너 채용</td>
                    <td style="font-size: 14px; color: #666;">2024.02.08</td>
                    <td>
                        <select class="status-select">
                            <option selected>서류대기</option>
                            <option>서류통과</option>
                            <option>면접진행</option>
                            <option>최종합격</option>
                            <option>불합격</option>
                        </select>
                    </td>
                    <td style="text-align: center;"><i class="fa-solid fa-star star-icon active"></i></td>
                </tr>
                <tr>
                    <td style="text-align: center;"><input type="checkbox"></td>
                    <td style="color: #888;">104</td>
                    <td>
                        <span class="name-tag">김철수 (32세)</span>
                        <div class="doc-links">
                            <a href="#" class="doc-btn"><i class="fa-solid fa-file-user"></i> 이력서</a>
                        </div>
                    </td>
                    <td style="font-size: 14px;">UI/UX 디자이너 채용</td>
                    <td style="font-size: 14px; color: #666;">2024.02.07</td>
                    <td>
                        <select class="status-select">
                            <option>서류대기</option>
                            <option selected>면접진행</option>
                        </select>
                    </td>
                    <td style="text-align: center;"><i class="fa-solid fa-star star-icon"></i></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <a href="#" class="page-link"><i class="fa-solid fa-angle-left"></i></a>
        <a href="#" class="page-link active">1</a>
        <a href="#" class="page-link">2</a>
        <a href="#" class="page-link">3</a>
        <a href="#" class="page-link"><i class="fa-solid fa-angle-right"></i></a>
    </div>
</div>
<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>