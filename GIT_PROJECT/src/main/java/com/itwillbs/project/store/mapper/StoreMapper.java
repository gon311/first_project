package com.itwillbs.project.store.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.store.dto.StoreDTO;

@Mapper
public interface StoreMapper {

	// 구매하기 페이지 내 상품 정보 출력
	StoreDTO selectStoreInfo(String productId);

}
