package com.model2.mvc.service.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

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
public class User {
	
	private String userId;
	private String userName;
	private String password;
	private String role;
	private String ssn;
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
		/////////////// EL ���� ���� �߰� ///////////
		if(phone != null && phone.length() !=0 ){
			phone1 = phone.split("-")[0];
			phone2 = phone.split("-")[1];
			phone3 = phone.split("-")[2];
		}
	}
	
	public void setAddr(String addr) {
		this.addr = addr;
		if(addr != null && addr.length() !=0 && addr.split("/").length > 1){
			addr1 = addr.split("/")[0];
			addr2 = addr.split("/")[1];
			if(addr.split("/").length == 3) {
				addr3 = addr.split("/")[2];
			}
		}
	}
}