  	var idCheckOn = 0;
  	var nickCheckOn = 0;
  	// 아이디 중복체크(aJax처리)
    function idCheck() {
    	var SJ_USER_MID = $("#SJ_USER_MID").val();
    	if(SJ_USER_MID=="" || $("#SJ_USER_MID").val().length<4 || $("#SJ_USER_MID").val().length>20) {
    		alert("아이디를 체크하세요!(아이디는 4~20자 이내로 사용하세요.)");
    		myform.SJ_USER_MID.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "../user/idCheck",
    		data : {SJ_USER_MID : SJ_USER_MID},
    		success:function(data) {
    			if(data == "1") {
    				alert("이미 사용중인 아이디 입니다.");
    				$("#SJ_USER_MID").focus();
    			}
    			else {
    				alert("사용 가능한 아이디 입니다.");
    				idCheckOn = 1;	// 아이디 검색버튼을 클릭한경우는 idCheckOn값이 1이 된다.
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
  	// 이메일 중복체크
    function emailCheck() {
    	var invaidEmail =/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
    	var SJ_USER_EMAIL = $("#SJ_USER_EMAIL").val();
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
  	function idReset() {
  		idCheckOn = 0;
  	}
  	function emailReset() {
  		nickCheckOn = 0;
  	}
  	// 회원가입폼 체크
    function joinCheck() {
    	var SJ_USER_MID = myform.SJ_USER_MID.value;
    	var SJ_USER_PWD = myform.SJ_USER_PWD.value;
    	var pwdTest = myform.pwdTest.value;
    	var SJ_USER_EMAIL = myform.SJ_USER_EMAIL.value;
    	var SJ_USER_NUMBER =  myform.getCode1.value +"-"+ myform.getCode2.value + "-" + myform.getCode3.value;
    	
	  	var idPattern = /[A-Za-z0-9]$/g;
	  	var invaidemail =/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
	  	var invaidNum = /(\d{3}).*(\d{3}).*(\d{4})/;
    	if(SJ_USER_MID == "") {
    		alert("아이디를 입력하세요");
    		myform.SJ_USER_MID.focus();
    	}else	if(SJ_USER_MID.length < 4 || SJ_USER_MID.length > 16){
    		alert("아이디는 4~16자리까지 입력가능합니다");
    		myform.SJ_USER_MID.focus();
    	}else if(!idPattern.test(SJ_USER_MID)){
   			alert("아이디는 영어와 숫자만 입력가능합니다");
   			myform.SJ_USER_MID.value = "";
   			myform.SJ_USER_MID.focus();
    	}else if(SJ_USER_PWD == SJ_USER_MID){
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
   		}else if(pwdTest == ""){
    		myform.pwdTest.focus();
   		}else if(SJ_USER_PWD != pwdTest) {
    		alert("비밀번호가 서로 다릅니다");
    		myform.SJ_USER_PWD.value = "";
    		myform.pwdTest.value = "";
    		myform.SJ_USER_PWD.focus();
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
				if(idCheckOn == 1 && nickCheckOn == 1) {
    			myform.SJ_USER_NUMBER.value = SJ_USER_NUMBER;
    			myform.submit();
    		}
    		else {
    			if(idCheckOn == 0) {
    				alert("아이디 중복체크버튼을 눌러주세요!");
    			}
    			else {
    				alert("이메일, 중복체크버튼을 눌러주세요!");
    			}
    		}
    	}
    }