package com.itwillbs.project.common.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.common.DTO.CompanyCardDTO;
import com.itwillbs.project.common.mapper.CompanyCardMapper;

@Service
public class CompanyCardService {
	@Autowired
	private CompanyCardMapper companyCardMapper;

	public List<CompanyCardDTO> getCardList(String type) {
		
		switch(type){
			
			case "today":
				return companyCardMapper.selectTodayCompanies();
				
			case "popular": 
				return companyCardMapper.selectPopularCompanies();
	
			case "wishlist":
				return companyCardMapper.selectWishlistCompanies();
			
			default : 
				return Collections.emptyList();
		}

	}
		

}
