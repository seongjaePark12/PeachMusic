<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인화면</title>
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
          <h1 class="font-weight-bold py-3 mt-3 ml-3" id="lolo"> L O G I N</h1>
          <form name="myform" class="needs-validation" method="post" novalidate>
            <div class="col-lg-12">
              <div class="txtb">
                <input type="text" class="form-control" name="SJ_USER_MID" id="SJ_USER_MID" placeholder="아이디를 입력해주세요" value="${mid}" maxlength="20" autofocus required />
                <div class="valid-feedback"></div>
                <div class="invalid-feedback">영문 또는 숫자를 포함하여 6 ~ 20자로 작성해주세요</div>
              </div>
              <div class="txtb ">
                <input type="password" class="form-control" name="SJ_USER_PWD" id="SJ_USER_PWD" placeholder="비밀번호를 입력해주세요" maxlength="20" required />
                <div class="valid-feedback"></div>
                <div class="invalid-feedback">영문, 숫자, 특수문자를 포함하여 8 ~ 20자로 입력해주세요</div>
              </div>
              <div class="form-group form-check">
                <label class="form-check-label">
                  <input class="form-check-input" type="checkbox" name="remember" /> 아이디저장
                </label>
              </div>
              <div class="col-lg-12" align="center">
                <input type="submit" class="logbtn" onclick="loginCheck()" value="로그인">
              </div>
              <br/><br/>
            </div>
            <br/><br/>
            <div align="center">
            	<a href="https://kauth.kakao.com/oauth/authorize?client_id=6bf3370a67e187c32e93dae4fe379313&redirect_uri=http://localhost:9090/PSJMusic/kakao/kakaoMain&response_type=code">
							  <img src="${ctp}/images/kakao/kakaologin.png" class="text-center" style="width:50%;"/>
							</a>
							<br/><br/>
							<div class="w3-center w3-xlarge">
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