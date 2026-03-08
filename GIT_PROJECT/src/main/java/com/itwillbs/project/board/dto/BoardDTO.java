package com.itwillbs.project.board.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class BoardDTO {
	private Long postId;
	private String boardType;   //NOTICE/FREE/QNA
	private Long authorMemberId;  // USER.user_id
	private String title;
	private String content;
	private int readcount;
	private String status;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
}
