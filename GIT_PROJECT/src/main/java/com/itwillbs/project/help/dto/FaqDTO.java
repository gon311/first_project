package com.itwillbs.project.help.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class FaqDTO {

	private int faqId;
	private String faqTitle;
	private String faqContent;
	private String category;
	private String userType;
	
	private String keyword;
	}
	
	