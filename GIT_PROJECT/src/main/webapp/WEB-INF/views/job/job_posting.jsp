<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채용공고 등록</title>
<style>
    body { font-family: 'Pretendard', sans-serif; background-color: #f8f9fa; padding: 20px; }
    .container { max-width: 900px; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); margin: auto; }
    .form-group { display: flex; align-items: flex-start; margin-bottom: 20px; }
    .label-box { width: 150px; font-weight: bold; padding-top: 10px; }
    .input-box { flex: 1; }
    input[type="text"], textarea, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
    .badge-input { display: flex; gap: 10px; align-items: center; margin-bottom: 10px; }
    .file-upload-area { background: #e9ecef; padding: 20px; border: 2px dashed #ccc; text-align: center; border-radius: 5px; margin: 10px 0; }
    .info-box { background: #f0f7ff; padding: 15px; border-radius: 5px; font-size: 0.9em; color: #0066cc; }
    .btn-submit { background: #333; color: #fff; padding: 15px 30px; border: none; border-radius: 5px; cursor: pointer; display: block; margin: 20px auto; }
</style>
</head>
<body>

<div class="container">
    <form action="post_job_process.jsp" method="post" enctype="multipart/form-data">
        
        <div class="form-group">
            <div class="label-box">공고제목 <span style="color:red">*</span></div>
            <div class="input-box"><input type="text" name="title" placeholder="디자이너 채용"></div>
        </div>

        <div class="form-group">
            <div class="label-box">모집분야명 <span style="color:red">*</span></div>
            <div class="input-box"><input type="text" name="category" placeholder="웹디자이너 채용"></div>
        </div>

        <div class="form-group">
            <div class="label-box">주요업무 <span style="color:red">*</span></div>
            <div class="input-box">
                <textarea name="main_task" rows="5" placeholder="• 사이트 웹디자인"></textarea>
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">파일 첨부</div>
            <div class="input-box">
                <div class="file-upload-area">
                    <p>이미지 첨부파일 기능(첨부하기) 추가</p>
                    <input type="file" name="attach_file" multiple>
                </div>
            </div>
        </div>

        <div class="form-group">
		    <div class="label-box">경력 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <label><input type="checkbox" name="exp_type" value="new"> 신입</label>
		        <label style="margin-right: 15px;"><input type="checkbox" name="exp_type" value="career" checked> 경력</label>
		
		        <select name="min_exp" id="min_exp" style="width: 140px; display:inline-block;">
		            <option value="0">1년 미만</option>
		            <option value="1">1년 이상</option>
		            <option value="3">3년 이상</option>
		            <option value="5">5년 이상</option>
		            <option value="10">10년 이상</option>
		        </select>
		        
		        <span style="margin: 0 5px;">~</span>
		
		        <select name="max_exp" id="max_exp" style="width: 140px; display:inline-block;">
		            <option value="3">3년 이하</option>
		            <option value="5">5년 이하</option>
		            <option value="8">8년 이하</option>
		            <option value="10">10년 이하</option>
		            <option value="99">제한 없음</option>
		        </select>
		
		        <label style="margin-left: 15px;">
		            <input type="checkbox" name="exp_none"> 경력무관
		        </label>
		    </div>
		</div>

        <div class="form-group">
            <div class="label-box">학력 <span style="color:red">*</span></div>
            <div class="input-box">
                <select name="education">
                    <option>학력무관</option>
                </select>
                <input type="checkbox"> 졸업 예정자 가능
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">급여 <span style="color:red">*</span></div>
            <div class="input-box">
                <select name="salary">
                    <option>면접 후 결정</option>
                </select>
                <div class="info-box" style="margin-top:10px;">
                    ⓘ 2025년 기준 최저시급 10,030원<br>
                    당사는 최저 임금법을 준수하며, 최저임금 미만의 공고는 강제 마감될 수 있습니다.
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">근무지 <span style="color:red">*</span></div>
            <div class="input-box">
                <input type="text" name="address" placeholder="서울 강서구 공항대로 165">
                <input type="checkbox"> 재택근무 가능
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">접수기간 <span style="color:red">*</span></div>
            <div class="input-box">
                <input type="date" style="width: 200px; display:inline-block;"> ~ 
                <input type="date" style="width: 200px; display:inline-block;">
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">채용절차</div>
            <div class="input-box">
                서류전형 > 1차면접 > 2차면접 > 최종합격 [ + ]
            </div>
        </div>

        <button type="submit" class="btn-submit">공고 등록하기</button>
    </form>
</div>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const minSelect = document.getElementById('min_exp');
    const maxSelect = document.getElementById('max_exp');

    if(minSelect && maxSelect) { // 요소가 존재하는지 확인
        minSelect.addEventListener('change', function() {
            const minVal = this.value;

            if (minVal === "0" || minVal === "1") {
                maxSelect.value = "3";
            } else if (minVal === "3") {
                maxSelect.value = "5";
            } else if (minVal === "5") {
                maxSelect.value = "8";
            } else if (minVal === "10") {
                maxSelect.value = "99";
            }
        });
    }
});
</script>
</body>
</html>