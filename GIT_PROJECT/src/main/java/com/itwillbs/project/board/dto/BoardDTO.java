package com.itwillbs.project.board.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class BoardDTO {
	private Long commentId;
	private Long postId;
	private Long authorMemberId;
	private String content;
	private int readcount;
	private String status;
	private LocalDateTime createdAt;
}
