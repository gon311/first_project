package com.itwillbs.project.comMy.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ComJobRowDTO {

    // ====== 필수 (JSP에서 사용) ======
    private Long jobId;          // JOB_POSTING.job_id
    private String title;        // JOB_POSTING.title
    private String address;      // JOB_POSTING.address
    private String empType;      // JOB_POSTING.emp_type

    private String openDateText;   // 화면용 "yyyy.MM.dd"
    private String closeDateText;  // 화면용 "yyyy.MM.dd"

    private int applyCount;        // 지원자 수(없으면 0으로)

    /**
     *  - ${j.postStatus == 'OPEN'}
     *  - ${j.postStatus == 'CLOSED'}
     * 여기 값은 "OPEN" / "CLOSED"
     */
    private String postStatus;

    // ====== 선택 (나중에 확장 대비) ======
    private String field;        // JOB_POSTING.field (필요하면 카드에 추가 가능)
    private String expType;      // JOB_POSTING.exp_type (new/career)
    private String expYear;      // JOB_POSTING.exp_year
    private String edu;          // JOB_POSTING.edu
    private String salary;       // JOB_POSTING.salary
    private String isRemote;     // JOB_POSTING.is_remote ('Y'/'N')
    private Integer postCheck;   // JOB_POSTING.post_check
    private Integer postStatusCode; // JOB_POSTING.post_status (원본 코드값 보관용)

    // ====== 편의 메서드(선택) ======
    public boolean isOpen() {
        return "OPEN".equals(postStatus);
    }
}
