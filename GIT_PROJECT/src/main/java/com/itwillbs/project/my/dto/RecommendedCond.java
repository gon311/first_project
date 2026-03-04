package com.itwillbs.project.my.dto;

import com.itwillbs.project.common.paging.BaseCond;

import lombok.Data;

@Data
public class RecommendedCond extends BaseCond{
    private long userId;
    private String sort = "PREF";
    private boolean onlyApplyable = false;

}
