package com.itwillbs.project.store.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.store.dto.OrderDTO;
import com.itwillbs.project.store.dto.PaymentDTO;
import com.itwillbs.project.store.dto.PortoneDTO;
import com.itwillbs.project.store.dto.StoreDTO;

@Mapper
public interface StoreMapper {

	// 구매하기 페이지 내 회원정보 출력
	OrderDTO selectOrderUser(String sId);

	// 구매하기 페이지 내 상품 정보 출력
	StoreDTO selectStoreInfo(String productId);

	// 결제내역 저장
	PaymentDTO insertPayInfo(PortoneDTO payment);


//	// 구매정보 조회
//	OrderDTO selectOrderInfo(String sId);
//
//	// 구매정보 삽입
//	void insertOrderInfo(@Param("sId") String sId, @Param("productId") String productId);

	
}
