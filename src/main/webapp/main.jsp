<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
   	<script type="text/javascript">
   	</script>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!-- ���� : http://getbootstrap.com/css/   : container part..... -->
	<div class="container">
		<h2 class="my-4">Daily Box Office</h2>
		<table id="boxOfficeTable" class="table">
			<thead>
				<tr>
					<th>����</th>
					<th>��ȭ��</th>
					<th>������</th>
					<th>�����</th>
					<th>���ϰ�����</th>
				</tr>
			</thead>
			<tbody id="boxOfficeBody">
			<c:forEach var="movie" items="${list }">
				<tr>
					<td>${movie.rank }</td>
					<td>${movie.movieNm }</td>
					<td>${movie.openDt }</td>
					<td>${movie.salesAmt }</td>
					<td>${movie.audiCnt }</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

</body>

</html>