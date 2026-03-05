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