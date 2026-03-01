package com.itwillbs.project.admin.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnaDTO {

	private int qnaId;
	private String qnaTitle;
	private String qnaContent;
	private int writerId;
	private Date regDate;
	private String reStatus;
	private Date reDate;
	private String reContent;
	
	private String keyword;
	
}
