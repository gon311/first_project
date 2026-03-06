package com.itwillbs.project.comMy.dto;

import com.itwillbs.project.common.paging.BaseCond;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PaymentCond extends BaseCond{
    private Long userId;
    private String period;	// 최근 3개월 3m , 6개월 6m , 1년 1y , 5년 5y 기간
    private String status; // 전체 all 결제완료 pald 미결제 unpaid 무료결제 free 결제상태
    private String q; // 검색


}
