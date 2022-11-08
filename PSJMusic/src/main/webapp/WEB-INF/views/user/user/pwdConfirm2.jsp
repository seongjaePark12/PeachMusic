<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="stylesheet" href="${ctp}/css/login.css">
	<link rel="stylesheet" href="${ctp}/css/font.css">
</head>
<body>
	<div class="w3-bar w3-white w3-border-bottom w3-xlarge">
	  <a href="${ctp}" class="w3-bar-item w3-button w3-text-red w3-hover-red"><b><i class="fa fa-plane w3-margin-right"></i>PSJ항공</b></a>
	  <a href="#" class="w3-bar-item w3-button w3-right w3-hover-red w3-text-grey" data-toggle="modal" data-target="#myModal">
	    로그인
	  </a>
	</div>
<p><br/><br/></p>
 <div class="Form my-4 mx-5">
    <div class="container">
      <div class="row no-gutters">
      <div class="col-lg-3">
       </div>
			 <div class="col-lg-6 px-5 pt-5 mt-5">
			   <h1 class="font-weight-bold py-3 mt-3 ml-3" id="lolo">임시비밀번호를 발급해드렸습니다</h1>
			   <br/><br/>
			   <form class="needs-validation" method="post" novalidate>
			     <div class="col-lg-12">
			       <div class="txtb text-center" style="font-size:20pt;">
			       	${content}
			       </div>
			       <br/><br/>
			       <div class="col-lg-12" align="center">
			       	<input type="button" class="logbtn" onclick="location.href='${ctp}'" value="돌아가기">
			       </div>
			     </div>
			     <br/><br/>
			     <div align="center">
			       <a href="${ctp}" style="font-size:16px">홈으로</a> 
			     </div>
			      <br/>
			    </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>