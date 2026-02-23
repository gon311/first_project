package com.itwillbs.project.store.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.store.dto.ProductInfoDTO;

@Mapper
public interface StoreMapper {

	// 구매할 상품 상세 정보 조회(구매하기 진행)
	ProductInfoDTO selectProductInfo(String productId);

}
