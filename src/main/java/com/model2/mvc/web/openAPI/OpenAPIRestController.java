package com.model2.mvc.web.openAPI;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.openAPI.OpenAPIService;

@RestController
@RequestMapping("/openAPI/*")
public class OpenAPIRestController {

	/// Field
	@Autowired
	@Qualifier("openAPIServiceImpl")
	private OpenAPIService openAPIService;

	/// Constructor
	public OpenAPIRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="/json/main")
	@ResponseBody
	public Map<String, Object> listBoxOffice() throws Exception {
		System.out.println("/main : GET / POST");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			openAPIService.SeleniumTest();
			map.put("list", openAPIService.getMoiveList());
			map.put("message", "ok");
			
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
}