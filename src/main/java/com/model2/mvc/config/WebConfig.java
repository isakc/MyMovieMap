package com.model2.mvc.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.model2.mvc.common.web.LogonCheckInterceptor;
import com.model2.mvc.common.web.CookieSettingInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	public WebConfig() {
		System.out.println("==> WebConfig default Constructor call.............");
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		// URL Pattern �� Ȯ���ϰ�. interceptor �������� �����.
		registry.addInterceptor( new LogonCheckInterceptor()).addPathPatterns("/user/**").addPathPatterns("/product/**").
		addPathPatterns("/purchase/**").addPathPatterns("/cart/**").addPathPatterns("/category/**");
		registry.addInterceptor( new CookieSettingInterceptor()).addPathPatterns("/product/getProduct/**");
	}
	
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
        .allowedOrigins("http://localhost:3000", "http://127.0.0.1:3000") // ��� ������ ���, �ʿ信 ���� ����
        .allowedMethods("GET", "POST", "PUT", "DELETE") // ����� HTTP �޼��� ����
        .allowCredentials(true) // Ŭ���̾�Ʈ ��Ű�� �����ϱ� ���� ��� ����
        .maxAge(3600); // preflight ��û�� ĳ���� �ð� ���� (�� ����)
	}
}
