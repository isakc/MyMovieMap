<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>

<html lang="ko">

<head>
<title>MEET PLAY SHARE</title>
<meta charset="EUC-KR">

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--   jQuery , Bootstrap CDN  -->
<c:import url="/common/link.jsp" />
<link rel="stylesheet" href="/css/main.css"/>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9bb092e55e04073df199c8fdf46abadd&libraries=services"></script><!-- 카카오 지도 -->

<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
<style>
body {
	padding-top: 70px;
}

strong {
	font-size: 25px;
}

.aux {
	padding-top: 35px;
}
</style>

<script type="text/javascript">
	$(function () {
		var infowindow = new kakao.maps.InfoWindow({zIndex:1}); // 마커 클릭 시 장소명을 표출할 인포윈도우
		var mapContainer = document.getElementById('map'), // 지도 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도 중심좌표
	        level: 10 // 지도의 확대 레벨 
	    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성
		
		if (navigator.geolocation) { // HTML5의 geolocation으로 사용 확인
	    
	    navigator.geolocation.getCurrentPosition(function(position) { // GeoLocation을 이용 접속 위치 얻기
	     
	    	let lat = position.coords.latitude; // 위도
	    	let lon = position.coords.longitude; // 경도
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표 생성
			var ps = new kakao.maps.services.Places();
			var options = {
			          location: locPosition,
			          radius: 3000,
			          sort: kakao.maps.services.SortBy.DISTANCE,
			        };
			
	        ps.keywordSearch('영화관', placesSearchCB, options); 
	      });
		}// 현재 위치 얻기 end
		
		function placesSearchCB (data, status, pagination) { // 키워드 검색 완료 시 호출되는 콜백함수
			
		    if (status === kakao.maps.services.Status.OK) {
		    	
		        var bounds = new kakao.maps.LatLngBounds(); // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가
		        var listCinema = $("#listCinema");
		        
		        for (var i=0; i<data.length; i++) {
		        	console.log(data[i]);
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		            listCinema.append('<a href="'+data[i].place_url+'" target=_blank class="list-group-item list-group-item-action">'+data[i].place_name+'</a>');
		        }       

		        map.setBounds(bounds); // 검색된 장소 위치를 기준으로 지도 범위를 재설정
		    } 
		}// placeSearchDB end
		
		function displayMarker(place) { // 마커 표시 함수
		    
		    var marker = new kakao.maps.Marker({ // 마커생성, 표시
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });

		    kakao.maps.event.addListener(marker, 'click', function() {  // 마커 클릭이벤트 등록
		        
		        infowindow.setContent('<div style="padding:5px; font-size:12px;">' + place.place_name + '</div>'); // 마커 클릭시 정보 출력
		        infowindow.open(map, marker);
		    });
		}//displayMarker end

	})//function end
</script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<!-- 참조 : http://getbootstrap.com/css/   : container part..... -->
	<div class="container aux">
	
    <div class="row">
    
        <div class="row">
        
            <div class="col-md-9">
                <h3>일일 박스오피스</h3>
            </div>
            
            <div class="col-md-3">
                <!-- Controls -->
                <div class="controls pull-right hidden-xs">
                    <a class="left fa fa-chevron-left btn btn-primary" href="#carousel-example-generic"
                        data-slide="prev"></a><a class="right fa fa-chevron-right btn btn-primary" href="#carousel-example-generic"
                            data-slide="next"></a>
                </div>
            </div>
        </div>
        
        <div id="carousel-example-generic" class="carousel slide hidden-xs" data-ride="carousel">
            <!-- Wrapper for slides -->
            <div class="carousel-inner">
            
            <c:set var="count" value="0"/>
            <c:forEach var="movie" items="${list }">
            	<c:if test="${count % 3 == 0}">
            		<div class="item ${count == 0 ? 'active' : '' }">
						<div class="row">
				</c:if>
				
					<div class="col-sm-4">
								<div class="col-item">
									<div class="photo">
										<img src="${movie.posterPath[0] }" class="img-responsive" alt="a" />
									</div>
									<div class="info">

												<strong>${count+1}위 ${movie.movieNm }</strong>
											<c:choose>
													<c:when test="${movie.rankInten > 0}">
														<i class="fas fa-arrow-up" style="color: red;"></i>
														<span>${movie.rankInten }</span>
													</c:when>

													<c:when test="${movie.rankInten == 0 }">
														<c:if test="${movie.rankOldAndNew == 'NEW' }">
															<span style="color: orange;">NEW</span>
														</c:if>
													</c:when>

													<c:otherwise>
														<i class="fas fa-arrow-down" style="color: blue;"></i>
														<span>${fn:replace(movie.rankInten, '-' , '') }</span>
													</c:otherwise>
												</c:choose>
												<h5 class="price-text-color">어제 관객수: <fmt:formatNumber value="${movie.audiCnt }" pattern="#,###명" /></h5>
												<h5 class="price-text-color">누적 관객수: <fmt:formatNumber value="${movie.audiAcc }" pattern="#,###명" /></h5>
												<h5>개봉일: ${movie.openDt }</h5>
												

										<div class="clearfix"></div>
									</div>
								</div>
							</div> <!-- 카드 -->
							
					<c:if test="${ (count+1) % 3 == 0}">
            				</div>
						</div> <!-- carousel -->
					</c:if>
            	<c:set var="count" value="${count+1 }"/>
            </c:forEach>
    </div>

	</div>
	<!-- container1 end -->
	
	<div class="container aux">
		<strong>내 근처 영화관</strong>
		<div class="row">
			<div id="map" class="col-md-10" style="width:900px; height:700px;"></div>
			<div id="listCinema" class="col-md-2 list-group"></div>
		</div>
	</div>
</body>
</html>