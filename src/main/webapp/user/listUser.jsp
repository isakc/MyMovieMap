<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
	<title>ȸ�� �����ȸ</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="../common/link.jsp"/>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
  	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
	
	<script type="text/javascript">
	
	function getList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/user/listUser").submit();
	}
	
	$(function() {
		// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
		$("input[name='searchKeyword']").on('input', function() {
			// autocomplete�� ���� �ʱ�ȭ
			$(this).autocomplete({
				source: function(request, response) {
					$.ajax({
						url: "json/listUser",
						method: "POST",
						headers: {
							"Accept": "application/json",
							"Content-Type": "application/json"
						},
						
						data: JSON.stringify({
							searchCondition: $("select[name=searchCondition]").val(),
							searchKeyword: $("input[name=searchKeyword]").val(),
							pageSize: 10
							}),
							
						success: function(data) {
							var uniqueValues = new Set();
							
		                    data.list.forEach(function(item) {
		                        if ($("select[name=searchCondition]").val() == 0) {
		                            uniqueValues.add(item.userId);
		                        } else {
		                            uniqueValues.add(item.userName);
		                        }
		                    });
		                    
		                    response(Array.from(uniqueValues).map(function(value) {
		                        return { 
		                        	label: value,
		                        	value: value 
		                        	};
		                    }));
							}
						});
					},
					
					minLength: 2 // �ּ� �Է� ����
				});
			});
		
		$("button[type='button']:contains('�˻�')").on("click", function() {
			getList(1);
		});
		
		$(".list td:nth-child(2) a").on("click", function () {
			$(this).attr("href", "/user/getUser/" + $(this).text().trim()); 
		})
		
		$(".list td:nth-child(5)").on("click", function() {
			var select = $(this);
			var userId = select.text().trim();
			
			$.ajax({
				url : "json/getUser/" + userId,
				method : "GET",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
					},
				dataType : "json",
				success : function(JSONData , status) {
					console.log(JSONData);
					var displayValue = "<td colspan='5'><h3>"
					+"���̵� : "+JSONData.user.userId+"<br/>"
					+"��  �� : "+JSONData.user.userName+"<br/>"
					+"�̸��� : "+JSONData.user.email+"<br/>"
					+"ROLE : "+JSONData.user.role+"<br/>"
					+"����� : "+JSONData.user.regDate+"<br/>"
					+"</h3>";
					
					$("h3").parent().remove();
					select.parent().next().html(displayValue);
					}
				}); 
			});
		
		})
</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<form>
		
	<div class="container">
		<div class="col text-right">
			<select name="searchCondition" class="float-right">
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? 'selected' : '' }>ȸ��ID</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? 'selected' : '' }>ȸ����</option>
			</select> 
				
			<input type="text" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : ''}" />
			<button type="submit" class="btn btn-success">�˻�</button>
		</div>
	</div>
	
	<div class="container">
		<span>��ü ${resultPage.total }�Ǽ�, ���� ${resultPage.now } ������</span>
		
		<table class="table table-striped table-bordered">
			<thead>
				<tr class="bg-primary text-center">
					<td>No</td>
					<td>ȸ�� ID</td>
					<td>ȸ����</td>
					<td>�̸���</td>
					<td>������</td>
				</tr>
			</thead>
				
			<tbody>
				<c:set var="i" value="0" />
				<c:forEach var="user" items="${list}">
				<c:set var="i" value="${ i+1 }" />
					
				<tr class="text-center list">
					<td>${ i }</td>
					<td><a href="#">${user.userId }</a></td>
					<td>${user.userName}</td>
					<td>${user.email}</td>
					<td>${user.userId }</td>
				</tr>
					
				<tr></tr>
				</c:forEach>
			</tbody>
		</table>
	</div><!-- Container end -->
	
	<div class="container text-center">
		<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.now }"/>
		<jsp:include page="../common/pageNavigator.jsp"/>
	</div><!-- Container end -->
	
	</form>
</body>
</html>