window.onload = function() {
  
  document.querySelectorAll("input, select, textarea").forEach(el => {
    el.setAttribute("readonly", true);
    el.disabled = true; // select 같은 경우 disabled로 처리
  });
  
  // 버튼 display 조정
  document.getElementById("addEducation").style.display = "none";
  document.getElementById("addEducation").style.display = "none";
  document.getElementById("addEducation").style.display = "none";
  document.getElementById("addEducation").style.display = "none";
  
    
};

// 주소 팝업
function findAddr(){

	new kakao.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            //document.getElementById('aaa_post').value = data.zonecode;
            
            if(roadAddr !== ''){
                document.getElementById("address1").value = roadAddr;
            }else if(jibunAddr !== ''){
                document.getElementById("address1").value = jibunAddr;
            }
            
        }
    }).open();
}

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

