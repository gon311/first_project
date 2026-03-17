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
	
	// - 미리보기 및 인쇄
	document.getElementById("printBtn").addEventListener("click", function () {

    // form 내용 가져오기
    var content = document.getElementById("resumeForm").innerHTML;

    // 팝업창 열기
    var printWindow = window.open("", "", "width=900,height=1000");

	    printWindow.document.write(`
	        <html>
	        <head>
	            <title>이력서 인쇄</title>
	            <link rel="stylesheet"
	                  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
	            <style>
	                body { padding: 20px; }
	                input, select, button { border: none; }
	            </style>
	        </head>
	        <body>
	            ${content}
	        </body>
	        </html>
	    `);
	
	    printWindow.document.close();
	
	    // 로딩 후 인쇄 실행
	    printWindow.onload = function () {
	        printWindow.focus();
	        printWindow.print();
	        printWindow.close();
	    };
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


