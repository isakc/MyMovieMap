<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<title>MEET PLAY SHARE</title>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<c:import url="/common/link.jsp"/>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
        
        strong{
        	font-size: 25px;
        }
        
        .topContainer{
        	padding-top: 35px;
        }
        
   	</style>
   	
   	<script type="text/javascript">
   		$(function () {
   			
		})
		
		$(function () {
			
			$.ajax({
				url: "/openAPI/getMovie",
				type: "POST",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json"
				},
				data: JSON.stringify(data),
				success: function(data){
					$("#currentPage").val(data.resultPage.now);
					var productList = data.list; // 받아온 상품 목록 데이터
				    var container = $(".col-md-11"); // 상품 목록을 추가할 컨테이너 요소 선택
				    
				    productList.forEach(function(product) {
				    	var card =
				            "<div class='col-md-4'>"
				           +"<a href=/product/getProduct/"+product.prodNo+"/search class=product-link data-prod-no="+product.prodNo+">"
				                +"<div class='card text-center fixed-height'>"
				                    +"<img src='/images/uploadFiles/"+product.fileNames[0] +"'class=card-img-top/>"
				                    +"<div class='card-body'>"
				                        +"<h5 class='card-title'>"+product.prodName+"</h5>"
				                        +"<p class='card-text'>"+product.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"원</p>"
				                        +"<p class='card-text'>"+product.quantity+" 개 남음</p>"
				                    +"</div></div></a></div>";
				        container.append(card); // 컨테이너에 상품 카드 추가
				    });
				}
			});
			
		})
   		
   	</script>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!-- 참조 : http://getbootstrap.com/css/   : container part..... -->
	<div class="container topContainer">
	<div class="row">
		<div class="col-md-6">
		
			<div class="card mb-3">
			
			<div class="row g-0">
				<div class="col-md-7">
					<img src="${list[0].posterPath }" class="img-fluid rounded-start" alt="..." style="width:289px; height:410px;">
				</div>
				
				<div class="col-md-5">
					<div class="card-body">
						<strong class="card-title">${list[0].movieNm }</strong>
						<p class="card-text">개봉일: ${list[0].openDt }</p>
						<p class="card-text"></p>
					</div>
				</div>
			</div>
		</div>
		
		</div>
		
		<div class="col-md-6">
			<table class="table">
			<thead>
				<tr>
					<th></th>
					<th>영화명</th>
					<th>매출액</th>
					<th>관객수</th>
					<th>증감율</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="movie" items="${list }">
					<tr data-movieCd=${movie.movieCd }>
						<td>${movie.rank }</td>
						<td>${movie.movieNm }</td>
						<td><fmt:formatNumber value="${movie.salesAmt }"
								pattern="#,###원" />
						<td><fmt:formatNumber value="${movie.audiCnt }"
								pattern="#,###명" />
						<td><c:choose>
								<c:when test="${movie.rankInten > 0}">
									<i class="fas fa-arrow-up" style="color: red;"></i>
									<span>${movie.rankInten }</span>
								</c:when>

								<c:when test="${movie.rankInten == 0 }">
									<c:choose>
										<c:when test="${movie.rankOldAndNew == 'NEW' }">
											<span style="color: orange;">NEW</span>
										</c:when>

										<c:otherwise>
											<i class="fas fa-minus"></i>
										</c:otherwise>
									</c:choose>
								</c:when>

								<c:otherwise>
									<i class="fas fa-arrow-down" style="color: blue;"></i>
									<span>${fn:replace(movie.rankInten, '-' , '') }</span>
								</c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
		
	</div><!-- container1 end -->
	
</body>
</html>