package com.itwillbs.project.store.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.store.dto.MemberProductDTO;
import com.itwillbs.project.store.dto.OrderDTO;
import com.itwillbs.project.store.dto.PaymentDTO;
import com.itwillbs.project.store.dto.PortoneDTO;
import com.itwillbs.project.store.dto.StoreDTO;
import com.itwillbs.project.store.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class StoreService{

	@Autowired
	private StoreMapper storeMapper;
	
	// 세션에 저장된 회원 아이디(이메일)을 통해 회원 정보 조회
	public MemberDTO getUserInfo(String userEmail) {
		return storeMapper.selectUserInfo(userEmail);
	}

	// 구매하기 페이지 내 회원 정보 출력
	public OrderDTO getOrderUser(String sId) {
		return storeMapper.selectOrderUser(sId);
	}

	// 구매하기 페이지 내 상품 정보 출력
	public StoreDTO getStoreInfo(String productId) {
		return storeMapper.selectStoreInfo(productId);
	}
	
	// 구매자의 회원 유형 조회
	public MemberDTO getUserType(long id) {
		return storeMapper.selectUserType(id);
	}
	
	// 구직자회원이 이용권을 가지고 있고, 만료되지 않았는지 여부
	public boolean getUserRemain(long id) {
		// 이용권이 만료되지 않은 경우(구매불가)
		if(storeMapper.selectUserRemain(id) != null) {
			return false;
		} else { // 구매가능
			return true;
		}
		
	} 
	
	// 기업회원이 이용권을 가지고 있고, 만료되지 않았는지 여부
	public MemberProductDTO getComRemain(long id) {
		return storeMapper.selectComRemain(id);
	} 
	
	// 주문 정보 삽입
	public void setOrderInfo(OrderDTO order, StoreDTO store) {
		storeMapper.insertOrderInfo(order, store);
	}
	
	// 주문 정보 조회
	public OrderDTO findByPaymentId(String paymentId) {
		return storeMapper.selectOrderInfo(paymentId);
	}
	
	// 결제 성공한 경우 결제 상태 변경
 	public void setOrderStatus(OrderDTO orderInfo) {
 		storeMapper.updateOrderStatus(orderInfo);
 	}

    // 결제 내역 테이블에 저장
	public void setPaymentInfo(PaymentDTO paymentDTO) {
		storeMapper.insertPaymentInfo(paymentDTO);
	}
	
	// 이용권 테이블에 구매자가 결제한 이용권 저장(구직자)
	public void setUserProduct(PaymentDTO paymentDTO) {
		storeMapper.insertUserProduct(paymentDTO);
	}
	
	// 이용권 테이블에 구매자가 결제한 이용권 저장(기업)
	public void setComProduct(PaymentDTO paymentDTO) {
		storeMapper.insertComProduct(paymentDTO);
	}
	
	// 기업회원의 경우) 일반 이용권 보유 유무 조회
	public MemberProductDTO getMemberProduct(long userId) {
		return storeMapper.selectBasicProduct(userId);
	} 
	
	// 일반 이용권을 보유중인 기업회원이 프리미엄 이용권을 구매한 경우, 일반 이용권은 소멸
	public void changeUseStatus(String payId) {
		storeMapper.updateUseStatus(payId);
	}
	
	// 결제 조회 api
	@Value("${portone.api_key}")
	private String SECRET_KEY;

    public PortoneDTO getPayment(String paymentId) {
        String url = "https://api.portone.io/payments/" + paymentId;
 
        RestTemplate restTemplate = new RestTemplate();
         
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "PortOne " + SECRET_KEY);
 
        HttpEntity<Void> entity = new HttpEntity<>(null, headers);
        
        try {
            ResponseEntity<PortoneDTO> response = restTemplate.exchange(url, HttpMethod.GET, entity, PortoneDTO.class);
            return response.getBody();
            
        } catch (HttpClientErrorException e) {
            System.out.println("에러 메시지: " + e.getResponseBodyAsString()); 
            throw e;
        }
        
    }


    // 구직자 이용권 업데이트
	public void setPassCount(PaymentDTO paymentDTO) {
		storeMapper.updatePassCount(paymentDTO);
	}

	

	

	

	

	

	

	

	

	

	

	
    

}
