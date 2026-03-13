package com.itwillbs.project.store.dto;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneId;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PortoneDTO {
	private String id;
    private String orderName;
    private String currency;
    private String status;    
    private LocalDateTime paidAt;
 
    private Amount amount;       
    private Customer customer;
    private Method method;

    @Getter
    @Setter
    @ToString
    public static class Customer {
        private String name;
        private String email;
        private String phoneNumber;
    }

    @Getter
    @Setter
    @ToString
    public static class Method {
    	private String type; // 결제 수단(card, virtual_account)
        private Card card;
         
        
        @Getter
        @Setter
        @ToString
        public static class Card { 
            private String name;
            private String number;
        }
        
    }
    
    @Getter
    @Setter
    @ToString
    public static class Amount {
    	private int total;
    }
    
    
    public void setPaidAt(String paidAt) {
        if (paidAt != null) {
            this.paidAt = OffsetDateTime.parse(paidAt)
                                        .atZoneSameInstant(ZoneId.of("Asia/Seoul")) // 한국 시간으로 보정
                                        .toLocalDateTime();
            
        }
    }
    
    
}
