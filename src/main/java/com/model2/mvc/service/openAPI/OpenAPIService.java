package com.model2.mvc.service.openAPI;

import java.util.List;

import com.model2.mvc.service.domain.DailyBoxOffice;
import com.model2.mvc.service.domain.Movie;

public interface OpenAPIService {
	
	//selectList
	public List<DailyBoxOffice> getMoiveList() throws Exception;
	
	public void SeleniumTest() throws Exception;
}