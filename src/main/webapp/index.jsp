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
			
			let infowindow = new kakao.maps.InfoWindow({zIndex:1}); // ��Ŀ Ŭ�� �� ��Ҹ��� ǥ���� ����������
			let mapContainer = document.getElementById('map'); // ���� ǥ���� div 
			let mapOption = {
					center: new kakao.maps.LatLng(33.450701, 126.570667), // ���� �߽���ǥ
					level: 3 // ������ Ȯ�� ����
				};
			let map = new kakao.maps.Map(mapContainer, mapOption); // ���� ����
				
			if (navigator.geolocation) { // HTML5�� geolocation���� ��� Ȯ��
				
				navigator.geolocation.getCurrentPosition(function(position) { // GeoLocation�� �̿� ���� ��ġ ���
					let lat = position.coords.latitude; // ����
			    	let lon = position.coords.longitude; // �浵
			        let locPosition = new kakao.maps.LatLng(lat, lon); // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ ����
					let ps = new kakao.maps.services.Places();
					let options = {
					          location: locPosition,
					          radius: 5000,
					          sort: kakao.maps.services.SortBy.DISTANCE,
					          category_group_code: 'CT1'
					        };
					
			        ps.keywordSearch('CGV', placesSearchCB, options);
			        ps.keywordSearch('�ް��ڽ�', placesSearchCB, options);
			        ps.keywordSearch('�Ե��ó׸�', placesSearchCB, options);
			      });
				}// ���� ��ġ ��� end
				
				function placesSearchCB (data, status, pagination) { // Ű���� �˻� �Ϸ� �� ȣ��Ǵ� �ݹ��Լ�
					
				    if (status === kakao.maps.services.Status.OK) {
				    	
				        let bounds = new kakao.maps.LatLngBounds(); // �˻��� ��� ��ġ�� �������� ���� ������ �缳���ϱ����� LatLngBounds ��ü�� ��ǥ�� �߰�
				        let listCinema = $("#listCinema");
				        
				        for (let i=0; i<data.length; i++) {
				            displayMarker(data[i]);    
				            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				            getSchedule(data[i].place_url);
				            
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
				}//ũ�Ѹ����� ������

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
					<div id="map" class="col-md-10" style="width:700px; height:500px;"></div>
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