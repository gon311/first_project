package com.itwillbs.project.my.dto;

import com.itwillbs.project.common.paging.BaseCond;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class QnaCond extends BaseCond {
    private Long userId;
    private String status = "all"; // all, pending, completed
    private String q = "";         // 검색어
}