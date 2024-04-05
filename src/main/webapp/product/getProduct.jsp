<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>
	<title>��ǰ������ȸ</title>

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
        
        .sm-input{
        	width: 50px;
        }
        
        input[name='quantity']{
        	height:47px;
        	font-weight: bold;
        	font-size: 20px
        }
        
        img{
        	max-width: 100%;
        	height: auto;
        }
        
        .product-image {
      		transition: transform 0.3s ease;
    	}
    	
    	.product-image:hover {
      		transform: scale(1.2);
      		border:1px solid blue;
			box-shadow: 0 12px 15px 0 rgba(0, 0, 0, 0.24),
			0 17px 50px 0 rgba(0, 0, 0, 0.19);
    	}
   	</style>

	<script type="text/javascript">
	function changeQuantity(type) {

		var quantity = $("input[name='quantity']");
		var number = quantity.val();
		var maxQuantity = $('input[name="maxQuantity"]').val();

		if (type === 'plus') {
			if (maxQuantity > number) {
				number = parseInt(number) + 1;
				quantity.val(number);
			} else {
				alert("�ִ���� �ʰ�");
			}
		} else {
			if (number > 1) {
				number = parseInt(number) - 1;
				quantity.val(number);
			} else {
				alert("1���� �۾��� ���� �����ϴ�");
			}
		}
	}
	
	$(function () {
		$(".glyphicon-chevron-down").on("click", function () {
			changeQuantity('minus');
		});
		
		$(".glyphicon-chevron-up").on("click", function () {
			changeQuantity('plus');
		});
		
		$("button[type='button']:contains('�ٷα���')").on("click", function() {
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchaseView").submit();
		});
		
		$("button[type='button']:contains('��ٱ��� ���')").on("click", function() {
			var quantity = $("input[name='quantity']").val();
			var prodNo = $("input[name='prodNo']").val();
			
			var jsonData = {
					"product": {
						"prodNo": prodNo,
				    },
				    "quantity": quantity
			};
			
			$.ajax({
				url : "/cart/json/addCart",
				method : "POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
					},
				data: JSON.stringify(jsonData),
				dataType : "json",
				success : function(JSONData , status) {
					alert("��ٱ��� ��� ����");
				}
			}); 
		});
		
		$(".product-image").on("mouseover", function () {
			$("#mainImage").attr("src", $(this).attr("src"));
		})
	})
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<div class="container">
		<form>
			<input type="hidden" name="prodNo" id="prodNo" value="${product.prodNo }" />
			<input type="hidden" name="maxQuantity" value="${product.quantity }" />
			<input type="hidden" name="cartNo" />
			
			<div class="container mt-5">
  				<div class="row">
  					 <div class="col-md-2">
  					 	<ul class="list-group">
  					 		<c:forEach var="fileName" items="${product.fileNames }">
  					 		
						 	<li class="list-group-item">
						 		<img src = "/images/uploadFiles/${fileName }" alt="${product.prodName} ��ǰ �̹���" class="img-fluid product-image"/>
						 	</li>
						 	
  					 		</c:forEach>
						</ul>
    					
    				</div><!-- ���� div -->
    				
    				<div class="col-md-4">
    					<img src ="/images/uploadFiles/${product.fileNames[0] }" alt="${product.prodName} ��ǰ �̹���" class="img-fluid" id="mainImage" />
    				</div><!-- ���� div -->
    				
    				<div class="col-md-6">
      					<h2 class="mb-4">${product.prodName }</h2>
      					<p class="text-muted mb-4">${product.prodDetail }</p>
      					<p class="lead font-weight-bold"><fmt:formatNumber value="${product.price}" type="currency" pattern="#,##0��" /></p>
      					
      					<c:if test="${user != null }">
      						<div class="row">
      							<div class="col-md-3">
      							
      								<div class="row">
      									<div class="col-md-7" style="padding:0;">
	        								<input type="text" name="quantity" class="form-control text-center" min="1" value="1">
      									</div>
      								
      									<div class="col-md-5" style="padding:0">
      										<button type="button" class="btn btn-sm"><span class="glyphicon glyphicon-chevron-up"></span></button>
        									<button type="button" class="btn btn-sm"><span class="glyphicon glyphicon-chevron-down"></span></button>
      									</div>
      								</div>
      							</div>
      						
      							<c:if test="${product.quantity != 0 }">
      							<div class="col-md-3">
      								<button type="button" class="btn btn-default">��ٱ��� ���</button>
      							</div>
      						
      							<div class="col-md-2">
      								<button type="button" class="btn btn-primary">�ٷα���<span class="glyphicon glyphicon-chevron-right"></span></button>
      							</div>
      							</c:if>
      						</div><!-- ��ø �׸��� -->
      					</c:if>
      					
    				</div><!-- ���� div -->
  				</div><!-- �׸��� row -->
			</div>
		</form>
	</div>
</body>
</html>