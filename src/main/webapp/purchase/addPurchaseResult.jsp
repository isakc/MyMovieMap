<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>��ǰ���ſϷ� ������</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="../common/link.jsp"/>
  	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
  	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>

	<script type="text/javascript">
		$(function () {
			$("button[type='button']:contains('���ų���')").on("click", function () {
				self.location = "/purchase/listPurchase";
			})
			
			$("button[type='button']:contains('��� �ѷ�����')").on("click", function () {
				self.location = "/product/listProduct/search";
			})
		})
	</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<div class="row">
			<h1 class="text-info">������ ���� ���Ű� �Ǿ����ϴ�.</h1>
		</div>

		<div class="row">
			<table class="table table-striped table-bordered">
				<tr>
					<td>�����ھ��̵�</td>
					<td>${purchase.buyer.userId }</td>
				</tr>

				<tr>
					<td>���Ź��</td>
					<td>
					<c:choose>
					<c:when test="${purchase.paymentOption == 1 }">
						���ݱ���
					</c:when>
					
					<c:otherwise>
					�ſ뱸��
					</c:otherwise>
					</c:choose>
					</td>
				</tr>

				<tr>
					<td>�������̸�</td>
					<td>${purchase.receiverName }</td>
				</tr>

				<tr>
					<td>�����ڿ���ó</td>
					<td>${purchase.receiverPhone }</td>
				</tr>

				<tr>
					<td>�������ּ�</td>
					<td>${purchase.divyAddr }</td>
				</tr>

				<tr>
					<td>���ſ�û����</td>
					<td>${purchase.divyRequest }</td>
				</tr>

				<tr>
					<td>����������</td>
					<td>${purchase.divyDate }</td>
				</tr>
			</table>
		</div><!-- row 1 end -->
		
		<div class="row">
			<button type="button" class="btn btn-default">���ų���</button>
			<button type="button" class="btn btn-primary">��� �ѷ�����</button>
		</div>
	</div>
</body>
</html>