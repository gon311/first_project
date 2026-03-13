package com.itwillbs.project.admin.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeDTO {
	// 자유게시판 DTO
	private long postId;
	private String boardType;
	private long authorMemberId;
	private String title;
	private String content;
	private int readcount;
	private String status;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	private String strCreatedAt;
	private String strUpdatedAt;
	
	private String keyword;
	private LocalDateTime StartDate;
	private LocalDateTime endDate;
	
	public void setBoardType(String boardType) {
		if(boardType.equals("JOB")) {
			this.boardType = "취준/이직";
		} else if(boardType.equals("CAREER")) {
			this.boardType = "회사생활/커리어";
		} else if(boardType.equals("FREE")) {
			this.boardType = "자유주제";
		} 
	}
	
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
		
		if(createdAt != null) { 
			this.strCreatedAt = createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		}
	}
	
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
		
		if(updatedAt != null) { 
			this.strUpdatedAt = updatedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		}
	}
}
