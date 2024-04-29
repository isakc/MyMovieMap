<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <c:if test="${ ! empty user }">
 	<jsp:forward page="/openAPI/main"/>
 </c:if>
 
<html>
<head>
	<title>MEET PLAY SHARE</title>
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="/common/link.jsp"/>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9bb092e55e04073df199c8fdf46abadd&libraries=services"></script><!-- 카카오 지도 -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
	
	<script type="text/javascript">
		//============= 회원원가입 화면이동 =============
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]:contains('회원가입')").on("click" , function() {
				self.location = "/user/addUser"
			});
			
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]:contains('로 그 인')").on("click" , function() {
				self.location = "/user/login"
			});
			
			$("a[href='#' ]:contains('상품검색')").on("click" , function() {
				self.location = "/product/listProduct/search"
			});
			
			let infowindow = new kakao.maps.InfoWindow({zIndex:1}); // 마커 클릭 시 장소명을 표출할 인포윈도우
			let mapContainer = document.getElementById('map'); // 지도 표시할 div 
			let mapOption = {
					center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도 중심좌표
					level: 3 // 지도의 확대 레벨
				};
			let map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성
				
			if (navigator.geolocation) { // HTML5의 geolocation으로 사용 확인
				
				navigator.geolocation.getCurrentPosition(function(position) { // GeoLocation을 이용 접속 위치 얻기
					let lat = position.coords.latitude; // 위도
			    	let lon = position.coords.longitude; // 경도
			        let locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표 생성
					let ps = new kakao.maps.services.Places();
					let options = {
					          location: locPosition,
					          radius: 5000,
					          sort: kakao.maps.services.SortBy.DISTANCE,
					          category_group_code: 'CT1'
					        };
					
			        ps.keywordSearch('CGV', placesSearchCB, options);
			        ps.keywordSearch('메가박스', placesSearchCB, options);
			        ps.keywordSearch('롯데시네마', placesSearchCB, options);
			      });
				}// 현재 위치 얻기 end
				
				function placesSearchCB (data, status, pagination) { // 키워드 검색 완료 시 호출되는 콜백함수
					
				    if (status === kakao.maps.services.Status.OK) {
				    	
				        let bounds = new kakao.maps.LatLngBounds(); // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가
				        let listCinema = $("#listCinema");
				        
				        for (let i=0; i<data.length; i++) {
				            displayMarker(data[i]);    
				            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				            getSchedule(data[i].place_url);
				            
				            listCinema.append('<a href="'+data[i].place_url+'" target=_blank class="list-group-item list-group-item-action">'+data[i].place_name+'</a>');
				        }       

				        map.setBounds(bounds); // 검색된 장소 위치를 기준으로 지도 범위를 재설정
				    } 
				}// placeSearchDB end
				
				function displayMarker(place) { // 마커 표시 함수
				    
				    let marker = new kakao.maps.Marker({ // 마커생성, 표시
				        map: map,
				        position: new kakao.maps.LatLng(place.y, place.x) 
				    });

				    kakao.maps.event.addListener(marker, 'click', function() {  // 마커 클릭이벤트 등록
				        
				        infowindow.setContent('<div style="padding:5px; font-size:12px;">' + place.place_name + '</div>' + '<div>'+place.distance+'M </div>'); // 마커 클릭시 정보 출력
				        infowindow.open(map, marker);
				    });
				}//displayMarker end
				
				
				function getSchedule(url) {
					$.ajax({
						url: "/openAPI/json/getSchedule/",
						method: "POST",
						data: url,
						headers: {
							"Accept": "application/json",
							"Content-Type": "application/json"
						},
						data: url,
						
						success: function(data) {							
								console.log(data);
							}
						});
				}//크롤링으로 얻어오기

		});
		
	</script>
	
	<title>Model2 MVC Shop</title>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar navbar-default">
		
        <div class="container">
        
        	<a class="navbar-brand" href="#">Model2 MVC Shop</a>
			
			<!-- toolBar Button Start //////////////////////// -->
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </button>
			</div>
			<!-- toolBar Button End //////////////////////// -->
			
			<div class="collapse navbar-collapse"  id="target">
	             <ul class="nav navbar-nav navbar-right">
	                 <li><a href="#">회원가입</a></li>
	                 <li><a href="#">로 그 인</a></li>
	           	</ul>
	       </div>
   		
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- 다단레이아웃  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu 구성 Start /////////////////////////////////////-->     	
			<div class="col-md-3">
		        
		       	<!--  회원관리 목록에 제목 -->
				<div class="panel panel-primary">
				
					<div class="panel-heading">
						<span class="glyphicon glyphicon-heart"></span>
						회원관리
         			</div>
         			
         			<!--  회원관리 아이템 -->
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">개인정보조회</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">회원정보조회</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
					</ul>
		        </div>
               
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<span class="glyphicon glyphicon-briefcase"></span> 판매상품관리
         			</div>
         			
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">판매상품등록</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">판매상품관리</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
					</ul>
					
		        </div>
               
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<span class="glyphicon glyphicon-shopping-cart"></span> 상품구매
	    			</div>
	    			
					<ul class="list-group">
						 <li class="list-group-item"><a href="#">상품검색</a></li>
						  <li class="list-group-item">
						  	<a href="#">구매이력조회</a> <span class="glyphicon glyphicon-ban-circle"></span>
						  </li>
					</ul>
				</div>
				
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<i class="fas fa-box"></i> 장바구니
	    			</div>
	    			
					<ul class="list-group">
						  <li class="list-group-item">
						  	<a href="#">장바구니</a> <span class="glyphicon glyphicon-ban-circle"></span>
						  </li>
					</ul>
				</div>
				
			</div>
			<!--  Menu 구성 end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-9">
				<strong>내 근처 영화관</strong>
				<div class="row">
					<div id="map" class="col-md-10" style="width:700px; height:500px;"></div>
					<div id="listCinema" class="col-md-2 list-group"></div>
				</div>
				
				<div id="schedule">
					나는 테스트중
				</div>
			</div>
	   	 	<!--  Main end /////////////////////////////////////--> 
	 	 	
		</div>
		<!-- 다단레이아웃(row) end /////////////////////////////////////-->
		
	</div>
	<!--  화면구성(container div) end /////////////////////////////////////-->
</body>

</html>