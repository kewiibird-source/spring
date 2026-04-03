package com.example.demo.model;

import lombok.Data;

@Data
public class Product {
	
	// 제품별 매출액
	String productId;
	String productName;
	String sumPrice;
	
//	String memberId; //아이디
//	int productId; //제품번호
//	int orderQty; //주문개수
//	int orderPrice; //주문금액
//	String orderStatus; //주문상태
//	String orderDate; //주문일자
//	String deliveryAddr; //배송지
//	String deliveryStatus; //배송상태
	
}
