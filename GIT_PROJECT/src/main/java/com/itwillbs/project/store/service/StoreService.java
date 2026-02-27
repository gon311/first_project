package com.itwillbs.project.store.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.store.dto.OrderDTO;
import com.itwillbs.project.store.dto.ProductInfoDTO;
import com.itwillbs.project.store.dto.StoreDTO;
import com.itwillbs.project.store.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService{

	@Autowired
	private StoreMapper storeMapper;

	// 구매하기 페이지 내 상품 정보 출력
	public StoreDTO getStoreInfo(String productId) {
		return storeMapper.selectStoreInfo(productId);
	}
	
	// 구매하기 페이지 내 회원 정보 출력
	public OrderDTO getOrderUser(String sId) {
		return storeMapper.selectOrderUser(sId);
	}

}
