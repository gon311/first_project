package com.itwillbs.project.board.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardDTO {
	private Long postId;
	private String boardType;
	private Long authorMemberId;
	private String title;
	private String content;
	private int readcount;
	private String status;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;

	// 리스트/화면용 필드
	private String categoryName;
	private String writerNickname;
	private int likeCount;
	private int scrapCount;
	private int commentCount;
	private int viewCount;
	private String excerpt;
	
	
	private List<String> tagList;

	// 표시용 날짜
	public String getDisplayDateText() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm");

		if (createdAt == null) {
			return "";
		}

		if (updatedAt != null && !updatedAt.equals(createdAt)) {
			return updatedAt.format(formatter) + " (수정됨)";
		}

		return createdAt.format(formatter);
	}
	
	public String getDisplayDateTextCreate() {
	    if (createdAt == null) return "";
	    
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm");
	    return createdAt.format(formatter);
	}
	
}