package com.itwillbs.project.comMy.dto;

import com.itwillbs.project.common.paging.BaseCond;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class JobCond extends BaseCond {
    private Long userId;
    private Long jobId;
    
    private String status;      
    private String q;           
    private String careerType;  
    private String appStep;     

    // ✅ MyBatis가 #{offset}을 찾을 때 page 객체의 getOffset()을 호출하도록 연결
    public int getOffset() {
        return this.getPage().getOffset();
    }

    // ✅ MyBatis가 #{size}를 찾을 때 page 객체의 getSafeSize()를 호출하도록 연결
    public int getSize() {
        return this.getPage().getSafeSize();
    }
}
