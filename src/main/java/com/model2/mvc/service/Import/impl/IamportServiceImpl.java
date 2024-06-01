package com.model2.mvc.service.Import.impl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.model2.mvc.service.Iamport.IamportService;
import com.model2.mvc.service.domain.IamportToken;

@Service
public class IamportServiceImpl implements IamportService{

	public String getToken() {
		
		RestTemplate restTemplate = new RestTemplate();
	
		//������ ��û�� Header
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("imp_key", "0261615157020580");
	    map.put("imp_secret", "wydOCI38a12F4OmTEK7HaZHIldyQN5tcGUVchD94RLwbveyL1L77AUAGAcy4ksoqkah5rdHzAc24KesB");
	    
	    Gson var = new Gson();
	    String json=var.toJson(map);
		//������ ��û�� Body
	   
	    HttpEntity<String> entity = new HttpEntity<>(json,headers);
	    
		return restTemplate.postForObject("https://api.iamport.kr/users/getToken", entity, String.class);
	}//��� ��� �κ�
	
	public String requestSubPay() {

		String token = getToken();
		Gson str = new Gson();
		token = token.substring(token.indexOf("response") + 10);
		token = token.substring(0, token.length() - 1);

		IamportToken IamportToken = str.fromJson(token, IamportToken.class);

		String access_token = IamportToken.getAccess_token();
		System.out.println(access_token);

		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setBearerAuth(access_token);
		
		LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String formattedDateTime = currentDateTime.format(formatter);
        System.out.println("�ð�:" + formattedDateTime);
        
		Map<String, Object> map = new HashMap<>();
		map.put("customer_uid", "test-0017");
		map.put("merchant_uid", "order_monthly_" + formattedDateTime);
		map.put("amount", "1000");
		map.put("name", "test05");

		Gson var = new Gson();
		String json = var.toJson(map);
		System.out.println(json);
		HttpEntity<String> entity = new HttpEntity<>(json, headers);
		
		String result = restTemplate.postForObject("https://api.iamport.kr/subscribe/payments/again", entity, String.class);
		System.out.println(result);
		
		return result;
	}//����� ��û
}