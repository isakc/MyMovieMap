<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>ī�װ��߰�</title>

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
		$("button[type='button']:contains('���')").on("click",function() {
			$("form").attr("method", "POST").attr("action","/category/addCategory").submit();
		})
	})

	$(function() {
		$("button[type='button']:contains('���')").on("click", function() {
			$("form")[0].reset();
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
			<table class="table table-striped table-bordered">
				<tr>
					<td>ī�װ���</td>
					<td>
						<input type="text" name="categoryName"/>
					</td>
				</tr>
				
				<tr>
					<td>���� ī�װ�</td>
					<td>
						<select name="parentCategoryNo">
							<option value="0">���� ī�װ�</option>
							<c:forEach var="category" items="${categoryList }">
								<c:if test="${category.parentCategoryNo == 0 }">
									<option value="${category.categoryNo}">${category.categoryName }</option>
								</c:if>
							</c:forEach>
						</select>
						
					</td>
				</tr>
			</table>
			
			<div class="container">
				<button type="button" class="btn btn-default">���</button>
				<button type="button" class="btn btn-primary">���</button>			
			</div>
		</form>
	</div>
</body>
</html>