package com.itwillbs.project.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.common.DTO.CompanyCardDTO;

@Mapper
public interface CompanyCardMapper {

	List<CompanyCardDTO> selectTodayCompanies();

	List<CompanyCardDTO> selectPopularCompanies();

	List<CompanyCardDTO> selectBookmarkCompanies(Long userIdx);
	

}
