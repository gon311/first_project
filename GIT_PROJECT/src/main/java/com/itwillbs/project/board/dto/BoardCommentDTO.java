package com.itwillbs.project.board.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardCommentDTO {
    private Long commentId;
    private Long postId;
    private Long authorMemberId;
    private String content;
    private String status;
    private LocalDateTime createdAt;

    // 화면용
    private String writerNickname;
    private String createdAtText;
    private boolean owner;
}
