package com.itwillbs.project.common.DTO;

import java.time.LocalDate;

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
	private LocalDate closeDate;
}
