package com.model2.mvc.service.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder  //=> �������� �̿� ���°�����(???)
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Cart {
	///Field
	private int cartNo;
	private User user;
	private Product product;
	private int quantity;
}