package com.itwillbs.project.my.dto;

import com.itwillbs.project.common.paging.BaseCond;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ApplyCond extends BaseCond {
    private Long userId;

    // 탭: all/done/final
    private String tab = "all";

    // 필터(네 JSP 필터바랑 연결될 애들)
    private String status = "ALL";     // OPEN/CLOSED/ALL (진행중/마감/전체)
    private String sort = "APPLY_DESC"; // APPLY_DESC, DEADLINE_ASC 등
    private String keyword;            // 검색어(회사/제목)

}
