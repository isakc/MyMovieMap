package com.model2.mvc.service.openAPI.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.model2.mvc.common.WebDriverUtil;
import com.model2.mvc.service.domain.DailyBoxOffice;
import com.model2.mvc.service.domain.Movie;
import com.model2.mvc.service.openAPI.OpenAPIService;

@Service("openAPIServiceImpl")
public class OpenAPIServiceImpl implements OpenAPIService {
	
	///Field
	@Value("${common.kobisAPIKey}")
	String kobisAPIKey;
	@Value("${common.kmdbAPIKey}")
	String kmdbAPIKey;
	
	HttpClient httpClient = HttpClients.createDefault();
	WebDriver driver = WebDriverUtil.getChromeDriver();
	
	///Constructor
	public OpenAPIServiceImpl() {
	}

	///Method
	@Override
	public List<DailyBoxOffice> getMoiveList() throws Exception {
		Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -1);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	    String targetDt = dateFormat.format(cal.getTime()); //어제 날짜 가져오기
	  
		String apiURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="+kobisAPIKey+"&targetDt="+targetDt;
		
		URL url = new URL(apiURL);
		
		BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

		String result = bf.readLine();
		
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String,Object> dailyResult = mapper.readValue(result, HashMap.class);
		HashMap<String, Object> boxOfficeResult = (HashMap<String, Object>) dailyResult.get("boxOfficeResult");
		ArrayList<HashMap<String, Object>> dailyBoxOfficeList = (ArrayList<HashMap<String, Object>>) boxOfficeResult.get("dailyBoxOfficeList");
		
		List<DailyBoxOffice> dailyBoxOffices = new ArrayList<>();
		
		for(HashMap<String, Object> movie: dailyBoxOfficeList) {
			String movieNm =  ((String) movie.get("movieNm"));
			String releaseDate =  ((String) movie.get("openDt")).replaceAll("-", "");
			
			StringBuilder urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y"); /*URL*/
	        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + kmdbAPIKey); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("query","UTF-8") + "=" + URLEncoder.encode(movieNm, "UTF-8")); /*영화이름*/
	        urlBuilder.append("&" + URLEncoder.encode("releaseDts","UTF-8") + "=" + URLEncoder.encode(releaseDate, "UTF-8"));
	        
	        url = new URL(urlBuilder.toString());
	        
	        bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
	        
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = bf.readLine()) != null) {
	            sb.append(line);
	        }
	        bf.close();
	        
	        JSONParser parser = new JSONParser();
	        JSONObject jsonObject = (JSONObject) parser.parse(sb.toString());
            JSONArray dataArray = (JSONArray) jsonObject.get("Data");
            JSONObject dataObject = (JSONObject) dataArray.get(0);
            JSONArray resultArray = (JSONArray) dataObject.get("Result");
            JSONObject resultObject = (JSONObject) resultArray.get(0);
            String posterPath = ((String) resultObject.get("posters")).split("\\|")[0];

			DailyBoxOffice dailyBoxOffice = mapper.convertValue(movie, DailyBoxOffice.class);
			dailyBoxOffice.setPosterPath(posterPath);
			dailyBoxOffices.add(dailyBoxOffice);
		}
		
		return dailyBoxOffices;
	}
	
	public void SeleniumTest() {
		List<WebElement> webElementList = new ArrayList<>();
		String url = "https://megabox.co.kr/event/detail?eventNo=15234";
		String query = ".couponArea";

		if (!ObjectUtils.isEmpty(driver)) {
		    driver.get(url);
		    driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
		    webElementList = driver.findElements(By.cssSelector(query));
		}
	
		WebElement parentElement = webElementList.get(0);
//		List<WebElement> childElement = parentElement.findElements(By.tagName("a"));
//
//		for(int i=0; i<childElement.size(); i++) {
//			System.out.println("이벤트 제목: " + childElement.get(i).findElement(By.className("tit")).getText());
//			System.out.println("기간: " + childElement.get(i).findElement(By.className("date")).getText());
//		}
		
		///////////////////////////////////////////////
		List<WebElement> childElement = parentElement.findElements(By.className("numb"));
		System.out.println("쿠폰 사용: " + childElement.get(0).getText());
	}

	@Override
	public Movie getMovie() throws Exception {
		
		
		return null;
	}
}