<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원수정</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/font.css">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/join.css">
	<script>
  	var nickCheckOn = 0;
  	// 이메일 중복체크
    function emailCheck() {
    	var invaidEmail =/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
			var SJ_USER_EMAIL = $("#SJ_USER_EMAIL").val();
			if(SJ_USER_EMAIL == '${sEmail}'){
				alert("이메일을 수정안함");
				nickCheckOn = 1;
				return false;
			}
			if(SJ_USER_EMAIL=="" || !invaidEmail.test(SJ_USER_EMAIL)) {
				alert("이메일을 체크하세요");
				myform.SJ_USER_EMAIL.focus();
				return false;
			}
			
    	
    	$.ajax({
    		type : "post",
    		url  : "../user/emailCheck",
    		data : {SJ_USER_EMAIL : SJ_USER_EMAIL},
    		success:function(data) {
    			if(data == "1") {
    				alert("이미 사용중인 이메일 입니다.");
    				$("#SJ_USER_EMAIL").focus();
    			}
    			else {
    				alert("사용 가능한 이메일 입니다.");
    				nickCheckOn = 1;	// 이메일 검색버튼을 클릭한경우는 nickCheckOn값이 1이 된다.
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  	function emailReset() {
  		nickCheckOn = 0;
  	}
    function joinCheck() {
    	var SJ_USER_MID = myform.SJ_USER_MID.value;
    	var SJ_USER_PWD = myform.SJ_USER_PWD.value;
    	var SJ_USER_EMAIL = myform.SJ_USER_EMAIL.value;
    	var SJ_USER_NUMBER =  myform.getCode1.value +"-"+ myform.getCode2.value + "-" + myform.getCode3.value;
    	
	  	var idPattern = /[A-Za-z0-9]$/g;
	  	var invaidemail =/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
	  	var invaidNum = /(\d{3}).*(\d{3}).*(\d{4})/;
			if(SJ_USER_PWD == SJ_USER_MID){
    		alert("아이디와 비밀번호는 같을 수 없습니다.");
    		myform.SJ_USER_PWD.value = "";
    		myform.pwdTest.value = "";
    		myform.SJ_USER_PWD.focus();
    	}else if(SJ_USER_PWD == "") {
    		alert("비밀번호를 입력하세요");
    		myform.SJ_USER_PWD.focus();
    	}else if(SJ_USER_PWD.length < 6 || SJ_USER_PWD.length > 16){
   			alert("비밀번호는 6~16자까지 입력가능합니다");
   			myform.SJ_USER_PWD.value = "";
    	}else if(SJ_USER_EMAIL == "") {
    		alert("이메일을 입력하세요");
    		myform.SJ_USER_EMAIL.focus();
    	}else if(!invaidemail.test(SJ_USER_EMAIL)) {
    			alert("이메일은 영문 숫자조합만 가능합니다");
    			myform.SJ_USER_EMAIL.value= "";
    			myform.SJ_USER_EMAIL.focus();
    	}else if (SJ_USER_NUMBER == ""){
    		alert("전화번호를 입력하세요");
    		myform.getCode1.focus();
    	}else if (!invaidNum.test(SJ_USER_NUMBER)) {
   	    	alert("전화번호는 숫자로만 입력해주세요");
   	    	myform.getCode1.value = "";
   	    	myform.getCode1.focus();
    	}
    	else {
				if(nickCheckOn == 1) {
    			myform.SJ_USER_NUMBER.value = SJ_USER_NUMBER;
    			myform.submit();
    		}
    		else {
    			if(nickCheckOn == 0) {
    				alert("이메일 중복체크버튼을 눌러주세요!");
    			}
    		}
    	}
    }
	</script>
</head>
<body>
	<!-- top -->
		<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
	<!-- nav -->
		<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
		
		<div class="w3-container">
	  	<div class="w3-content" style="max-width:1200px;text-align: center;">
	  		<br/><br/>
				<h1 class="w3-center w3-margin-top">회원정보수정</h1>
    		 <br/><br/>
    			<form name="myform"  style="display: inline-block; border: none;" method="post" class="was-validated bg-white" >
		        <div>
		          <label for="SJ_USER_MID"><b>아이디</b><font size="2px" color="#AF4034"> *</font></label>
		        </div>
		        <div>
		          <input type="text" class="form-control" name="SJ_USER_MID" id="SJ_USER_MID" value="${sMid}" readonly />
		        </div>
		        <br/>
		        <div>
		          <label for="SJ_USER_PWD"><b>비밀번호</b><font size="2px" color="#AF4034"> *</font></label>
		        </div>
		        <div>
		          <input type="password" class="form-control" name="SJ_USER_PWD" id="SJ_USER_PWD" value="${sPwd}" placeholder="비밀번호를 입력해주세요" min="4" maxlength="20" required />
		          <div class="valid-feedback"></div>
		          <div class="invalid-feedback" style="text-align: left;">비밀번호는 영문, 숫자, 특수문자를 포함하여 6 ~ 20자로 작성해주세요</div>
		        </div>
		        <br/>
		        <div>
		          <label for="SJ_USER_NICKNAME"><b>이름/닉네임</b><font size="2px" color="#AF4034"> *</font></label>
		        </div>   
		        <div>
		          <input type="text" class="form-control" name="SJ_USER_NICKNAME" id="SJ_USER_NICKNAME" value="${vo.SJ_USER_NICKNAME}" placeholder="이름 또는 닉네임을 입력해주세요" min="1" maxlength="20" required />
		        </div>
		        <br/>
		         <div>
		          <label for="SJ_USER_EMAIL"><b>이메일</b><font size="2px" color="#AF4034"> *</font></label><br/>
		        </div>
		        <div>
		          <input type="text" class="form-control" name="SJ_USER_EMAIL" id="SJ_USER_EMAIL" value="${vo.SJ_USER_EMAIL}" onkeyup="emailReset()" placeholder="예) name@example.com" required />
		          <div class="valid-feedback"></div>
		          <div class="invalid-feedback" style="text-align: left;">이메일은 비밀번호 찾기에 사용됩니다</div>
		        </div>
		        <div class="text-left" style="padding-top: 3px; padding-right: 3px;">
		          <input type="button" class="bubu" name="btnIdCheck" value="중복체크" onclick="emailCheck()" />
		        </div>
		        <br/>
		        <div>
		          <label for="SJ_USER_NUMBER"><b>휴대 전화</b><font size="2px" color="#AF4034"> *</font></label><br/>
		        </div>
		        <div class="input-group mb-3">
		          <input class="form-control" type="text" name="getCode1" id="getCode1" value="${fn:split(vo.SJ_USER_NUMBER,'-')[0]}"  required  min="2" maxlength="3" />
		          <font style="margin-top: 17px;">-</font>
		          <input class="form-control" type="text" name="getCode2" id="getCode2" value="${fn:split(vo.SJ_USER_NUMBER,'-')[1]}" required  min="2" maxlength="4" />
		          <font style="margin-top: 17px;">-</font>
		          <input class="form-control" type="text" name="getCode3" id="getCode3" value="${fn:split(vo.SJ_USER_NUMBER,'-')[2]}" required  min="3" maxlength="4" />
		        </div>
		        <br/>
		        <div>
		          <input style="text-align:center;" type="button" id="joinbtn" value="수정하기" onclick="joinCheck()">
		        </div>
		        <br/>
	 					<input type="hidden" name="SJ_USER_NUMBER"/>
				</form>
			  <p class="w3-medium">Made by 성재</p>
	  </div>
	</div>
		<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>