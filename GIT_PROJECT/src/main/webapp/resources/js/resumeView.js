window.onload = function() {
  document.querySelectorAll("input, select, textarea").forEach(el => {
    el.setAttribute("readonly", true);
    el.disabled = true; // select 같은 경우 disabled로 처리
  });
    
};

// 수정 모드 적용.
function fn_visible(){
	
	document.querySelectorAll("input, select, textarea").forEach(el => {
    el.removeAttribute("readonly");
    el.disabled = false;
  	});
  	
	// btnSave | btnModify - 수정버튼 클릭시 - 저장버튼 보이기, 수정버튼 숨기기
  	const saveBtn = document.getElementById("btnSave");
  	const modiBtn = document.getElementById("btnModify");
  	saveBtn.style.display = "inline-block";
  	modiBtn.style.display = "none";
  	  	
}

// 기본 이벤트 예시
document.addEventListener("DOMContentLoaded", function () {

    const deleteBtn = document.querySelector(".btn-outline-danger");

    if (deleteBtn) {
        deleteBtn.addEventListener("click", function () {
            if (confirm("이력서를 삭제하시겠습니까?")) {
                // 삭제 처리
                console.log("삭제 실행");
            }
        });
    }

});

// 학력, 경력 추가 
let eduIndex = 1;
let expIndex = 1;

$("#addEducation").click(function(){

let html = `
<div class="education-item border p-3 mb-3">

<div class="row mb-3">
<div class="col-md-6">
<label>학력</label>
<select name="educationList[`+eduIndex+`].educationLevel" class="form-control">
<option value="고등학교">고등학교</option>
<option value="대학교(2-3년제)">대학교(2-3년제)</option>
<option value="대학교(4년제)">대학교(4년제)</option>
<option value="대학원(석사)">대학원(석사)</option>
<option value="대학원(박사)">대학원(박사)</option>
</select>
</div>

<div class="col-md-6">
<label>학교명</label>
<input type="text" name="educationList[`+eduIndex+`].schoolName" class="form-control">
</div>
</div>

<button type="button" class="btn btn-danger removeEducation">삭제</button>

</div>
`;

$("#educationContainer").append(html);

eduIndex++;

});


$(document).on("click",".removeEducation",function(){
$(this).closest(".education-item").remove();
});



$("#addExperience").click(function(){

let html = `
<div class="experience-item border p-3 mb-3">

<div class="row mb-3">
<div class="col-md-6">
<label>기업명</label>
<input type="text" name="experienceList[`+expIndex+`].companyName" class="form-control">
</div>

<div class="col-md-6">
<label>근무부서</label>
<input type="text" name="experienceList[`+expIndex+`].depatmentName" class="form-control">
</div>
</div>

<button type="button" class="btn btn-danger removeExperience">삭제</button>

</div>
`;

$("#experienceContainer").append(html);

expIndex++;

});


$(document).on("click",".removeExperience",function(){
$(this).closest(".experience-item").remove();
});
