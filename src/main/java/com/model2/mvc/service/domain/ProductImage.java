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
public class ProductImage {
	private int imgNo;
	private String fileName;
	private int prodNo;
}