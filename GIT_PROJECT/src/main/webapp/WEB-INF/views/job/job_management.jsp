<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    /* 1. 배경 및 레이아웃 수정 */
    body { 
        background-color: #f8f9fa; 
        color: #333; 
/*         font-family: 'Pretendard', sans-serif;  */
        margin: 0 !important;   /* 부트스트랩 간섭 방지 */
        padding: 0 !important; 
    }

    .manage-container { 
        max-width: 1200px; 
        margin: 0 auto; 
        padding: 40px 20px; 
    }
    
    /* 2. 전형 단계별 현황 (White Card 스타일) */
    .status-tabs { 
        display: flex; 
        background: #fff; 
        border-radius: 12px; 
        margin-bottom: 30px; 
        box-shadow: 0 2px 8px rgba(0,0,0,0.05); 
        border: 1px solid #eee; 
    }

    .status-tab { 
        flex: 1; 
        padding: 25px; 
        text-align: center; 
        border-right: 1px solid #f0f0f0; 
        cursor: pointer; 
        transition: 0.2s; 
    }

    .status-tab:last-child { 
        border-right: none; 
    }

    .status-tab.active { 
        background: #fdfdfd; 
        border-bottom: 4px solid #4485ff; 
    }

    .status-tab .count { 
        display: block; 
        font-size: 26px; 
        font-weight: 800; 
        margin-top: 5px; 
        color: #4485ff; 
    }

    .status-tab .label { 
        font-size: 15px; 
        color: #666; 
        font-weight: 500; 
    }

    /* 3. 검색 및 필터 바 (밝은 톤) */
    .filter-bar { 
        background: #fff; 
        padding: 25px; 
        border-radius: 12px; 
        margin-bottom: 20px; 
        border: 1px solid #eee; 
        box-shadow: 0 2px 8px rgba(0,0,0,0.05); 
    }

    .filter-row { 
        display: flex; 
        gap: 12px; 
        margin-bottom: 15px; 
        flex-wrap: wrap; 
    }

    .filter-bar input, 
    .filter-bar select { 
        background: #fff; 
        border: 1px solid #ddd; 
        color: #333; 
        padding: 10px 15px; 
        border-radius: 6px; 
    }

    .btn-action { 
        background: #4485ff; 
        color: white; 
        border: none; 
        padding: 10px 20px; 
        border-radius: 6px; 
        cursor: pointer; 
        font-weight: 600; 
    }

    .btn-secondary { 
        background: #fff; 
        color: #666; 
        border: 1px solid #ccc; 
        padding: 10px 20px; 
        border-radius: 6px; 
        cursor: pointer; 
    }

    .btn-secondary:hover { 
        background: #f5f5f5; 
    }

    /* 4. 지원자 목록 테이블 (깔끔한 화이트) */
    .applicant-table-wrap { 
        background: #fff; 
        border-radius: 12px; 
        border: 1px solid #eee; 
        box-shadow: 0 2px 8px rgba(0,0,0,0.05); 
        overflow: hidden; 
    }

    .applicant-table { 
        width: 100%; 
        border-collapse: collapse; 
    }

    .applicant-table th { 
        background: #fcfcfc; 
        padding: 18px 15px; 
        text-align: left; 
        font-size: 14px; 
        color: #888; 
        border-bottom: 1px solid #eee; 
    }

    .applicant-table td { 
        padding: 20px 15px; 
        border-bottom: 1px solid #eee; 
        vertical-align: middle; 
        background: #fff; 
    }

    .applicant-table tr:hover td { 
        background: #f9fbff; 
    }
    
    .name-tag { 
        font-weight: 700; 
        font-size: 16px; 
        color: #222; 
        margin-bottom: 6px; 
        display: block; 
    }

    .doc-links { 
        display: flex; 
        gap: 6px; 
    }

    .doc-btn { 
        font-size: 11px; 
        color: #4485ff; 
        text-decoration: none; 
        border: 1px solid #e1e9ff; 
        background: #f0f4ff; 
        padding: 3px 8px; 
        border-radius: 4px; 
        font-weight: 600; 
    }
    
    .status-select { 
        background: #fff; 
        color: #333; 
        border: 1px solid #ddd; 
        padding: 6px 10px; 
        border-radius: 4px; 
        font-size: 13px; 
    }

    .star-icon { 
        color: #ddd; 
        cursor: pointer; 
        font-size: 18px; 
    }

    .star-icon.active { 
        color: #ffc107; 
    }

    /* 5. 페이지네이션 */
    .pagination { 
        display: flex; 
        justify-content: center; 
        gap: 8px; 
        margin-top: 40px; 
    }

    .page-link { 
        color: #888; 
        text-decoration: none; 
        padding: 8px 14px; 
        border: 1px solid #eee; 
        background: #fff; 
        border-radius: 4px; 
    }

    .page-link.active { 
        background: #4485ff; 
        color: #fff; 
        border-color: #4485ff; 
    }
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