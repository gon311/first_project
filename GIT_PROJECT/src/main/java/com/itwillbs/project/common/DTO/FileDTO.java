package com.itwillbs.project.common.DTO;

import java.time.LocalDateTime;

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
	private String subDir;
}
