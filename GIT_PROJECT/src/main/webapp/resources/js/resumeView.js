window.onload = function() {
  document.querySelectorAll("input, select, textarea").forEach(el => {
    el.setAttribute("readonly", true);
    el.disabled = true; // select 같은 경우 disabled로 처리
  });
  
  // 사진 업로드 (미리보기)
	document.getElementById("photo").addEventListener("change", function(e){
	
	    const file = e.target.files[0];
	    if(!file) return;
	
	    const reader = new FileReader();
	
	    reader.onload = function(event){
	        document.querySelector(".profile-box").innerHTML =
	            '<img src="'+event.target.result+'" style="width:100%;height:100%;object-fit:cover;">';
	    };
	
	    reader.readAsDataURL(file);
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


