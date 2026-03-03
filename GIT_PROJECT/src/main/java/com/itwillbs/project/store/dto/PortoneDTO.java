package com.itwillbs.project.store.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PortoneDTO {
	private String id;
	private String paymentId;
    private String orderName;
//    private int amount;       
    private String currency;
    private String status;    
    private String updatedAt;

    private Amount amount;       
    private Customer customer;
    private Method method;
    private PaidPayment paidpayment;

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
        private Card card;
        
        @Getter
        @Setter
        @ToString
        public static class Card {
            private String name;
            private String number;
//            private String approvedAt;
        }
    }
    
    @Getter
    @Setter
    @ToString
    public static class PaidPayment {
    	private LocalDateTime paidAt;
    }
    
    @Getter
    @Setter
    @ToString
    public static class Amount {
    	private Integer total;
    }
}
