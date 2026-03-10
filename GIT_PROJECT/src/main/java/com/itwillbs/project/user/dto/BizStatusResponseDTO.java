package com.itwillbs.project.user.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BizStatusResponseDTO {
	private String b_stt;    // 계속사업자 등
    private String tax_type; // 부가가치세 일반과세자 등
    private String b_nm;     // 상호/법인명 
    private String p_nm;     // 대표자명 
}
