function renderCompanyCards(companyList){
	console.log("renderCompanyCards 실행");
    track.innerHTML = "";
	
 	// 데이터 없는 경우
    if(!companyList || companyList.length == 0) {
    	console.log("데이터 없음");
    	track.innerHTML = `
    		<div class="empty-state">
    			 표시할 기업이 없습니다. 
    		</div>
    	`;
    	return; 
    }
 	
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
        
        track.innerHTML += card;

    });
	initSwiper();
}