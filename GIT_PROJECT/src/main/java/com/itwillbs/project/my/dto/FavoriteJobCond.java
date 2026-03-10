package com.itwillbs.project.my.dto;

import com.itwillbs.project.common.paging.BaseCond;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FavoriteJobCond extends BaseCond {
    private Long userId;
    private String keyword;          // 검색어
    private String status;           // ALL / OPEN / CLOSED
    private boolean excludeApplied;  // 지원한 공고 제외
}