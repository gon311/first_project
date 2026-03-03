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
	
	private String SECRET_KEY = "a6ahq9hSCGloLXjNbEEcoxQafWxrTuuUjr0SOFOFNLBUk0hiz8iZIIAQjG1iAnO7W5SkyZFueUu9iyLy";
//	@Value("${portone.api_key}")
//	private String SECRET_KEY;

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
        headers.set("Authorization", "PortOne " + SECRET_KEY);
        System.out.println(headers); 

        // 4️. HTTP 요청 객체 생성
        // GET 요청 시 바디는 필요 없지만 헤더를 포함하기 위해 HttpEntity 사용
        HttpEntity<Void> entity = new HttpEntity<>(null, headers);
 
        // 5️. RestTemplate로 GET 요청 실행
        // exchange() 메소드: URL, HTTP 메소드, HttpEntity(헤더+바디), 반환 타입 지정
//        ResponseEntity<PortoneDTO> response =
//                restTemplate.exchange(url, HttpMethod.GET, entity, PortoneDTO.class);
        
        restTemplate.getInterceptors().add((request, body, execution) -> {
            System.out.println("REAL REQUEST HEADERS: " + request.getHeaders());
            return execution.execute(request, body);
        });
        
        try {
            ResponseEntity<PortoneDTO> response =
                    restTemplate.exchange(url, HttpMethod.GET, entity, PortoneDTO.class);
            return response.getBody();
        } catch (HttpClientErrorException e) {
            System.out.println("STATUS: " + e.getStatusCode());
            System.out.println("BODY: " + e.getResponseBodyAsString());
            throw e;
        } 

        // 6️. PortOne 서버에서 받은 결제 정보(Body) 반환
//        return response.getBody();
    }

    // 결제 내역 테이블에 저장
//	public PaymentDTO setPayment(PortoneDTO payment) {
//		return storeMapper.insertPayInfo(payment);
//	}

	public void setPaymentInfo(PortoneDTO paymentInfo) {
		storeMapper.insertPaymentInfo(paymentInfo);
	}

	 

	

//	// 구매 정보 조회(구매자 정보 및 구매 상품 정보)
//	public OrderDTO getOrderInfo(String sId) {
//		return storeMapper.selectOrderInfo(sId);
//	}
//
//	

}
