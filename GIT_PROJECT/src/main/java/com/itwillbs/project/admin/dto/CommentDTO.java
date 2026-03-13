package com.itwillbs.project.admin.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
	private String strCreatedAt;
	
	private String boardType;
	private String title;
	
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
		
		if(createdAt != null) { 
			this.strCreatedAt = createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
	}
}
