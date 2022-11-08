<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 체크</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/font.css">
	<link rel="stylesheet" href="${ctp}/css/join.css">
	<link rel="stylesheet" href="${ctp}/css/main.css">
</head>
<body>
	<!-- top -->
		<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
	<!-- nav -->
		<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
		
		<div class="w3-container">
	  	<div class="w3-content" style="max-width:1200px">
	  		<br/><br/>
				<h1 class="w3-center w3-margin-top">비밀번호 확인</h1>
    		 <br/><br/>
  		 		<form name="myform" class="needs-validation" method="post" novalidate>
					  <div class="col-lg-12">
					  	<div align="center"><img src="${ctp}/images/title/logo.png" width="30%"></div>
						  <div class="txtb">
						    <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요" autofocus required>
						  </div>
					  </div>
					  <br/><br/>
					  <div class="col-lg-12" align="center">
				      <input type="submit" class="logbtn" value="비밀번호 확인">
				    	<input type="button" class="logbtn" onclick="location.href='${ctp}/user/main'" value="돌아가기">
				    </div>
			  </form>
	  </div>
	</div>
	<br/><br/><br/><br/><br/><br/><hr/>
		<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>