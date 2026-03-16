package com.itwillbs.project.admin.dto;

import java.util.Date;
import java.util.List;

import com.itwillbs.project.common.dto.FileDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
//@Data
//@NoArgsConstructor
//@AllArgsConstructor
public class QnaDTO {

	private int qnaId;
	private String qnaContent;
	private String qnaCategory;
	private String qnaTitle;
	private int writerId;
	private Date regDate;
	private String reStatus;
	private Date reDate;
	private String reContent;
	
	private String sort;
	
	private List<FileDTO> fileList;
	
}
