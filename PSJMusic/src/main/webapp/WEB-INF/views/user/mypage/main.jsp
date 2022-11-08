<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/font.css">
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
				<h1 class="w3-center w3-margin-top"><span style="color:rgb(216, 148, 148);">MY</span> PAGE</h1>
    		 <br/><br/>
    		 <div class="row w3-margin-top">
    		 	<div class="col-lg-2"></div>
    		 	<h4 class="col-lg-4"><span style="color:rgb(216, 148, 148);">피치뮤직</span>에 오신 것을 환영합니다.</h4>
    		 	<h4 class="col-lg-4">${sNickName}님의 마이페이지 입니다.</h4>
    		 	<div class="col-lg-2"></div>
    		 </div>	
    		 <br/><br/>
    		 <h4 class="w3-center">현재 이용중인 이용권은 : 무료입니다</h4>
    		 <br/><br/><br/><br/>
    		 <div class="row w3-margin-top">
	    		 	<div class="col-lg-3 w3-center w3-margin-top">
	    		 		<a href="${ctp}/user/pwdCheck"><i class="fas fa-id-card" style="font-size:48px;"></i></a>
	    		 		<h4>Profile</h4>
	    		 		<div>회원 정보</div>
		  				<div class="w3-margin-top">회원의 개인정보를 관리하는 공간입니다.</div>
		  			</div>
	    		 	<div class="col-lg-3 w3-center w3-margin-top">
	    		 		<a href="${ctp}/user/playlist?idx=${sIdx}"><i class="fas fa-headphones" style="font-size:48px;"></i></a>
	    		 		<h4>My Music</h4>
	    		 		<div>나의 플레이리스트</div>
		  				<div class="w3-margin-top">회원이 담은 음악을 열람하는 공간입니다.</div>
		  			</div>
	    		 	<div class="col-lg-3 w3-center w3-margin-top">
	    		 		<a href="${ctp}/service/qaInput"><i class="fas fa-question-circle" style="font-size:48px;"></i></a>
	    		 		<h4>Inquiry</h4>
	    		 		<div>문의하기</div>
		  				<div class="w3-margin-top">문의를 보낼 수 있습니다.</div>
		  			</div>
	    		 	<div class="col-lg-3 w3-center w3-margin-top">
	    		 		<a href="${ctp}/user/bestMusic?idx=${sIdx}"><i class="fas fa-music" style="font-size:48px;"></i></a>
	    		 		<h4>BestMusic</h4>
	    		 		<div>가장많이 들은 노래</div>
		  				<div class="w3-margin-top">회원님이 많이 들으신 노래입니다.</div>
		  			</div>
    		 </div>
	  </div>
	</div>
	<br/><br/><br/><br/><br/><br/><hr/>
	
		<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>