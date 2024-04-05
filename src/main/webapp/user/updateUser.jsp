<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="ko">
<head>
	<title>ȸ�� ���� ����</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="../common/link.jsp"/>
  	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
  	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  	<script src="/javascript/getAddress.js"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group > div{
        	padding: 0px;
        }
   	</style>

	<script type="text/javascript">
	
	function fncUpdateUser() {
		// Form ��ȿ�� ����
		//var name=document.detailForm.userName.value;
		var name = $("input[name='userName']").val();

		if (name == null || name.length < 1) {
			alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		var value = "";
		if ($("input[name='phone2']").val() != ""
				&& $("input[name='phone3']").val() != "") {
			var value = $("select[name='phone1']").val() + "-"
					+ $("input[name='phone2']").val() + "-"
					+ $("input[name='phone3']").val();
		}
		
		$("input:hidden[name='phone']").val(value);
		
		var addrValue = $("input[name='addr1']").val() + "/"
		+ $("input[name='addr2']").val() + "/"
		+ $("input[name='addr3']").val();

		$("input:hidden[name='addr']").val(addrValue);

		$("form").attr("method", "POST").attr("action", "/user/updateUser").submit();
	}//===========================================//

	//==> �߰��Ⱥκ� : "�̸���" ��ȿ��Check  Event ó�� �� ����
	$(function() {
		$("input[name='email']").on("change", function() {
			var email = $("input[name='email']").val();
			
			if (email != "" && (email.indexOf('@') < 1|| email.indexOf('.') == -1)) {
				alert("�̸��� ������ �ƴմϴ�.");
				}
			});
		
		$("button[type='button']:contains('�����ϱ�')").on("click", function() {
			fncUpdateUser();
		});
		
		$("button[type='button']:contains('���')").on("click", function() {
			history.go(-1);
		});
		
		$("button[type='button']:contains('�ּҰ˻�')").on("click", function () {
			getAddress();
		});
	});
	
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
    	<h1 class="text-center">ȸ������ ����</h1>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3">
       			<form class="form-horizontal">
				<input type="hidden" name="userId" value="${user.userId }">
                
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-user"></i></span>
                    		<input type="text" name="userId" class="form-control input-lg" value="${user.userId }" disabled/>
    					</div>
    					<span></span>
                    </div>
                    
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-user-circle"></i></span>
                    		<input type="text" name="userName" maxLength="50" placeholder="�̸�" class="form-control input-lg" value="${user.userName }" />
    					</div>
                    </div>
                    
                    <div class="form-group row">
                    	<div class="col-sm-7">
                    		<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-home"></i></span>
                    			<input type="text" name="addr1" maxLength="100" placeholder="�ּ�" class="form-control input-lg" value="${user.addr1 }" />
    						</div>
                    	</div>
                    	
                    	<div class="col-sm-5">
                    		<button type="button" class="btn btn-secondary btn-lg">�ּҰ˻�</button>
                    	</div>
    					
    					<div class="col-sm-7">
                    		<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-id-card"></i></span>
                    			<input type="text" name="addr2" maxLength="100" placeholder="���ּ�" class="form-control input-lg" value="${user.addr2 }" />
    						</div>
                    	</div>
                    	
                    	<div class="col-sm-5">
                    		<div class="input-group">
                    			<input type="text" name="addr3" maxLength="100" placeholder="�����׸�" class="form-control input-lg" value="${user.addr3 }" />
    						</div>
                    	</div>
                    </div>
                    <input type="hidden" name="addr">
                    
                    <div class="form-group row">
                    	<div class="col-sm-4">
                    		<select name="phone1" class="form-control input-lg">
                            	<option value="010"
								${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  }>010</option>
								<option value="011"
								${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  }>011</option>
								<option value="016"
								${ ! empty user.phone1 && user.phone1 == "016" ? "selected" : ""  }>016</option>
								<option value="018"
								${ ! empty user.phone1 && user.phone1 == "018" ? "selected" : ""  }>018</option>
								<option value="019"
								${ ! empty user.phone1 && user.phone1 == "019" ? "selected" : ""  }>019</option>
                        	</select>
                    	</div>
                        
                        <div class="col-sm-4">
                        	<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    		 	<input type="text" name="phone2" maxLength="4" placeholder="��ȭ��ȣ" class="form-control input-lg" value="${user.phone2 }" />
    						</div>
                        </div>
                        
                        <div class="col-sm-4">
                        	<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    		 	<input type="text" name="phone3" maxLength="4" placeholder="��ȭ��ȣ" class="form-control input-lg" value="${user.phone3 }" />
    						</div>
                        </div>
                        
                        <input type="hidden" name="phone">
                    </div>
                    
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-at"></i></span>
                    		<input type="text" name="email" maxLength="50" placeholder="�̸���" class="form-control input-lg" value="${user.email }" />
    					</div>
                    </div>
                    
        			</form>
                    <div class="form-group text-center">
                        <button type="button" class="btn btn-default">�����ϱ�</button>
                        <button type="button" class="btn btn-primary">���</button>
                    </div>
                </div>
            </div>
	</div>
</body>
</html>