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
		
		// URL Pattern 을 확인하고. interceptor 적용유무 등록함.
		registry.addInterceptor( new LogonCheckInterceptor()).addPathPatterns("/user/**").addPathPatterns("/product/**").
		addPathPatterns("/purchase/**").addPathPatterns("/cart/**").addPathPatterns("/category/**");
		registry.addInterceptor( new CookieSettingInterceptor()).addPathPatterns("/product/getProduct/**");
	}
	
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
        .allowedOrigins("http://localhost:3000", "http://127.0.0.1:3000") // 모든 도메인 허용, 필요에 따라 수정
        .allowedMethods("GET", "POST", "PUT", "DELETE") // 허용할 HTTP 메서드 지정
        .allowCredentials(true) // 클라이언트 쿠키를 전송하기 위한 허용 여부
        .maxAge(3600); // preflight 요청을 캐시할 시간 설정 (초 단위)
	}
}
