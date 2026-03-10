package com.itwillbs.project.admin.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
public class SubmitPageDTO {
	private List<SubmitDTO> submitList;
	private PageInfoDTO pageInfoDTO; 
} 
