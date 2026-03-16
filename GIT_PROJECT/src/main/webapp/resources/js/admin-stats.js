/**
 * 관리자 통계 페이지 최종 통합 스크립트
 * 피그마 디자인(카드 레이아웃 + 제목) 자동 생성 기능 포함
 */

//* 1. 통계별 설정 데이터 */
var STAT_CONFIG = {
    user: { titles: ["성별 통계", "연령대별 통계", "직무별 통계"], apiUrl: "/project/admin/api/user-stats" },
    com: { titles: ["기업별 공고 등록수", "모집 분야별 비중", "고용 형태 분포"], apiUrl: "/project/admin/api/com-stats" },
    userPay: { titles: ["구직자 상품 판매량", "결제 수단 비중", "최근 매출 추이"], apiUrl: "/project/admin/api/user-pay-stats" },
    comPay: { titles: ["매출 상위 기업(TOP 5)", "기업 프리미엄 비중", "최근 매출 추이"], apiUrl: "/project/admin/api/com-pay-stats" }
};

/* 2. 메인 대시보드(주간 수익) 초기화 함수 */
async function initMainDashboard() {
    var canvasId = 'weekly-revenue-chart';
    if (!document.getElementById(canvasId)) return;

    try {
        var res = await fetch('/project/admin/api/pay-stats');
        var data = await res.json();
        
        // 데이터 포맷 변환 (안전한 함수 형태)
        var formattedData = data.labels.map(function(l, i) {
            return { label: l, value: data.data[i] };
        });
        
        createChart(canvasId, 'line', formattedData, '수익금액');

        var totalSumEl = document.getElementById('total-revenue-sum');
        if (totalSumEl && data.totalSum) {
            totalSumEl.innerText = data.totalSum.toLocaleString() + '원';
        }
    } catch (err) {
        console.error("메인 대시보드 로드 실패:", err);
    }
}

/* 3. 탭 변경 함수 */
async function changeTab(statType) {
    var area = document.getElementById('stat-content-area');
    var config = STAT_CONFIG[statType];
    if (!area || !config) return;

    document.querySelectorAll('#qnaTab .nav-link').forEach(function(tab) {
        tab.classList.remove('active', 'fw-bold');
    });
    
    var activeBtn = document.querySelector("#qnaTab .nav-link[onclick*=\"'" + statType + "'\"]");
    if (activeBtn) activeBtn.classList.add('active', 'fw-bold');

    var html = '<div class="stat-container" style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px;">';
    config.titles.forEach(function(title, i) {
        html += '<div class="my-stat-card" style="background: #fff; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">';
        html += '<h6 class="fw-bold mb-3">' + title + '</h6>';
        html += '<div style="height: 250px;"><canvas id="chart-canvas-' + (i + 1) + '"></canvas></div>';
        html += '</div>';
    });
    html += '</div>';
    area.innerHTML = html;

    try {
        var res = await fetch(config.apiUrl);
        var data = await res.json();
        renderChartsByType(statType, data);
    } catch (err) {
        console.error("탭 데이터 로드 실패:", err);
    }
}

/* 4. 차트 렌더링 분기 */
function renderChartsByType(type, data) {
    if (type === 'user') {
        createChart('chart-canvas-1', 'doughnut', data.gender, '성별');
        createChart('chart-canvas-2', 'doughnut', data.age, '연령대');
        createChart('chart-canvas-3', 'doughnut', data.job, '직무');
    } else if (type === 'com') {
        createChart('chart-canvas-1', 'doughnut', data.postCounts, '공고수');
        createChart('chart-canvas-2', 'doughnut', data.jobFields, '분야');
        createChart('chart-canvas-3', 'doughnut', data.empTypes, '고용형태');
    } else if (type === 'userPay') {
        createChart('chart-canvas-1', 'doughnut', data.products, '상품별');
        createChart('chart-canvas-2', 'doughnut', data.methods, '수단별');
        createChart('chart-canvas-3', 'line', data.revenue, '매출추이');
    } else if (type === 'comPay') {
        createChart('chart-canvas-1', 'bar', data.topCompanies, '상위기업');
        createChart('chart-canvas-2', 'doughnut', data.products, '상품별');
        createChart('chart-canvas-3', 'line', data.revenue, '매출추이');
    }
}

/* 5. 차트 생성 공통 도구 (최대한 안전하게 작성) */
function createChart(canvasId, chartType, chartData, labelName) {
    var ctx = document.getElementById(canvasId);
    if (!ctx || !chartData) return;

    var config = {
        type: chartType,
        data: {
            labels: chartData.map(function(d) { return d.label; }),
            datasets: [{
                label: labelName || '통계',
                data: chartData.map(function(d) { return d.value; }),
                backgroundColor: ['#0d6efd', '#60a5fa', '#93c5fd', '#bfdbfe', '#eff6ff'],
                pointBackgroundColor: '#0d6efd',
                borderWidth: (chartType === 'line' ? 3 : 1),
                fill: (chartType === 'line' ? false : true),
                tension: 0.3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { 
                    display: (chartType !== 'line'), 
                    position: 'bottom' 
                }
            }
        }
    };

    if (chartType === 'line') {
        config.options.scales = {
            y: {
                beginAtZero: true,
                ticks: {
                    callback: function(value) { return value.toLocaleString() + '원'; }
                }
            }
        };
    }

    new Chart(ctx, config);
}