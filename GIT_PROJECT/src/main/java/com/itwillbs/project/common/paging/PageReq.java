package com.itwillbs.project.common.paging;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PageReq {
    private int page = 1;   // default
    private int size = 5;   // default (요구사항: 5)

    public int getSafePage() {
        return (page <= 0) ? 1 : page;
    }

    // ✅ 5/10/15만 허용 + 디폴트 5
    public int getSafeSize() {
        if (size == 5 || size == 10 || size == 15) return size;
        return 5;
    }

    public int getOffset() {
        return (getSafePage() - 1) * getSafeSize();
    }
}