package com.itwillbs.project.admin.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchDTO {
	private String user_name;
	private String user_type;
	private String status;
}
