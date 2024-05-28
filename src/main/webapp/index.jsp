 <%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <c:if test="${ ! empty user }">
 	<jsp:forward page="/openAPI/main"/>
 </c:if>
 
<html>
<head>
	<title>MEET PLAY SHARE</title>
	<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="/common/link.jsp"/>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9bb092e55e04073df199c8fdf46abadd&libraries=services"></script><!-- īī�� ���� -->
	<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=5ywbd53nfb&submodules=geocoder"></script><!-- ���̹� ���� -->
	<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK3BruPsInXptwielzi9Ni5JmKJNfGnFE&callback=initMap&v=weekly" defer></script> ���� ����
	<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script> -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
	
	<script type="text/javascript">
		//============= ȸ�������� ȭ���̵� =============
		$( function() {
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#' ]:contains('ȸ������')").on("click" , function() {
				self.location = "/user/addUser"
			});
			
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#' ]:contains('�� �� ��')").on("click" , function() {
				self.location = "/user/login"
			});
			
			$("a[href='#' ]:contains('��ǰ�˻�')").on("click" , function() {
				self.location = "/product/listProduct/search"
			});
			
			///////////////////////////////******* MAP *********//////////////////////////////////////////
			
			let infowindow = new kakao.maps.InfoWindow({zIndex:1}); // ��Ŀ Ŭ�� �� ��Ҹ��� ǥ���� ����������
			let mapContainer = document.getElementById('map'); // ���� ǥ���� div 
			let mapOption = {
					center: new kakao.maps.LatLng(33.450701, 126.570667), // ���� �߽���ǥ
					level: 3 // ������ Ȯ�� ����
				};
			let map = new kakao.maps.Map(mapContainer, mapOption); // ���� ����
			const keywords = ['�Ե��ó׸�', 'CGV', '�ް��ڽ�'];
				
			if (navigator.geolocation) { // HTML5�� geolocation���� ��� Ȯ��
				
				navigator.geolocation.getCurrentPosition(function(position) { // GeoLocation�� �̿� ���� ��ġ ���
					let lat = position.coords.latitude; // ����
			    	let lon = position.coords.longitude; // �浵
			        let locPosition = new kakao.maps.LatLng(lat, lon); // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ ����
					let ps = new kakao.maps.services.Places();
					let options = {
					          location: locPosition,
					          radius: 1000,
					          sort: kakao.maps.services.SortBy.DISTANCE,
					          category_group_code: 'CT1'
					        };
					
					// Ű���� �迭
			        const keywords = ['�Ե��ó׸�', 'CGV', '�ް��ڽ�'];

			        // �񵿱� �۾��� ���������� ó���ϴ� �Լ�
			        function searchCinemasSequentially(index) {
			            if (index < keywords.length) {
			                let ps = new kakao.maps.services.Places();
			                ps.keywordSearch(keywords[index], function(data, status, pagination) {
			                    placesSearchCB(data, status, pagination);
			                    searchCinemasSequentially(index + 1); // ���� Ű����� �˻�
			                }, options);
			            }
			        }

			        // ���������� ��ȭ�� �˻� ����
			        searchCinemasSequentially(0);
			        
			      });
				}// ���� ��ġ ��� end
				
				function placesSearchCB (data, status, pagination) { // Ű���� �˻� �Ϸ� �� ȣ��Ǵ� �ݹ��Լ�
					
				    if (status === kakao.maps.services.Status.OK) {
				    	
				        let bounds = new kakao.maps.LatLngBounds(); // �˻��� ��� ��ġ�� �������� ���� ������ �缳���ϱ����� LatLngBounds ��ü�� ��ǥ�� �߰�
				        let listCinema = $("#listCinema");
				        
				        for (let i=0; i<data.length; i++) {
				            displayMarker(data[i]);    
				            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				            
				            listCinema.append('<a href="'+data[i].place_url+'" target=_blank class="list-group-item list-group-item-action">'+data[i].place_name+'</a>');
				        }       

				        map.setBounds(bounds); // �˻��� ��� ��ġ�� �������� ���� ������ �缳��
				    } 
				}// placeSearchDB end
				
				function displayMarker(place) { // ��Ŀ ǥ�� �Լ�
				    
				    let marker = new kakao.maps.Marker({ // ��Ŀ����, ǥ��
				        map: map,
				        position: new kakao.maps.LatLng(place.y, place.x) 
				    });
				
				    kakao.maps.event.addListener(marker, 'click', function() {  // ��Ŀ Ŭ���̺�Ʈ ���
				        
				        infowindow.setContent('<div style="padding:5px; font-size:12px;">' + place.place_name + '</div>' + '<div>'+place.distance+'M </div>'); // ��Ŀ Ŭ���� ���� ���
				        infowindow.open(map, marker);
				    });
				    
				}//displayMarker end
				
				/////////////////// *****���̹��� ****//////////////////////////////////////////////////////
				
				/* var map = new naver.maps.Map('map', {
    				center: new naver.maps.LatLng(37.5666805, 126.9784147),
    				zoom: 10,
    				mapTypeId: naver.maps.MapTypeId.NORMAL
				});
				
				var infowindow = new naver.maps.InfoWindow();
				
				function onSuccessGeolocation(position) { // ����� ���
				    var location = new naver.maps.LatLng(position.coords.latitude,
				                                         position.coords.longitude);
				    
				    map.setCenter(location); // ���� ��ǥ�� ������ �߽����� �����մϴ�.
				    map.setZoom(15); // ������ �� ������ �����մϴ�.
				    
				    
				    
				    var marker = new naver.maps.Marker({
				        position: new naver.maps.LatLng(position.coords.latitude, position.coords.longitude),
				        map: map
				    });
				    
				    //infowindow.setContent('<div style="padding:20px;">' + '���� ��ġ' + '</div>');
				    //infowindow.open(map, location);
				    //console.log('Coordinates: ' + location.toString()); ��ġ���� Ȯ�� .toString();
				}
				
				function onErrorGeolocation() { // ������ ���
				    var center = map.getCenter();

				    infowindow.setContent('<div style="padding:20px;">' +
				        '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "latitude: "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');

				    infowindow.open(map, center);
				}
				
				$(window).on("load", function() {
				    if (navigator.geolocation) { //���� ���� ��ġ�� ���� �� �ִٸ�
				        navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation); //���/������ ���
				    } else {
				        var center = map.getCenter();
				        infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
				        infowindow.open(map, center);
				    }
				}); */
				
				
				
				////////////////////////////���۸�////////////////////////////////////////
				/*
				let map, infoWindow;

				function initMap() {
				  map = new google.maps.Map(document.getElementById("map"), {
				    center: { lat: -34.397, lng: 150.644 },
				    zoom: 6,
				  });
				  infoWindow = new google.maps.InfoWindow();

				  const locationButton = document.createElement("button");

				  locationButton.textContent = "Pan to Current Location";
				  locationButton.classList.add("custom-map-control-button");
				  map.controls[google.maps.ControlPosition.TOP_CENTER].push(locationButton);
				  locationButton.addEventListener("click", () => {
				    // Try HTML5 geolocation.
				    if (navigator.geolocation) {
				      navigator.geolocation.getCurrentPosition(
				        (position) => {
				          const pos = {
				            lat: position.coords.latitude,
				            lng: position.coords.longitude,
				          };

				          infoWindow.setPosition(pos);
				          infoWindow.setContent("Location found.");
				          infoWindow.open(map);
				          map.setCenter(pos);
				        },
				        () => {
				          handleLocationError(true, infoWindow, map.getCenter());
				        }
				      );
				    } else {
				      // Browser doesn't support Geolocation
				      handleLocationError(false, infoWindow, map.getCenter());
				    }
				  });
				}

				function handleLocationError(browserHasGeolocation, infoWindow, pos) {
				  infoWindow.setPosition(pos);
				  infoWindow.setContent(
				    browserHasGeolocation
				      ? "Error: The Geolocation service failed."
				      : "Error: Your browser doesn't support geolocation."
				  );
				  infoWindow.open(map);
				}

				window.initMap = initMap;
				*/
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
	                 <li><a href="#">ȸ������</a></li>
	                 <li><a href="#">�� �� ��</a></li>
	           	</ul>
	       </div>
   		
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- �ٴܷ��̾ƿ�  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu ���� Start /////////////////////////////////////-->     	
			<div class="col-md-3">
		        
		       	<!--  ȸ������ ��Ͽ� ���� -->
				<div class="panel panel-primary">
				
					<div class="panel-heading">
						<span class="glyphicon glyphicon-heart"></span>
						ȸ������
         			</div>
         			
         			<!--  ȸ������ ������ -->
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">����������ȸ</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">ȸ��������ȸ</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
					</ul>
		        </div>
               
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<span class="glyphicon glyphicon-briefcase"></span> �ǸŻ�ǰ����
         			</div>
         			
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">�ǸŻ�ǰ���</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">�ǸŻ�ǰ����</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
					</ul>
					
		        </div>
               
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<span class="glyphicon glyphicon-shopping-cart"></span> ��ǰ����
	    			</div>
	    			
					<ul class="list-group">
						 <li class="list-group-item"><a href="#">��ǰ�˻�</a></li>
						  <li class="list-group-item">
						  	<a href="#">�����̷���ȸ</a> <span class="glyphicon glyphicon-ban-circle"></span>
						  </li>
					</ul>
				</div>
				
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<i class="fas fa-box"></i> ��ٱ���
	    			</div>
	    			
					<ul class="list-group">
						  <li class="list-group-item">
						  	<a href="#">��ٱ���</a> <span class="glyphicon glyphicon-ban-circle"></span>
						  </li>
					</ul>
				</div>
				
			</div>
			<!--  Menu ���� end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-9">
				<strong>�� ��ó ��ȭ��</strong>
				<div class="row">
					<!-- <div id="map" class="col-md-10" style="width:700px; height:500px;"></div> --> <!-- Map �����ִ� �� -->
					<div id="map" class="col-md-10" style="width:700px; height: 500px;"></div>
					<div id="listCinema" class="col-md-2 list-group"></div>
				</div>
				
				<div id="schedule">
					���� �׽�Ʈ��
				</div>
			</div>
	   	 	<!--  Main end /////////////////////////////////////--> 
	 	 	
		</div>
		<!-- �ٴܷ��̾ƿ�(row) end /////////////////////////////////////-->
		
	</div>
	<!--  ȭ�鱸��(container div) end /////////////////////////////////////-->
</body>

</html>