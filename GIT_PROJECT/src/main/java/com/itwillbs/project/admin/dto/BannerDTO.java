package com.itwillbs.project.admin.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@RequiredArgsConstructor
public class BannerDTO {
	private int adId;
	private String companyName;
	private String jobTitle;
	private Timestamp payDate;
	private Timestamp expireDate;
	private int isDisplay;
}
