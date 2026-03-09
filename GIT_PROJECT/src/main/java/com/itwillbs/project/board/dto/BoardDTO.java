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
	
	// ===== 리스트 화면용 =====
	private String categoryName;
	private String writerNickname;
	private int likeCount;
	private int commentCount;
	private int viewCount;
	private String excerpt;
	private String createdAtText;
	
}
