package com.model2.mvc.service.domain;

import lombok.Data;

@Data
public class IamportToken {
	private String access_token;
	private long now;
	private long expired_at;
}