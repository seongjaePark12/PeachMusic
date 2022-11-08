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
	          <h1 class="font-weight-bold py-3 mt-3 ml-3" id="lolo">회원님의 아이디를 찾았습니다!</h1>
	          <br/><br/>
            <div class="col-lg-12">
              <div class="txtb">
              	${mid}
              </div>
              <div class="col-lg-12" align="center">
                <button class="logbtn" onclick="location.href='${ctp}/user/login'">로그인 하러가기</button><br/><br/>
              </div>
              <br/><br/>
            </div>
            <br/><br/>
            <div align="center">
							<div class="w3-center w3-xlarge">
								<a href="${ctp}/user/pwdConfirm" style="font-size:16px">비밀번호를 잊으셨나요?</a> 
							  <p class="w3-medium">Made by 성재</p>
							</div>
            </div>
	      </div>
    </div>
</body>
</html>