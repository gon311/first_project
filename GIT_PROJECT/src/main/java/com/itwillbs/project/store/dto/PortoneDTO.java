package com.itwillbs.project.store.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PortoneDTO {
	private String paymentId;
    private String orderName;
    private int amount;       
    private String currency;
    private String status;    

    private Customer customer;
    private Method method;

    public static class Customer {
        private String fullName;
        private String email;
        private String phoneNumber;
    }

    public static class Method {
        private Card card;
        public static class Card {
            private String company;
            private String approvedAt;
        }
    }
}
