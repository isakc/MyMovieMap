package com.model2.mvc.web.openAPI;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.model2.mvc.service.openAPI.OpenAPIService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
@RequestMapping("/openAPI/*")
public class OpenAPIController {

	/// Field
	@Autowired
	@Qualifier("openAPIServiceImpl")
	private OpenAPIService openAPIService;
	
	/// Field
	@Autowired
	@Qualifier("iamportServiceImpl")
	private com.model2.mvc.service.Iamport.IamportService iamportService;
	
	/// Field
	@Autowired
	@Qualifier("reqPaymentScheduler")
	private com.model2.mvc.service.Import.impl.ReqPaymentScheduler reqPaymentScheduler;
	
	private final IamportClient iamportClient;

	/// Constructor
	public OpenAPIController() {
		System.out.println(this.getClass());
		this.iamportClient = new IamportClient("0261615157020580", "wydOCI38a12F4OmTEK7HaZHIldyQN5tcGUVchD94RLwbveyL1L77AUAGAcy4ksoqkah5rdHzAc24KesB");
	}
	
	@GetMapping(value="/main")
	public String listBoxOffice(Model model) throws Exception {
		System.out.println("/main : GET / POST");

		model.addAttribute("list", openAPIService.getMoiveList());
		
		return "forward:/main.jsp";
	}
	
	@ResponseBody
    @PostMapping("/verify/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(@PathVariable("imp_uid") String imp_uid) throws IamportResponseException, IOException {
        return iamportClient.paymentByImpUid(imp_uid);
    }
	
	@ResponseBody
    @GetMapping("/importAccessKey")
    public void importAccessKey() throws Exception{
		System.out.println(iamportService.requestSubPay());
		reqPaymentScheduler.startScheduler("test-0001", 1000);
    }
}