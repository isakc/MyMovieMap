<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>�������� ����</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="../common/link.jsp"/>
  	
	<script type="text/javascript" src="../javascript/calendar.js"></script>
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
		$("button[type='button']:contains('����')").on("click", function() {
			$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase").submit();
		});
		
		$("button[type='button']:contains('���')").on("click", function() {
			history.go(-1);
		});
		
		$("input[name='divyDate']").next().on("click", function () {
			show_calendar('document.addPurhase.divyDate', $('input[name=divyDate]').value);
		});
	})
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">
		<form name="updateForm">
		<div class="row">

			<input type="hidden" name="tranNo" value="${purchase.tranNo}"/>
			<input type="hidden" name="userId" value="${user.userId}"/>

				<table class="table table-striped table-bordered">
				
					<tr>
						<td>�����ھ��̵�</td>
						<td>${purchase.buyer.userId }</td>
					</tr>
					
					<tr>
						<td>���Ź��</td>
						<td>
						<select name="paymentOption" maxLength="20">
							<option value="1" ${purchase.paymentOption == 1 ? 'selected' : '' }>���ݱ���</option>
							<option value="2" ${purchase.paymentOption == 2 ? 'selected' : '' }>�ſ뱸��</option>
						</select>
						</td>
					</tr>
					
					<tr>
						<td>�������̸�</td>
						<td>
						<input type="text" name="receiverName" maxLength="20" value="${purchase.buyer.userName }"/>
						</td>
					</tr>
					
					<tr>
						<td>������ ����ó</td>
						<td>
						<input type="text" name="receiverPhone" maxLength="20" value="${purchase.receiverPhone }"/>
						</td>
					</tr>

					<tr>
						<td>�������ּ�</td>
						<td>
							<c:choose>
								<c:when test="${purchase.tranCode > '1'}">
									<input type="text" maxLength="20" value="${purchase.divyAddr }" disabled />
									<input type="hidden" name="receiverAddr" value="${purchase.divyAddr }" />
								</c:when>

								<c:otherwise>
									<input type="text" name="divyAddr" maxLength="20" value="${purchase.divyAddr}"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					
					<tr>
						<td>���ſ�û����</td>
						<td>
							<input type="text" name="divyRequest" maxLength="20" value="${purchase.divyRequest}"/></td>
					</tr>
					
					<tr>
						<td>����������</td>
						<td>
							<input type="text" readonly="readonly" name="divyDate" value="${purchase.divyDate }" maxLength="20"/>
							<img src="../images/ct_icon_date.gif" width="15" height="15"/>
						</td>
					</tr>

				</table>
			</div><!-- row 1 end -->
					
			<div class="row">
				<button type="button" class="btn btn-default">����</button>
				<button type="button" class="btn btn-primary">���</button>
			</div><!-- row 2 end -->
			
			</form>
		</div>
</body>
</html>