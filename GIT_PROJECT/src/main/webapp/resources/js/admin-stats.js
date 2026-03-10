/**
 * 관리자 통계 페이지 최종 통합 스크립트
 * 피그마 디자인(카드 레이아웃 + 제목) 자동 생성 기능 포함
 */

/* 1. 통계별 설정 데이터 (제목, API 경로) */

	var STAT_CONFIG = {
    	user: {
        	titles: ["성별 통계", "연령대별 통계", "직무별 통계"],
        	apiUrl: "/project/admin/api/user-stats"
    	},
   		com: {
    		titles: ["기업별 공고 등록수", "모집 분야별 비중", "고용 형태 분포"],
        	apiUrl: "/project/admin/api/com-stats"
    	},
	    userPay: {
	        titles: ["구직자 상품 판매량", "결제 수단 비중", "최근 매출 추이"],
	        apiUrl: "/project/admin/api/user-pay-stats"
	    },
	    comPay: {
	        titles: ["매출 상위 기업(TOP 5)", "기업 프리미엄 비중", "최근 매출 추이"],
	        apiUrl: "/project/admin/api/com-pay-stats"
	    }
	};

/* 2. 메인 실행 함수 (탭 클릭 시 호출)*/
async function changeTab(statType) {
	const allTabs = document.querySelectorAll('#qnaTab .nav-link');
	allTabs.forEach(tab=> {
		tab.classList.remove('active', 'fw-bold');
	});
	
	const activeBtn = document.querySelector(`#qnaTab .nav-link[onclick*="'${statType}'"]`);
    if (activeBtn) {
        activeBtn.classList.add('active', 'fw-bold');
    }


    const area = document.getElementById('stat-content-area');
    const config = STAT_CONFIG[statType];

    if (!area || !config) return;

    // (1) HTML 카드 레이아웃 자동 생성 (피그마 스타일 제목 포함)
    area.innerHTML = `
        <div class="stat-container">
            ${config.titles.map((title, i) => `
                <div class="my-stat-card">
                    <div class="card-header">
                        <h3 class="card-title">${title}</h3>
                    </div>
                    <div class="chart-box">
                        <canvas id="chart-canvas-${i+1}"></canvas>
                    </div>
                </div>
            `).join('')}
        </div>
    `;

    // (2) 데이터 페칭 및 차트 생성
    try {
        const res = await fetch(config.apiUrl);
        const data = await res.json();
        
        // 데이터 구조에 맞게 매핑 (기존 로직 통합)
        renderChartsByType(statType, data);
    } catch (err) {
        console.error("통계 데이터 로드 실패:", err);
        area.innerHTML = `<p style="padding:20px; color:red;">데이터를 불러오는 중 오류가 발생했습니다.</p>`;
    }
    
    
}

// 3. 타입별 차트 렌더링 분기
function renderChartsByType(type, data) {
	console.log(`${type} 데이터 수신 완료: `, data);
    if (type === 'user') {
        createChart('chart-canvas-1', 'doughnut', data.gender);
        createChart('chart-canvas-2', 'doughnut', data.age);
        createChart('chart-canvas-3', 'doughnut', data.job);
    } else if (type === 'com') {
        createChart('chart-canvas-1', 'doughnut', data.postCounts);
        createChart('chart-canvas-2', 'doughnut', data.jobFields);
        createChart('chart-canvas-3', 'doughnut', data.empTypes);
    } else if (type === 'userPay') {
        createChart('chart-canvas-1', 'doughnut', data.products);
        createChart('chart-canvas-2', 'doughnut', data.methods);
        createChart('chart-canvas-3', 'line', data.revenue);
    } else if (type === 'comPay') {
        createChart('chart-canvas-1', 'bar', data.topCompanies);
        createChart('chart-canvas-2', 'doughnut', data.products);
        createChart('chart-canvas-3', 'line', data.revenue);
    }
}

// 4. 차트 생성 공통 함수
function createChart(canvasId, type, chartData) {
    const ctx = document.getElementById(canvasId);
    if (!ctx || !chartData) return;

    new Chart(ctx, {
        type: type,
        data: {
            labels: chartData.map(d => d.label),
            datasets: [{
                data: chartData.map(d => d.value),
				backgroundColor: [
				    '#6366F1', // Indigo (Main)
				    '#A5B4FC', // Soft Indigo
				    '#C7D2FE', // Light Purple
				    '#E0E7FF', // Very Light Blue
				    '#F1F5F9'  // Grayish White
				],
                borderColor: type === 'line' ? '#6366F1' : '#fff',
                borderWidth: 1,
                fill: type === 'line' ? false : true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: type === 'doughnut' ? '70%' : '0%',
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
}
// ============================================================================
//----[메인 대시보드 main] ------
// 1. 주간 수익 

