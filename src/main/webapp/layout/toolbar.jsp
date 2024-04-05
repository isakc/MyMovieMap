<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
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
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  ȸ������ DrowDown -->
	              <c:if test="${user != null }">
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >ȸ������</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">����������ȸ</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">ȸ��������ȸ</a></li>
	                         </c:if>
	                     </ul>
	                 </li>
	               </c:if>
	              <!-- �ǸŻ�ǰ���� DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >�ǸŻ�ǰ</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�ǸŻ�ǰ���</a></li>
		                         <li><a href="#">�ǸŻ�ǰ����</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- ���Ű��� DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >��ǰ����</span>
	                         <span class="caret"></span>
	                     </a>
	                     
	                     <ul class="dropdown-menu">
	                         <li><a href="#">�� ǰ �� ��</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">�����̷���ȸ</a></li>
	                         </c:if>
	                         
	                     </ul>
	                 </li>
	                 
	                 <c:if test="${sessionScope.user.role == 'user'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >��ٱ���</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">��ٱ��� ���</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	                 <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >ī�װ�</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">ī�װ����</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	             </ul>
	             
	             <c:choose>
	             	<c:when test="${user != null }">
	             		<ul class="nav navbar-nav navbar-right">
	                		<li><a href="#">�α׾ƿ�</a></li>
	           	 		</ul>
	           	 	
	             	</c:when>
	             	
	             	<c:otherwise>
	             		<ul class="nav navbar-nav navbar-right">
	                		<li><a href="#">ȸ������</a></li>
	                		<li><a href="#">�α���</a></li>
	                	</ul>
	             	</c:otherwise>
	             </c:choose>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	<script type="text/javascript">
	
		//============= logout Event  ó�� =============	
		 $(function() {
		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
			}); 
		 });
		
		 $(function() {
			 $("a:contains('�α���')").on("click" , function() {
				$(self.location).attr("href","/user/login");
			}); 
		});
		 
		 $(function() {
			 $("a:contains('ȸ������')").on("click" , function() {
				$(self.location).attr("href","/user/addUser");
			}); 
		});
		
		//============= ȸ��������ȸ Event  ó�� =============	
		 $(function() {
		 	$("a:contains('ȸ��������ȸ')").on("click" , function() {
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  ����������ȸȸ Event  ó�� =============	
	 	$( "a:contains('����������ȸ')" ).on("click" , function() {
			$(self.location).attr("href","/user/getUser/${user.userId}");
		});
		
	 	$( "a:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
			$(self.location).attr("href","/product/addProduct");
		});
	 	
	 	$( "a:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
			$(self.location).attr("href","/product/listProduct/manage");
		});
	 	
	 	<!-- ���� -->
	 	
	 	$( "a:contains('�� ǰ �� ��')" ).on("click" , function() {
			$(self.location).attr("href","/product/listProduct/search");
		});
	 	
	 	$( "a:contains('�����̷���ȸ')" ).on("click" , function() {
			$(self.location).attr("href","/purchase/listPurchase");
		});
	 	
	 	$( "a:contains('ī�װ����')" ).on("click" , function() {
			$(self.location).attr("href","/category/addCategory");
		});
	 	
	 	$( "a:contains('��ٱ��� ���')" ).on("click" , function() {
			$(self.location).attr("href","/cart/listCart");
		});
	</script>  