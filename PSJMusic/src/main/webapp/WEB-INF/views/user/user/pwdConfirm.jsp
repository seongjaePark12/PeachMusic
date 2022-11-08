<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/login.css">
	<link rel="stylesheet" href="${ctp}/css/font.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav/userNav.jsp"/>
		<div class="w3-main" style="margin-left:30%;margin-right:30%">
		  <div class="w3-container" id="showcase">
		  	<div align="center"><img src="${ctp}/images/title/logo.png" id="imgimg"></div>
	          <h1 class="font-weight-bold py-3 mt-3 ml-3" id="lolo">비밀번호 찾기</h1>
	          <form name="myform" class="needs-validation" method="post" novalidate>
	            <div class="col-lg-12">
	              <div class="txtb">
	               <input type="text" class="form-control" name="mid" id="mid" autofocus required />
	                <div class="valid-feedback"></div>
	                <div class="invalid-feedback">아이디를 입력해주세요</div>
	              </div>
	              <div class="txtb">
	               <input type="text" class="form-control" name="num" id="num" placeholder="예) 010-0000-0000" autofocus required />
	                <div class="valid-feedback"></div>
	                <div class="invalid-feedback">휴대폰 번호를 정확히 입력해주세요 예)010-0000-0000</div>
	              </div>
	              <div class="txtb ">
	                <input type="text" class="form-control" name="email" id="email" placeholder="예) name@example.com" required onkeypress="enter()" />
	                <div class="valid-feedback"></div>
	                <div class="invalid-feedback">이메일을 입력해주세요</div>
	              </div>
	              <div class="col-lg-12" align="center">
	                <input type="submit" class="logbtn" value="비밀번호 찾기"><br/><br/>
	              </div>
	            </div>
	            <div align="center">
								<div class="w3-center w3-xlarge">
									<a href="${ctp}/user/midConfirm" style="font-size:16px">아이디를 잊으셨나요?</a> 
								  <p class="w3-medium">Made by 성재</p>
								</div>
	            </div>
	          </form>
	      </div>
    </div>
  <script>
	  // Disable form submissions if there are invalid fields
	  (function() {
	    'use strict';
	    window.addEventListener('load', function() {
	      // Get the forms we want to add validation styles to
	      var forms = document.getElementsByClassName('needs-validation');
	      // Loop over them and prevent submission
	      var validation = Array.prototype.filter.call(forms, function(form) {
	        form.addEventListener('submit', function(event) {
	          if (form.checkValidity() === false) {
	            event.preventDefault();
	            event.stopPropagation();
	          }
	          form.classList.add('was-validated');
	        }, false);
	      });
	    }, false);
	  })();
 	</script>
</body>
</html>