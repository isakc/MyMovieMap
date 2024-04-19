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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9bb092e55e04073df199c8fdf46abadd&libraries=services"></script>

<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
<style>
body {
	padding-top: 70px;
}

strong {
	font-size: 25px;
}

.container {
	padding-top: 35px;
}
</style>

<script type="text/javascript">
	$(function () {
		// ��Ŀ�� Ŭ���ϸ� ��Ҹ��� ǥ���� ���������� �Դϴ�
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});

		var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // ������ �߽���ǥ
		        level: 3 // ������ Ȯ�� ����
		    };  

		// ������ �����մϴ�    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// ��� �˻� ��ü�� �����մϴ�
		var ps = new kakao.maps.services.Places(map); 

		// ī�װ��� ������ �˻��մϴ�
		ps.categorySearch('CT1', placesSearchCB, {useMapBounds:true}); 

		// Ű���� �˻� �Ϸ� �� ȣ��Ǵ� �ݹ��Լ� �Դϴ�
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		        }       
		    }
		}

		// ������ ��Ŀ�� ǥ���ϴ� �Լ��Դϴ�
		function displayMarker(place) {
		    // ��Ŀ�� �����ϰ� ������ ǥ���մϴ�
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });

		    // ��Ŀ�� Ŭ���̺�Ʈ�� ����մϴ�
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // ��Ŀ�� Ŭ���ϸ� ��Ҹ��� ���������쿡 ǥ��˴ϴ�
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
		
	})//function end
</script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<!-- ���� : http://getbootstrap.com/css/   : container part..... -->
	<div class="container">
	
    <div class="row">
    
        <div class="row">
        
            <div class="col-md-9">
                <h3>���� �ڽ����ǽ�</h3>
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

												<strong>${count+1}�� ${movie.movieNm }</strong>
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
												<h5 class="price-text-color">���� ������: <fmt:formatNumber value="${movie.audiCnt }" pattern="#,###��" /></h5>
												<h5 class="price-text-color">���� ������: <fmt:formatNumber value="${movie.audiAcc }" pattern="#,###��" /></h5>
												<h5>������: ${movie.openDt }</h5>
												

										<div class="clearfix"></div>
									</div>
								</div>
							</div> <!-- ī�� -->
							
					<c:if test="${ (count+1) % 3 == 0}">
            				</div>
						</div> <!-- carousel -->
					</c:if>
            	<c:set var="count" value="${count+1 }"/>
            </c:forEach>
    </div>

	</div>
	<!-- container1 end -->

	<div class="container">
		<div id="map" style="width:500px;height:400px;"></div>
	</div>
	
	<!-- /////////////////footer//////////////// -->
	<jsp:include page="/layout/footer.jsp" />
	<!-- /////////////////////////////////////// -->	
</body>
</html>