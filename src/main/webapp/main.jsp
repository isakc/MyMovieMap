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

<script type="text/javascript"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<!-- 참조 : http://getbootstrap.com/css/   : container part..... -->
	<div class="container aux">
	
        <div class="row">
        
            <div class="col-md-9">
                <h3>일일 박스오피스</h3>
            </div><!-- col-md-9 -->
            
            <div class="col-md-3">
                <!-- Controls -->
                <div class="controls pull-right hidden-xs">
                    <a class="left fa fa-chevron-left btn btn-primary" href="#carousel-example-generic"
                        data-slide="prev"></a><a class="right fa fa-chevron-right btn btn-primary" href="#carousel-example-generic"
                            data-slide="next"></a>
                </div><!-- controls -->
            </div><!-- col-md-3 -->
        </div><!-- row end -->
        
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
									</div><!-- photo -->
									
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
									</div><!-- info -->
									
								</div><!--col-item -->
							</div> <!-- col-sm-4 -->
							
					<c:if test="${ (count+1) % 3 == 0 or (count+1) == 10}">
            				</div> <!-- row end -->
						</div> <!-- item -->
					</c:if>
            	<c:set var="count" value="${count+1 }"/>
            </c:forEach>
    	</div><!-- carousel-inner -->
	</div><!-- carousel-example-generic -->
	</div>
	
	<!-- footer Start /////////////////////////////////////-->
	<jsp:include page="/layout/footer.jsp" />
	<!-- footer End /////////////////////////////////////-->
</body>
</html>