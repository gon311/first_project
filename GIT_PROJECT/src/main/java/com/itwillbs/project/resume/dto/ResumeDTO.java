package com.itwillbs.project.resume.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResumeDTO {
	
//	 resume 3 섹션 + 1 섹션(파일) 
	
	private BasicInfoDTO basicInfoDTO;
	private List<EducationDTO> educationList; 
	private List<CareerDTO> careerList;
	
	// 파일 처리 추가예정.
	
}
