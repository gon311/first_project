package com.itwillbs.project.common.service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project.common.dto.CompanyCardDTO;
import com.itwillbs.project.common.mapper.CompanyCardMapper;

@Service
public class CompanyCardService {
	@Autowired
	private CompanyCardMapper companyCardMapper;
	
	@Transactional
	public List<CompanyCardDTO> getCardList(String type, Long userIdx) {
		List<CompanyCardDTO> cardList;

		// List에 들어온 광고에 한해서 banner table의 is_display on으로 전환하고, 나머지 모든 광고는 off로 전환 
		
		// 타입에 맞는 광고 데이터 조회 
		switch(type){
			case "today":
				cardList = companyCardMapper.selectTodayCompanies();
				break;
			case "popular": 
				cardList = companyCardMapper.selectPopularCompanies();
				break;
			case "bookmark":
				if(userIdx == null) {
					return Collections.emptyList();
				}
				cardList = companyCardMapper.selectBookmarkCompanies(userIdx);
				break;
			default : 
				cardList = companyCardMapper.selectTodayCompanies();
		}
		
		// banner 테이블 상태 업데이트 
		if(cardList != null && !cardList.isEmpty()) {
			// is_display - off 
			companyCardMapper.updateAllDisplayOff();
			
			// 리스트에 포함된 jobId만 추출 
			List<Long> activeJobIds = cardList.stream()
										.map(CompanyCardDTO::getJobId)
										.collect(Collectors.toList());
			
			// 추출된 광고들만 display on 
			companyCardMapper.updateSelectedDisplayOn(activeJobIds);
		}
		return cardList;
	}
		

}
