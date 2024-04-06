package com.model2.mvc.common.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/*
 * Welcome Page  : 여러가지 방법중 Controller 로 만듬.
 */
@Controller
public class MainController {
	
	///Constructor
	public MainController(){
		System.out.println("==> MainController default Constructor call.............");
	}

	@GetMapping("/")
	public String index() {
		
		System.out.println("[ MainController.index() start........]");//<== 디버깅용
		return "/index.jsp";
	}
}
