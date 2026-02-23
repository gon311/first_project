package com.itwillbs.project.admin.dto;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserDTO {
	private LocalDate birth;
	private char gender;
	private String country;
	private Integer passCount;
	private Integer reportReceivedCount;
	private String profileUrl;
}
