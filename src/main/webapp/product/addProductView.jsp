<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>��ǰ���</title>

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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        img{ 	
   	 		width: 33%;
   	 		height: auto;
        }
        
        .fa-image, .fa-calendar-alt:hover{
        	cursor: pointer;
        }
   	</style>

	<script type="text/javascript">

	function fncAddProduct() {
		var name = $("input[name='prodName']").val();
		var detail = $("textarea[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();

		if (name == null || name.length < 1) {
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (detail == null || detail.length < 1) {
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (manuDate == null || manuDate.length < 1) {
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (price == null || price.length < 1) {
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		$("form").attr("method", "POST").attr("action", "/product/addProduct").attr("enctype", "multipart/form-data").submit();
	}
	
	function setImageFromFile(input) {
		
	    if (input.files) {
	    	
	    	for(let i=0; i<input.files.length; i++){
	    		
	    		var reader = new FileReader();
	    		
		        reader.onload = function (e) {
		        	let img = $("<img />");
		            $(img).attr('src', e.target.result);
	                $('#preview').append(img);
		        }
		        
		        reader.readAsDataURL(input.files[i]);
	    	}
	    }
	}

	$(function() {
		$("button[type='button']:contains('���')").on("click", function() {
			fncAddProduct();
		});
		
		$("button[type='button']:contains('����')").on("click", function() {
			$("form")[0].reset();
			$("#preview").empty();
		});
		
		$(".fa-calendar-alt").on("click",function() {
			show_calendar('document.detailForm.manuDate',$('input[name=manuDate]').value);
		});
		
		$("input[name='uploads']").change(function() {
			$("#preview").empty();
		    setImageFromFile(this);
		});
	});
	
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">
    	<h1 class="text-center">��ǰ������ �Է����ּ���</h1>
			<div class="row">
                <div class="col-sm-6 col-sm-offset-3">
				<form name="detailForm" class="form-horizontal">
				
                	<div class="form-group">
                		<div class="input-group">
                    		<span class="input-group-addon"><i class="fas fa-tag"></i></span>
                    		<input type="text" name="prodName" maxLength="20" placeholder="��ǰ��" class="form-control input-lg"/>
    					</div>
                    </div>
                    
                    <div class="form-group">
                		<div class="input-group">
                    		<span class="input-group-addon"><i class="fas fa-info-circle"></i></span>
                    		<textarea class="form-control input-lg" rows="3" name="prodDetail" placeholder="������"></textarea>
    					</div>
                    </div>
                    
                    <div class="form-group">
                		<div class="input-group">
                    		<span class="input-group-addon"><i class="far fa-calendar-alt"></i></span>
                    		<input type="text" name="manuDate" readonly="readonly" maxLength="10" minLength="6" placeholder="���� ����" class="form-control input-lg"/>
    					</div>
                    </div>
                    
                    <div class="form-group row">
                    	<div class="col-sm-6" style="padding-left:0;">
                			<div class="input-group">
                    			<span class="input-group-addon"><i class="fas fa-money-bill-alt"></i></span>
                    			<input type="text" name="price" maxLength="10" placeholder="����" class="form-control input-lg">
    						</div>
                    	</div>
                    
                    	<div class="col-sm-6">
                			<div class="input-group">
                    			<span class="input-group-addon"><i class="fas fa-warehouse"></i></span>
                    			<input type="text" name="quantity" maxLength="13" placeholder="����" class="form-control input-lg"/>
    						</div>
                    	</div>
                    </div>
                    
                    <div class="form-group">
                    	<select name="categoryNo" class="form-control input-lg">
							<option value="" selected disabled hidden>��ǰ ī�װ� ����</option>
								<c:forEach var="category" items="${categoryList}">
									<c:choose>
										<c:when test="${category.parentCategoryNo == 0 }">
											<optgroup label="${category.categoryName }">
										</c:when>

										<c:otherwise>
											<option align="center" value="${category.categoryNo}">${category.categoryName }</option>
										</c:otherwise>
									</c:choose>
									</optgroup>
								</c:forEach>
						</select>
                    </div>
                    
                    <div class="form-group">
                    	<div class="col-sm-7">
                			<div class="input-group">
                				<label>
                					<i class="fas fa-image" style="font-size: 90px;"></i>
                          			<input type="file" multiple="multiple" name="uploads" accept="image/*" style="display:none"/>
                      			</label>
                			</div>
    					</div>
                    </div>
                    
                    <div class="form-group" id="preview"></div>
                    
				</form>
                </div><!-- col-sm-6 -->
			</div><!-- row end -->
			
		<div class="container text-center">
			<button type="button" class="btn btn-primary">���</button>
			<button type="button" class="btn btn-default">����</button>
		</div>
	</div>
	
</body>
</html>