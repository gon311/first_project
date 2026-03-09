package com.itwillbs.project.common.dto;

import java.time.LocalDateTime;
package com.itwillbs.project.common.dto;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CompanyCardDTO {
	private String title;
	private String companyName;
	private String salary;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private LocalDate closeDate;
	private Long jobId; 
}

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class FileDTO {
	private Integer fileId;
	private Integer categoryIdx;
	private String originName;
	private String storedName;
	private String filePath;
	private Long fileSize;
	private String fileExt;
	private LocalDateTime createdAt;
}
