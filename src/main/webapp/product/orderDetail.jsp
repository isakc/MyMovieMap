<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="ko">

<head>
	<title>ȸ��������ȸ</title>

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
		
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<div class="container">
		<table class="table table-striped table-bordered list">
			<tr>
				<td>ȸ��ID</td>
				<td>ȸ����</td>
				<td>��ȭ��ȣ</td>
				<td>�����Ȳ</td>
				<td>�ּ�</td>
				<td>����</td>
			</tr>

			<c:set var="index" value="-1" />
			<c:forEach var="orderDetail" items="${list }">
				<c:set var="index" value="${index+1 }" />

				<tr>
					<td>
						<a href="/user/getUser/${orderDetail.transaction.buyer.userId }">${orderDetail.transaction.buyer.userId }</a>
					</td>
					<td>${orderDetail.transaction.receiverName }</td>
					<td>${orderDetail.transaction.receiverPhone }</td>
					<td>${statusList[index] }
						<c:if test="${orderDetail.transaction.tranCode < 2 }">
							<a href="/purchase/updateTranCode/${orderDetail.transaction.tranNo }/2">����ϱ�</a>
						</c:if>
					<td>${orderDetail.transaction.divyAddr }</td>
					<td>${orderDetail.quantity }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>