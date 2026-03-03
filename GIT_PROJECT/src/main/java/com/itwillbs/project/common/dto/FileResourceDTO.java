package com.itwillbs.project.common.dto;

import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.MediaType;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
//@AllArgsConstructor
public class FileResourceDTO {
	private Resource resource;
	private ContentDisposition contentDisposition;
	private MediaType contentType;
	
	public FileResourceDTO(Resource resource, ContentDisposition contentDisposition, String contentType) {
		this.resource = resource;
		this.contentDisposition = contentDisposition;
		// 컨텐츠 타입(MIME) 문자열을 전달받아 MediaType 객체로 변환
		this.contentType = MediaType.valueOf(contentType);
	}
	
	// 컨텐츠 타입(MIME) 문자열을 전달받아 MediaType 객체로 변환
	public void setContentType(String contentType) {
		this.contentType = MediaType.valueOf(contentType);
	}

}




















