package com.itwillbs.project.admin.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentDTO {
	private long commentId;
	private long postId;
	private long authorMemberId;
	private String content;
	private String status;
	private LocalDateTime createdAt;
	
	private String boardType;
	private String title;
}
