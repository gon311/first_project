// 기본 이벤트 예시

document.addEventListener("DOMContentLoaded", function () {

    // 새 이력서 클릭
    const createCard = document.querySelector(".resumeList-createCard");
    if (createCard) {
        createCard.addEventListener("click", function () {
            location.href = "/resume/create";
        });
    }

    // 대표 설정 버튼
    const mainBtns = document.querySelectorAll(".resumeList-setMainBtn");
    mainBtns.forEach(btn => {
        btn.addEventListener("click", function () {
            if (confirm("대표 이력서로 설정하시겠습니까?")) {
                console.log("대표 설정");
            }
        });
    });

});