function renderCompanyCards(companyList, targetId){
	console.log("renderCompanyCards 실행 -> 대상:", targetId);
    
    //1. targetId를 이용해 실제 HTML 요소찾기 
    const currentTrack = document.getElementById(targetId);
    
    if (!currentTrack) {
        console.error("해당 ID를 가진 요소를 찾을 수 없습니다:", targetId);
        return;
    }
	
	// 2. 해당 영역 초기화
    currentTrack.innerHTML = "";
	
 	// 데이터 없는 경우
    if(!companyList || companyList.length == 0) {
    	console.log("데이터 없음");
    	currentTrack.innerHTML = `
    		<div class="empty-state">
    			 표시할 기업이 없습니다. 
    		</div>
    	`;
    	return; 
    }
 	// 3. 카드 생성 및 삽입 (상위 6개)
    let htmlContent = ""; // 성능을 위해 문자열에 담았다가 한 번에 삽입
    companyList.slice(0,6).forEach(company => {
    	const jobId = company.jobId;
    	const title = company.title;
    	const name = company.companyName;
    	const salary = company.salary;
    	const closeDate = company.closeDate;
    	
    	const card = `
    	    <div class="swiper-slide company-card" data-id="${jobId}">
    	        <h4>${title}</h4>
    	        <p class="companyName">${name}</p>
    	        <p class="salary">${salary}</p>
    	        <p class="closeDate"> ~ ${closeDate}</p>
    	    </div>
    	`;
		
        console.log("생성된 HTML:", card);
        
        currentTrack.innerHTML += card;

    });
	initSwiper();
}