<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="ko">
<head>
	<title>ȸ������</title>

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
	
	function fncAddUser() {
		// Form ��ȿ�� ����

		var id = $("input[name='userId']").val();
		var pw = $("input[name='password']").val();
		var pw_confirm = $("input[name='password2']").val();
		var name = $("input[name='userName']").val();

		if (id == null || id.length < 1) {
			alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (pw == null || pw.length < 1) {
			alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (pw_confirm == null || pw_confirm.length < 1) {
			alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (name == null || name.length < 1) {
			alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		if (pw != pw_confirm) {
			alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
			$("input:text[name='password2']").focus();
			return;
		}

		var value = "";
		if ($("input:text[name='phone2']").val() != ""
		 && $("input:text[name='phone3']").val() != ""){
			
			var value = $("select[name='phone1']").val() + "-"
					+ $("input[name='phone2']").val() + "-"
					+ $("input[name='phone3']").val();
		}
		
		$("input:hidden[name='phone']").val(value);
		
		var addrValue = $("input[name='addr1']").val() + "/"
				+ $("input[name='addr2']").val() + "/"
				+ $("input[name='addr3']").val();

		$("input:hidden[name='addr']").val(addrValue);

		$("form").attr("method", "POST").attr("action", "/user/addUser").submit();
	}

	//==> �����ϱ�Ⱥκ� : "���"  Event ó�� ��  ����
	$(function() {
		$("button[type='button']:contains('�����ϱ�')").on("click", function() {
			fncAddUser();
		});
		
		$("button[type='button']:contains('���')").on("click", function() {
			$("form")[0].reset();
		});
		
		$("input[name='email']").on("change", function() {
			var email = $("input[name='email']").val();
			
			if (email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)) {
				$("input[name='email']").next().css("color", "red").text("��ȿ�� �̸����� �ƴմϴ�");
			}else{
				$("input[name='email']").next().text("");
			}
		});
		
		$("input[name='userId']").on("change", function () {
			if ($("input[name='userId']").val() != null && $("input[name='userId']").val().length > 0) {
				checkUserId();
			}else{
				$("input[name='userId']").next().css("color", "black").text("���̵� �Է����ּ���");
			}
		})
		
		$("button[type='button']:contains('�ּҰ˻�')").on("click", function () {
			getAddress();
		});
	});

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//==> �ֹι�ȣ ��ȿ�� check �� ����������....
	function checkSsn() {
		var ssn1, ssn2;
		var nByear, nTyear;
		var today;

		ssn = $("input[name='ssn']").val();
		// ��ȿ�� �ֹι�ȣ ������ ��츸 ���� ��� ����, PortalJuminCheck �Լ��� CommonScript.js �� ���� �ֹι�ȣ üũ �Լ��� 
		if (!PortalJuminCheck(ssn)) {
			$("input[name='ssn']").parent().next().css("color", "red").text("�߸��� �ֹι�ȣ�Դϴ�.");
			return false;
		}else{
			$("input[name='ssn']").parent().next().text("");
			return true;
		}
	}

	function PortalJuminCheck(fieldValue) {
		var pattern = /^([0-9]{6})-?([0-9]{7})$/;
		var num = fieldValue;
		if (!pattern.test(num))
			return false;
		num = RegExp.$1 + RegExp.$2;

		var sum = 0;
		var last = num.charCodeAt(12) - 0x30;
		var bases = "234567892345";
		for (var i = 0; i < 12; i++) {
			if (isNaN(num.substring(i, i + 1)))
				return false;
			sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
		}
		var mod = sum % 11;
		return ((11 - mod) % 10 == last) ? true : false;
	}
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	function checkUserId(){
		
		var userId = $("input[name='userId']").val();
		
			$.ajax({
				url : "/user/json/checkDuplication",
				method : "POST",
				data: userId,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json; charset=utf-8"
					},
				dataType : "json",
				success : function(JSONData , status) {
				console.log(JSONData);
				var flag = JSONData.result;
						
				if(flag){
					$("input[name='userId']").parent().next().css("color", "blue").text(JSONData.userId+ "�� ��� �����մϴ�");
				}else{
					$("input[name='userId']").parent().next().css("color","red").text(JSONData.userId+ "�� ��� �Ұ����մϴ�.");
					}
				}
		});
	}
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
    	<h1 class="text-center">ȸ�������� �Է����ּ���</h1>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3">
       			<form class="form-horizontal">
                
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-user"></i></span>
                    		<input type="text" name="userId" maxLength="20" placeholder="���̵�" class="form-control input-lg"/>
    					</div>
    					<span></span>
                    </div>
                    
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-key"></i></span>
                    		<input type="password" name="password" maxLength="10" placeholder="��й�ȣ" class="form-control input-lg" />
    					</div>
                        
                    </div>
                    
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-check"></i></span>
                    		<input type="password" name="password2" maxLength="10" placeholder="��й�ȣ Ȯ��" class="form-control input-lg" />
    					</div>
                    </div>
                    
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-user-circle"></i></span>
                    		<input type="text" name="userName" maxLength="50" placeholder="�̸�" class="form-control input-lg" />
    					</div>
                    </div>
                    
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-id-card"></i></span>
                    		<input type="text" name="ssn" maxLength="13" placeholder="�ֹι�ȣ" class="form-control input-lg" />
    					</div>
                        <span>-����, 13�ڸ� �Է�</span>
                    </div>
                    
                    <div class="form-group row">
                    	<div class="col-sm-7">
                    		<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-home"></i></span>
                    			<input type="text" name="addr1" maxLength="100" placeholder="�ּ�" class="form-control input-lg"/>
    						</div>
                    	</div>
                    	
                    	<div class="col-sm-5">
                    		<button type="button" class="btn btn-info btn-lg">�ּҰ˻�</button>
                    	</div>
    					
    					<div class="col-sm-7">
                    		<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-id-card"></i></span>
                    			<input type="text" name="addr2" maxLength="100" placeholder="���ּ�" class="form-control input-lg" />
    						</div>
                    	</div>
                    	
                    	<div class="col-sm-5">
                    		<div class="input-group">
                    			<input type="text" name="addr3" maxLength="100" placeholder="�����׸�" class="form-control input-lg" />
    						</div>
                    	</div>
                    </div>
                    <input type="hidden" name="addr">
                    
                    <div class="form-group row">
                    	<div class="col-sm-4">
                    		<select name="phone1" class="form-control input-lg">
                            	<option value="010">010</option>
                            	<option value="011">011</option>
                            	<option value="016">016</option>
                            	<option value="018">018</option>
                            	<option value="019">019</option>
                        	</select>
                    	</div>
                        
                        <div class="col-sm-4">
                        	<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    		 	<input type="text" name="phone2" maxLength="4" placeholder="��ȭ��ȣ" class="form-control input-lg" />
    						</div>
                        </div>
                        
                        <div class="col-sm-4">
                        	<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    		 	<input type="text" name="phone3" maxLength="4" placeholder="��ȭ��ȣ" class="form-control input-lg" />
    						</div>
                        </div>
                        
                        <input type="hidden" name="phone">
                    </div>
                    
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-at"></i></span>
                    		<input type="text" name="email" maxLength="50" placeholder="�̸���" class="form-control input-lg" />
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