package com.model2.mvc.service.openAPI.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

//import org.openqa.selenium.By;
//import org.openqa.selenium.WebDriver;
//import org.openqa.selenium.WebElement;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.model2.mvc.common.WebDriverUtil;
import com.model2.mvc.service.domain.DailyBoxOffice;
import com.model2.mvc.service.openAPI.OpenAPIService;

@Service("openAPIServiceImpl")
public class OpenAPIServiceImpl implements OpenAPIService {
	
	///Field
	@Value("${common.kobisAPIKey}")
	private String kobisAPIKey;
	@Value("${common.kmdbAPIKey}")
	private String kmdbAPIKey;
	
	HttpURLConnection httpCon = null;
	//WebDriver driver = WebDriverUtil.getChromeDriver();
	
	///Constructor
	public OpenAPIServiceImpl() {
	}

	///Method
	@Override
	public List<DailyBoxOffice> getMoiveList() throws Exception {
		Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -1);
	    String targetDt = new SimpleDateFormat("yyyyMMdd").format(cal.getTime()); //어제 날짜 가져오기
	    String result = null; //결과 가져오기
	    List<DailyBoxOffice> dailyBoxOffices = new ArrayList<DailyBoxOffice>();
		StringBuilder urlBuilder = new StringBuilder();
		
		urlBuilder.append("http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=");
		urlBuilder.append(kobisAPIKey).append("&targetDt=").append(targetDt);
		
		result = readStreamToString(urlBuilder.toString());
		
		/*가져온 데이터 파싱하기*/
		ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode = mapper.readTree(result);
		JsonNode dailyBoxOfficeList = rootNode.path("boxOfficeResult").path("dailyBoxOfficeList");
		
		for(JsonNode movie: dailyBoxOfficeList) {
			urlBuilder = new StringBuilder("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=");
			urlBuilder.append(kobisAPIKey).append("&movieCd=").append(movie.get("movieCd").asText());
			
			result = readStreamToString(urlBuilder.toString());
			
			rootNode = mapper.readTree(result);
	        //String nation = rootNode.path("movieInfoResult").path("movieInfo").path("nations").get(0).path("nationNm").asText().trim();
	        //String nationQuery = (nation.contains("한국") ? "대한민국" : nation);
	        String director = rootNode.path("movieInfoResult").path("movieInfo").path("directors").get(0) != null ? rootNode.path("movieInfoResult").path("movieInfo").path("directors").get(0).path("peopleNm").asText() : "";
			
			urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y"); /*URL*/
	        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + kmdbAPIKey); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("title","UTF-8") + "=" + URLEncoder.encode(movie.get("movieNm").asText(), "UTF-8")); /*영화이름*/
	        urlBuilder.append("&" + URLEncoder.encode("releaseDts","UTF-8") + "=" + URLEncoder.encode(movie.get("openDt").asText().replaceAll("-", ""), "UTF-8"));//개봉날짜
	        //urlBuilder.append("&" + URLEncoder.encode("nation","UTF-8") + "=" + URLEncoder.encode(nationQuery, "UTF-8"));//개봉날짜
	        urlBuilder.append("&" + URLEncoder.encode("director","UTF-8") + "=" + URLEncoder.encode(director, "UTF-8"));//감독이름
	        
	        result = readStreamToString(urlBuilder.toString());
	        
	        /*가져온 데이터 파싱하기*/
	        rootNode = mapper.readTree(result);
	        System.out.println("영화이름: " + movie.get("movieNm").asText());
	        System.out.println("서비스키: " + kmdbAPIKey);
	        System.out.println("개봉일: " + movie.get("openDt").asText().replaceAll("-", ""));
	        System.out.println("감독:" + director);
	        String postersUrl = rootNode.path("Data").get(0).path("Result").get(0).path("posters").asText();
            
	        /*일일박스오피스 DTO에 추가*/
			DailyBoxOffice dailyBoxOffice = mapper.convertValue(movie, DailyBoxOffice.class);
			dailyBoxOffice.setPosterPath(Arrays.asList((postersUrl).split("\\|")));
			dailyBoxOffices.add(dailyBoxOffice);
		}
		
		return dailyBoxOffices;
	}
	
	public String getSchedule(String url) {
		String query = "";
		String homepageUrl = "";
		String box = "";
		
//		if (!ObjectUtils.isEmpty(driver)) {
//		    driver.get(url);
//		    driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
//		    homepageUrl = driver.findElement(By.cssSelector(".location_present > a")).getAttribute("href");
//		}
//		
//		if(url.contains("cgv")) {
//			query = ".sect-showtimes";
//		}else if(url.contains("megabox")) {
//			query = ".theater-list-box";
//		}else {
//			query = ".mCustomScrollbar";
//		}
//
//		driver.get(homepageUrl);
//		String test = driver.getPageSource();
//		//box = driver.findElement(By.cssSelector(query)).getAttribute("outerHTML");
		
		return box;
	}
	
	public String readStreamToString(String urlString) throws Exception {
		StringBuilder result = new StringBuilder();
		URL url = new URL(urlString);
		httpCon = (HttpURLConnection) url.openConnection();
		BufferedReader bf = new BufferedReader(new InputStreamReader(httpCon.getInputStream(), "UTF-8"));
		
		String line;
        while ((line = bf.readLine()) != null) {
        	result.append(line);
        }

        bf.close();
        
		return result.toString(); 
	}
}