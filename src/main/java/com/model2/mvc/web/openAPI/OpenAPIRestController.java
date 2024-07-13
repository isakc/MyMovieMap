package com.model2.mvc.web.openAPI;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.openAPI.OpenAPIService;

@RestController
@RequestMapping("/openAPI/*")
public class OpenAPIRestController {
	
	/// Field
	@Autowired
	@Qualifier("openAPIServiceImpl")
	private OpenAPIService openAPIService;
		
	///Constructor
	public OpenAPIRestController() {
		System.out.println("==> OpenAPIRestController call");
	}
	
	///Method
	@GetMapping("json/getMovie/{movieCd}")
	public Map<String, Object> addProductView(@PathVariable("movieCd") int movieCd) throws Exception {

		System.out.println("json/getMovie/{movieCd} : GET");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
	
	@PostMapping("json/getSchedule")
	public Map<String, Object> getSchedule(@RequestBody String url) throws Exception {

		System.out.println("json/getSchedule/{url} : Post");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			map.put("list",openAPIService.getSchedule(url));
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
}