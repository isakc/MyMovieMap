package com.model2.mvc.service.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder  //=> 빌더패턴 이용 상태값설정(???)
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Purchase {

	private User buyer;
	private String divyAddr;
	private String divyDate;
	private String divyRequest;
	private Date orderDate;
	private String paymentOption;
	private String receiverName;
	private String receiverPhone;
	private String tranCode;
	private int tranNo;
	/////////////////////추가///////////////////////////////////////////////
	private String divyAddr1;
	private String divyAddr2;
	private String divyAddr3;
}