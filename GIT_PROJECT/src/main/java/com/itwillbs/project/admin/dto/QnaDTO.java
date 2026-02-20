package com.itwillbs.project.admin.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnaDTO {
	private int qna_id;
	private String qna_title;
	private String anq_content;
	private int writer_id;
	private Date reg_date;
	private String re_status;
	private Date re_date;
	private String re_content;
	
	
}
