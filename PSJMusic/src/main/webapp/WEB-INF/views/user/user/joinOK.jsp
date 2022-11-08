<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입완료</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/login.css">
	<link rel="stylesheet" href="${ctp}/css/font.css">
	<style>
	.bb{
	  width: 500px;
	  height: 43px;
	  background: linear-gradient(25deg, #da8e93, #e9b3b6, #f5d9da);
	  border-radius: 4px;
	  font-weight: bold;
	  border: 0;
	  color: white;
	  font-size: 20px;
	}
	.bb:hover{
  	background-position: right;
	}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav/userNav.jsp"/>
	<div class="container" id="container" style="margin-top:20px;">
		<div style="height:100px; width:555px; margin:0 auto">
      	<div style="width:100px; float: none; position: absolute; text-align:center; left: 35%;">
          <i class="fa-solid fas fa-edit" style="font-size:25px;"></i><br>
          <p style="color: #777777; margin-top:15px"><b>약관동의</b><br/></p>
      	</div>
      	<div style="width:50px; float: none; position: absolute; text-align:center; left: 43%;">
          <i class="fa-solid fas fa-angle-right" style="font-size:25px;"></i>
      	</div>
      	<div style="width:100px; float: none; position: absolute; text-align:center; left: 47%;">
          <i class="fa-solid fas fa-pencil-alt" style="font-size:25px;"></i><br/>
          <p style="color: #777777; margin-top:20px"><b>회원정보 입력</b></p>
      	</div>
      	<div style="width:50px; float: none; position: absolute; text-align:center; left: 55%;">
          <i class="fa-solid fas fa-angle-right" style="font-size:25px;"></i>
      	</div>
      	<div style="width:100px; float: none; position: absolute; text-align:center; left: 60%;">
          <i class="fa-solid fas fa-check" style="font-size:25px;"></i><br/>
          <p style="margin-top:15px"><b>완료</b></p>
      	</div>
     </div>
     <div class="w3-center">
	     <img src="${ctp}/images/title/logo.png" width="85%">
  	   <h1 style="text-align: center;">가입이 완료되었습니다.</h1>
     </div><br/>
     <div class="w3-center w3-margin-left">
  	   <a style="text-align:center;" href="${ctp}/user/login" class="bb" type="button">로그인</a>
  	   <a style="text-align:center;" href="${ctp}/" class="bb" type="button">홈으로</a>
     </div>
   </div>  
</body>
</html>