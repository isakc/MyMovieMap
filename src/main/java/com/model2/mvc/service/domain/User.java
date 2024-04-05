package com.model2.mvc.service.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.AccessLevel;

@Builder  //=> �������� �̿� ���°�����(???)
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class User {
	
	private String userId;
	private String userName;
	private String password;
	private String role;
	private String ssn;
	@Setter(AccessLevel.PRIVATE)
	private String phone;
	private String addr;
	private String email;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date regDate;
	/////////////// EL ���� ���� �߰��� Field ///////////
	private String phone1;
	private String phone2;
	private String phone3;
	private String addr1;
	private String addr2;
	private String addr3;
	//////////////////////////////////////////////////////////////////////////////////////////////
	// JSON ==> Domain Object  Binding�� ���� �߰��� �κ�
	private String regDateString;
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
}