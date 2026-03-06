package com.itwillbs.project.admin.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@RequiredArgsConstructor
@ToString
public class BannerDTO {
	private int adId;
	private long jobId;
	private long compId;
	private String title;
	private Timestamp startDate;
	private Timestamp endDate;
	private int isDisplay;
}
