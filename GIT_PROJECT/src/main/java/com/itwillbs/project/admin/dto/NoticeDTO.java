package com.itwillbs.project.admin.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class NoticeDTO {
    private int notice_id;
    private String notice_title;
    private String notice_content;
    private Date reg_date;
    private String user_type;
    // Enum을 String으로 선언해도문제없음(DB에서 저장된 ENUM)값을 Mybatis가 자동으로 String 변수에 담아줌
    private int readcount;
    private Date update_time;
    private String status;

    //검색 기능 위한 필드 추가
    private String searchType; //검색 조건

}