package com.itwillbs.project.board.dto;

import com.itwillbs.project.common.paging.BaseCond;
import lombok.Data;

@Data
public class BoardCond extends BaseCond {

    // 카테고리
    private String category = "ALL";

    // 검색어
    private String q;

    // 정렬
    private String sort = "latest"; // latest / view / comment

}