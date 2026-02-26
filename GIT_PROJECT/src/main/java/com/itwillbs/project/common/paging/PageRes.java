package com.itwillbs.project.common.paging;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PageRes {
    private int page;
    private int size;
    private int total;
    private int totalPages;

    private int startPage;
    private int endPage;

    private boolean hasPrev;
    private boolean hasNext;

    public static PageRes of(PageReq req, int total) {
        int page = req.getSafePage();
        int size = req.getSafeSize();

        int totalPages = (total == 0) ? 1 : (int)Math.ceil(total / (double)size);

        int start = Math.max(1, page - 2);
        int end = Math.min(totalPages, page + 2);

        return new PageRes(
                page, size, total, totalPages,
                start, end,
                page > 1,
                page < totalPages
        );
    }
}