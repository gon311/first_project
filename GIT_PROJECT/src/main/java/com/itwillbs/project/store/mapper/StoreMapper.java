package com.itwillbs.project.store.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.store.dto.MemberProductDTO;
import com.itwillbs.project.store.dto.OrderDTO;
import com.itwillbs.project.store.dto.PaymentDTO;
import com.itwillbs.project.store.dto.PortoneDTO;
import com.itwillbs.project.store.dto.StoreDTO;

@Mapper
public interface StoreMapper {
	
	// 세션에 저장된 회원 아이디(이메일)을 통해 회원 정보 조회
	MemberDTO selectUserInfo(String userEmail);

	// 구매하기 페이지 내 회원정보 출력
	OrderDTO selectOrderUser(String sId);

	// 구매하기 페이지 내 상품 정보 출력
	StoreDTO selectStoreInfo(String productId);
	
	// 구매자의 회원 유형 조회
	MemberDTO selectUserType(Integer id);
	
	// 구직자회원이 이용권을 보유하고 있고, 만료되지 않았는지 여부
	MemberProductDTO selectUserRemain(Integer id);
	
	// 기업회원이 이용권을 보유하고 있고, 만료되지 않았는지 여부
	MemberProductDTO selectComRemain(Integer id);
 
	// 결제내역 저장
	PaymentDTO insertPayInfo(PortoneDTO payment);

	// 주문정보 삽입
	void insertOrderInfo(@Param("order") OrderDTO order, @Param("store") StoreDTO store);

	// 주문정보 조회
	OrderDTO selectOrderInfo(String paymentId);

	// 결제 성공 시 결제 상태 변경
	void updateOrderStatus(OrderDTO orderInfo);
 
	// 결제 성공 시 결제 테이블에 저장
	void insertPaymentInfo(PaymentDTO paymentDTO);

	// 이용권 테이블에 구매자가 결제한 이용권 저장(구직자)
	void insertUserProduct(PaymentDTO paymentDTO);

	// 이용권 테이블에 구매자가 결제한 이용권 저장(기업)
	void insertComProduct(PaymentDTO paymentDTO);

	

	

	

	

	

	
}
