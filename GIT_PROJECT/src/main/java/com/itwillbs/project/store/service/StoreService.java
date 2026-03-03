package com.itwillbs.project.store.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.project.store.dto.OrderDTO;
import com.itwillbs.project.store.dto.PaymentDTO;
import com.itwillbs.project.store.dto.PortoneDTO;
import com.itwillbs.project.store.dto.StoreDTO;
import com.itwillbs.project.store.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService{

	@Autowired
	private StoreMapper storeMapper;

	// 구매하기 페이지 내 회원 정보 출력
	public OrderDTO getOrderUser(String sId) {
		return storeMapper.selectOrderUser(sId);
	}

	// 구매하기 페이지 내 상품 정보 출력
	public StoreDTO getStoreInfo(String productId) {
		return storeMapper.selectStoreInfo(productId);
	}
	
	private final String SECRET_KEY = "un7ZjFyG0hFwdsunbIhS9k2s7Z2rgBs4gjN0ZfefcudVazmtB9H7rbrUFPneeHmNHJVWtq0ICgxp6Q4l";

    public PortoneDTO getPayment(String paymentId) {
    	// 1️. PortOne 결제 조회 URL 생성
        // paymentId를 포함해서 PortOne 서버에서 해당 결제 정보를 조회
        String url = "https://api.portone.io/v2/payments/" + paymentId;
 
        // 2️. RestTemplate 생성
        // Spring에서 HTTP 요청을 보내고 응답을 받을 때 사용
        RestTemplate restTemplate = new RestTemplate();
        
        // 3️. HTTP 헤더 세팅
        // PortOne API는 Secret Key 기반 인증 필요
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(SECRET_KEY); // Authorization: Bearer <SECRET_KEY>

        // 4️. HTTP 요청 객체 생성
        // GET 요청 시 바디는 필요 없지만 헤더를 포함하기 위해 HttpEntity 사용
        HttpEntity<?> entity = new HttpEntity<>(headers);

        // 5️. RestTemplate로 GET 요청 실행
        // exchange() 메소드: URL, HTTP 메소드, HttpEntity(헤더+바디), 반환 타입 지정
        ResponseEntity<PortoneDTO> response =
                restTemplate.exchange(url, HttpMethod.GET, entity, PortoneDTO.class);

        // 6️. PortOne 서버에서 받은 결제 정보(Body) 반환
        return response.getBody();
    }

    // 결제 내역 테이블에 저장
	public PaymentDTO setPayment(PortoneDTO payment) {
		return storeMapper.insertPayInfo(payment);
	}

//	// 구매 정보 조회(구매자 정보 및 구매 상품 정보)
//	public OrderDTO getOrderInfo(String sId) {
//		return storeMapper.selectOrderInfo(sId);
//	}
//
//	// 구매 정보 삽입
//	public void setOrderInfo(String sId, String productId) {
//		storeMapper.insertOrderInfo(sId, productId);
//	}

}
