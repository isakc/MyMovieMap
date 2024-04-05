<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="ko">

<head>
	<title>��ǰ �����ȸ</title>

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
        
        .card:hover {
        box-shadow: 0 0 10px rgba(0,0,0,0.3);
        transform: translateY(-5px);
   	 	}
   	 	
   	 	.card {
    		height: 335px;
    		margin-top: 25px;
    		border-bottom: 3px solid #424242;
  		}
  		
 		 .card img {
    		object-fit: cover;
    		max-width: 70%;
    		height: 70%;
  		}
  		
  		.horizontal-list-group {
        	display: flex;
        	flex-direction: row;
        	padding-left: 0;
       	 	margin-bottom: 0;
        	list-style: none;
    	}

    	.horizontal-list-group .list-group-item {
        	margin-bottom: 80;
		}
		
		.horizontal-list-group .list-group-item:hover {
        	cursor: pointer;
        	color: blue;
		}
   	</style>

	<script type="text/javascript">
	
	function getList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
	}
	
	$(function () {
		$(".product-link").on("click", function() {
			var prodNo = $(this).data("prod-no");
			$(this).attr("href", "/product/getProduct/"+prodNo+"/${menu}");
		});
		
		$("tbody td:nth-child(6):contains('�ǸŸ��')").on("click", function() {
			var prodNo = $(this).data("prod-no");
			$(this).find("a").attr("href", "/purchase/getOrderDetail/"+prodNo);
		});
		
		$(".horizontal-list-group li:nth-child(1)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('priceASC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$(".horizontal-list-group li:nth-child(2)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('priceDESC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$(".horizontal-list-group li:nth-child(3)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('reg_dateDESC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$(".horizontal-list-group li:nth-child(4)").on("click", function () {
			self.location = "/product/listProduct/${menu}";
		});
		
		$("select[name=categoryNo]").on("change", function () {
			$("#currentPage").val(1);
			$('input[name="searchCondition"]').val("");
			$('input[name="searchKeyword"]').val("");

			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$("button[type='submit']:contains('�˻�')").on("click", function () {
			$("#currentPage").val(1);
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$("select[name=searchCondition]").on("change", function() {
			var searchCondition = $('select[name=searchCondition]');
			var searchKeyword = $('input[name=searchKeyword]');
			var selectedValue = searchCondition.val();

			if (selectedValue == '2') {
				searchKeyword.val(0);
				searchKeyword.after('<input name="searchKeyword2"/>');
			} else {
				searchKeyword.val("");
				$("input[name=searchKeyword2]").remove();
			}
		});
		
		//������ �������� �Լ�
		function getData(){
			//����������
			var data = {
					searchCondition: $("select[name=searchCondition]").val(),
					searchKeyword: $("input[name=searchKeyword]").val(),
					searchKeyword2: $("input[name=searchKeyword2]").val(),
					sorter: $("input[name=sorter]").val(),
					currentPage: parseInt($("input[name=currentPage]").val())+1,
					pageSize: 6,
					category: {categoryNo: $("select[name=categoryNo]").val()}
			}
			
			$.ajax({
				url: "/product/json/listProduct/search",
				type: "POST",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json"
				},
				data: JSON.stringify(data),
				success: function(data){
					$("#currentPage").val(data.resultPage.now);
					var productList = data.list; // �޾ƿ� ��ǰ ��� ������
				    var container = $(".col-md-11"); // ��ǰ ����� �߰��� �����̳� ��� ����
				    
				    productList.forEach(function(product) {
				    	var card =
				            "<div class='col-md-4'>"
				           +"<a href=/product/getProduct/"+product.prodNo+"/search class=product-link data-prod-no="+product.prodNo+">"
				                +"<div class='card text-center fixed-height'>"
				                    +"<img src='/images/uploadFiles/"+product.fileNames[0] +"'class=card-img-top/>"
				                    +"<div class='card-body'>"
				                        +"<h5 class='card-title'>"+product.prodName+"</h5>"
				                        +"<p class='card-text'>"+product.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"��</p>"
				                        +"<p class='card-text'>"+product.quantity+" �� ����</p>"
				                    +"</div></div></a></div>";
				        container.append(card); // �����̳ʿ� ��ǰ ī�� �߰�
				    });
				}
			});
		}

		 let lastScroll = 0; //���� ��ũ�� ��ġ ����
		
		$(document).scroll(function(e){
		    var currentScroll = $(this).scrollTop(); //�������
		    var documentHeight = $(document).height();//��ü ������ ����
		    
		    var nowHeight = $(this).scrollTop() + $(window).height();//(���� ȭ���� + ���� ȭ�� ����)
		    
		    if(currentScroll > lastScroll){//��ũ���� �Ʒ��� ������������ �ش� �̺�Ʈ ����.

		        //nowHeight�� ���� ���� ȭ���� ���� ������ �����Դ��� �ľǰ��� 
		        //�� ��ü ������ ���̿� ������ ���������� �� �� �ҷ�����)
		        if(documentHeight < (nowHeight + (documentHeight*0.1))){
		        	//�Լ���
		        	if(${resultPage.totalPage} > $("#currentPage").val()){
						getData();
		        	}
		        }
		    }

		    //������ġ �ֽ�ȭ
		    lastScroll = currentScroll;
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
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<select name="categoryNo" class="form-control">
							<option value="-1" style="font-weight: 700">��ü</option>

							<c:forEach var="category" items="${categoryList}">
								<c:choose>
									<c:when test="${category.parentCategoryNo == 0 }">
										<option value="${category.categoryNo}"
											${category.categoryNo == search.category.categoryNo ? 'selected' : ''}
											style="font-weight: 700">${category.categoryName }</option>
									</c:when>

									<c:otherwise>
										<option align="center" value="${category.categoryNo}"
											${category.categoryNo == search.category.categoryNo ? 'selected' : ''}>${category.categoryName }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<ul class="list-group horizontal-list-group">
						<li class="list-group-item">���� ���ݼ�</li>
						<li class="list-group-item">���� ���ݼ�</li>
						<li class="list-group-item">�ֽż�</li>
						<li class="list-group-item">�ʱ�ȭ</li>
					</ul>
				</div>
			
			<div class="col-md-6 text-right">
				<select id="searchCondition" name="searchCondition">
					<option value="" selected disabled hidden>����</option>
					<c:if test="${user.role == 'admin' && user!=null}">
						<option value="0" ${search.searchCondition == '0' ? 'selected' : ''}>��ǰ��ȣ</option>
					</c:if>
					<option value="1" ${search.searchCondition == '1' ? 'selected' : ''}>��ǰ��</option>
					<option value="2" ${search.searchCondition == '2' ? 'selected' : ''}>��ǰ����</option>
				</select>

				<c:choose>
					<c:when test="${search.searchCondition == '2' }">
						<input type="text" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword }" />
						<input type="text" name="searchKeyword2" value="${search.searchKeyword2 }" />
					</c:when>

					<c:otherwise>
						<input type="text" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword }" />
					</c:otherwise>
				</c:choose>

				<button type="submit" class="btn btn-success">�˻�</button>
			</div>
			</div><!-- row -->
		</div><!-- ������ �ڽ� -->
		
		<c:choose>
			<c:when test="${menu == 'search' }">
				<div class="container">
    				<div class="row">
    					<div class="col-md-11">
    					
       		 			<c:forEach var="product" items="${list}">
            				<div class="col-md-4">
                				<a href="" data-prod-no="${product.prodNo }" class="product-link">
                				<div class="card text-center fixed-height">
                   		 			<img src="/images/uploadFiles/${product.fileNames[0]}" class="card-img-top"/>
                    					<div class="card-body">
                        					<h5 class="card-title">${product.prodName}</h5>
                        					<p class="card-text"><fmt:formatNumber value="${product.price}" pattern="#,##0��" /></p>
                        					<p class="card-text">${product.quantity} �� ����</p>
                    					</div>
                				</div>
                    			</a>
            				</div>
       		 			</c:forEach>
       		 			</div>
       		 			
       		 			<div class="col-md-1">
       		 			<!-- �ֱ� �� ��ǰ ����� ǥ���� ���̵�� �Ǵ� Ǫ�� ���� -->
							<div class="container">
								<div class="row">
									<div class="col-md-3">
									<!-- �ֱ� �� ��ǰ ��� ���� -->
									<h4>�ֱ� �� ��ǰ</h4>
									<ul class="list-group">
									<!-- �ֱ� �� ��ǰ ��� -->
										<c:forEach var="recentProduct" items="${history}">
										<li class="list-group-item">
											<a href="/product/getProduct/${recentProduct.prodNo}/${menu}">
												<img src="/images/uploadFiles/${recentProduct.fileNames[0]}" alt="${recentProduct.prodName}" style="max-width: 50px; max-height: 50px;">
												${recentProduct.prodName}
                        					</a>
                    					</li>
                    					</c:forEach>
                    				</ul>
                    				</div>
                    			</div>
                    		</div>
       		 			</div>
       		 			
    				</div><!-- row end -->
				</div><!-- list Container container end -->
			
			</c:when>
				
			<c:otherwise>
			<div class="container">
				<table class="table table-striped table-bordered list text-center d-flex align-items-center">
							<thead>
								<tr>
									<td>No</td>
									<td>�̹���</td>
									<td>��ǰ��</td>
									<td>����</td>
									<td>ī�װ�</td>

									<c:choose>
										<c:when test="${menu == 'manage' }">
											<td>�����Ȳ</td>
										</c:when>

										<c:otherwise>
											<td>���� ����</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</thead>

							<tbody>
								<c:set var="i" value="0" />
								<c:forEach var="product" items="${list }">
									<c:set var="i" value="${i+1 }" />
									<tr>
										<td>${i }</td>
										<td>
											<c:choose>
												<c:when test="${not empty product.fileNames}">
													<img src="/images/uploadFiles/${product.fileNames[0] }" style="width:100px;"/>
												</c:when>
												
												<c:otherwise>
													������ ����
												</c:otherwise>
											</c:choose>
											
										</td>
										<td><a href="" class="product-link" data-prod-no="${product.prodNo }">${product.prodName }</a></td>
										<td><fmt:formatNumber value="${product.price}" pattern="#,##0��" /></td>
										<td>${product.category.categoryName }</td>
										<td data-prod-no="${product.prodNo }">
											<c:choose>
												<c:when test="${menu == 'manage' }">
													<a href="">�ǸŸ��</a>
												</c:when>
												
												<c:otherwise>
													${product.quantity } ��
												</c:otherwise>
											</c:choose>
										</td>
									</tr>

								</c:forEach>
								
							</tbody>
						</table>
						</div><!-- manage Container end -->
			</c:otherwise>
		</c:choose>
		
			<!-- ������ Navigator -->
			
		<div class="container">
			<div class="text-center">
				<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.now }" />
				<input type="hidden" id="sorter" name="sorter" value="${search.sorter }" />
				<c:if test="${menu == 'manage' }">
					<jsp:include page="../common/pageNavigator.jsp"/>
				</c:if>
			</div>
			
		</div>
		<!--  ������ Navigator �� -->
	</form>
</body>
</html>