package com.itwillbs.project.admin.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeDTO {
	private long postId;
	private String boardType;
	private long authorMemberId;
	private String title;
	private String content;
	private String status;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
}
