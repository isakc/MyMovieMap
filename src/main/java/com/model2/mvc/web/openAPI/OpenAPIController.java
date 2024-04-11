package com.model2.mvc.web.openAPI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.model2.mvc.service.openAPI.OpenAPIService;

@Controller
@RequestMapping("/openAPI/*")
public class OpenAPIController {

	/// Field
	@Autowired
	@Qualifier("openAPIServiceImpl")
	private OpenAPIService openAPIService;

	/// Constructor
	public OpenAPIController() {
		System.out.println(this.getClass());
	}
	
	@GetMapping(value="/main")
	public String listBoxOffice(Model model) throws Exception {
		System.out.println("/main : GET / POST");

		model.addAttribute("list", openAPIService.getMoiveList());
		
		return "forward:/main.jsp";
	}
}