package com.itwillbs.project.common.dto;

import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.MediaType;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class FileResourceDTO {
	private Resource resource;
	private ContentDisposition contentDisposition;
	private MediaType contentType;
	
	
	public FileResourceDTO(Resource resource, ContentDisposition contentDisposition, String contentType) {
		super();
		this.resource = resource;
		this.contentDisposition = contentDisposition;
		this.contentType = MediaType.valueOf(contentType);
	}
	
	// contentType(MINE) 문자열을 전달받아 MediaType 객체로 변환 
	public void setContentType(String contentType) { 
		this.contentType = MediaType.valueOf(contentType);
	}

} 
