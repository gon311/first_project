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