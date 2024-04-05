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

	$(function() {
		$("button[type='button']:contains('����')").on("click", function () {
			self.location = "/purchase/updatePurchase/" + $(this).data("tran-no");
		})
		
		$("button[type='button']:contains('Ȯ��')").on("click", function() {
			history.go(-1);
		})
		
		$("td:contains('��ǰ��')").next().find("a").on("click", function () {
			$(this).attr("href", "/product/getProduct/" +$(this).data("prod-no") +"/search");
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
			<table class="table table-striped table-bordered">
			
				<c:forEach var="orderDetail" items="${list }">

					<tr>
						<td>��ǰ��</td>
						<td>
							<a href="" data-prod-no=${orderDetail.product.prodNo }>${orderDetail.product.prodName }</a> 
						</td>
					</tr>

					<tr>
						<td>����</td>
						<td>${orderDetail.quantity } ��</td>
					</tr>

					<tr>
						<td style="border-bottom: 2px dotted #424242" colspan="3"></td>
					</tr>

				</c:forEach>
				
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
					<td>��������</td>
					<td>${purchase.divyDate }</td>
				</tr>

				<tr>
					<td>�ֹ���</td>
					<td>${purchase.orderDate }</td>
				</tr>

			</table>
		</div><!-- row 1 end -->
	
		<div class="row">
			<button type="button" class="btn btn-default" data-tran-no="${purchase.tranNo}">����</button>
			<button type="button" class="btn btn-primary">Ȯ��</button>
		</div><!-- row 2 end -->
	</div><!-- Container -->

</body>
</html>