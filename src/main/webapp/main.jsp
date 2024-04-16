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
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
<style>
body {
	padding-top: 70px;
}

strong {
	font-size: 25px;
}

.topContainer {
	padding-top: 35px;
}
</style>

<script type="text/javascript">
	$(function() {

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
										<img src="${movie.posterPath }" class="img-responsive" alt="a" />
									</div>
									<div class="info">

												<strong>${count+1}위 ${movie.movieNm }</strong>
											<c:choose>
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

		<%--<table class="table">
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
		</table> --%>

	</div>
	<!-- container1 end -->

</body>
</html>