package com.itwillbs.project.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.common.dto.CompanyCardDTO;

@Mapper
public interface CompanyCardMapper {

	List<CompanyCardDTO> selectTodayCompanies();

	List<CompanyCardDTO> selectPopularCompanies();

	List<CompanyCardDTO> selectBookmarkCompanies(Long userIdx);

	void updateAllDisplayOff();

	void updateSelectedDisplayOn(@Param("jobIds") List<Long> jobIds);
	

}
