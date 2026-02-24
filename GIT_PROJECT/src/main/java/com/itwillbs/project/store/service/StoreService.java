package com.itwillbs.project.store.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

<<<<<<< HEAD
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
=======
import com.itwillbs.project.store.dto.StoreDTO;
import com.itwillbs.project.store.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService{

	@Autowired
	private StoreMapper storeMapper;
	//-------------------------------------------------------------
	
	// 구매하기 페이지 내 상품 정보 출력
	public StoreDTO getStoreInfo(String productId) {
		return storeMapper.selectStoreInfo(productId);
>>>>>>> branch 'Team-1' of https://github.com/gon311/first_project.git
	}

}
