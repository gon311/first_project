package com.itwillbs.project.store.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.store.dto.ProductInfoDTO;
import com.itwillbs.project.store.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService{

	@Autowired
	private StoreMapper storeMapper;

	// 구매할 상품 정보(구매하기 진행)
	public ProductInfoDTO getProductInfo(String productId) {
		return storeMapper.selectProductInfo(productId);
	}

}
