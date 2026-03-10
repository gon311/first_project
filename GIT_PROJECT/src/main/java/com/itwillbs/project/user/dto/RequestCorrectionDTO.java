package com.itwillbs.project.user.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RequestCorrectionDTO {
	private String b_no;
	private String type;
	private String value;
}
