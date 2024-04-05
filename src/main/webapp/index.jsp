<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <c:if test="${ ! empty user }">
 	<jsp:forward page="main.jsp"/>
 </c:if>
 
<html>
<head>
	<title>MEET PLAY SHARE</title>
	<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="/common/link.jsp"/>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
	
	<script type="text/javascript">
		//============= ȸ�������� ȭ���̵� =============
		$( function() {
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#' ]:contains('ȸ������')").on("click" , function() {
				self.location = "/user/addUser"
			});
			
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#' ]:contains('�� �� ��')").on("click" , function() {
				self.location = "/user/login"
			});
			
			$("a[href='#' ]:contains('��ǰ�˻�')").on("click" , function() {
				self.location = "/product/listProduct/search"
			});
		});
		
	</script>
	
	<title>Model2 MVC Shop</title>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar navbar-default">
		
        <div class="container">
        
        	<a class="navbar-brand" href="#">Model2 MVC Shop</a>
			
			<!-- toolBar Button Start //////////////////////// -->
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </button>
			</div>
			<!-- toolBar Button End //////////////////////// -->
			
			<div class="collapse navbar-collapse"  id="target">
	             <ul class="nav navbar-nav navbar-right">
	                 <li><a href="#">ȸ������</a></li>
	                 <li><a href="#">�� �� ��</a></li>
	           	</ul>
	       </div>
   		
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- �ٴܷ��̾ƿ�  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu ���� Start /////////////////////////////////////-->     	
			<div class="col-md-3">
		        
		       	<!--  ȸ������ ��Ͽ� ���� -->
				<div class="panel panel-primary">
				
					<div class="panel-heading">
						<span class="glyphicon glyphicon-heart"></span>
						ȸ������
         			</div>
         			
         			<!--  ȸ������ ������ -->
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">����������ȸ</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">ȸ��������ȸ</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
					</ul>
		        </div>
               
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<span class="glyphicon glyphicon-briefcase"></span> �ǸŻ�ǰ����
         			</div>
         			
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">�ǸŻ�ǰ���</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">�ǸŻ�ǰ����</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
					</ul>
					
		        </div>
               
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<span class="glyphicon glyphicon-shopping-cart"></span> ��ǰ����
	    			</div>
	    			
					<ul class="list-group">
						 <li class="list-group-item"><a href="#">��ǰ�˻�</a></li>
						  <li class="list-group-item">
						  	<a href="#">�����̷���ȸ</a> <span class="glyphicon glyphicon-ban-circle"></span>
						  </li>
					</ul>
				</div>
				
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<i class="fas fa-box"></i> ��ٱ���
	    			</div>
	    			
					<ul class="list-group">
						  <li class="list-group-item">
						  	<a href="#">��ٱ���</a> <span class="glyphicon glyphicon-ban-circle"></span>
						  </li>
					</ul>
				</div>
				
			</div>
			<!--  Menu ���� end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-9">
				<div class="jumbotron">
			  		<h1>Model2 MVC Shop</h1>
			  		<p>�α��� �� ��밡��...</p>
			  		<p>�α��� �� �˻��� �����մϴ�.</p>
			  		<p>ȸ������ �ϼ���.</p>
			  		
			  		<div class="text-center">
			  			<a class="btn btn-info btn-lg" href="#" role="button">ȸ������</a>
			  			<a class="btn btn-info btn-lg" href="#" role="button">�� �� ��</a>
			  		</div>
			  	
			  	</div>
	        </div>
	   	 	<!--  Main end /////////////////////////////////////-->   		
	 	 	
		</div>
		<!-- �ٴܷ��̾ƿ�(row) end /////////////////////////////////////-->
		
	</div>
	<!--  ȭ�鱸��(container div) end /////////////////////////////////////-->
	
</body>

</html>