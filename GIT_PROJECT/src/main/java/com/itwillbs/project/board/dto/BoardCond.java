package com.itwillbs.project.board.dto;

import com.itwillbs.project.common.paging.BaseCond;
import lombok.Data;

@Data
public class BoardCond extends BaseCond {

    private String category = "ALL";
    private String sort = "latest";
    private String q;
    private String searchType = "all";

}