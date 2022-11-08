<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>피치뮤직</title>
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
	    <div class="w3-content w3-display-container" style="max-width:1200px">
			  <img class="mySlides w3-animate-right" src="${ctp}/data/banner/${fn:split(bannervos.SJ_BANNER_RFILE,'/')[0]}" style="width: 100%;">
			  <img class="mySlides w3-animate-right" src="${ctp}/data/banner/${fn:split(bannervos.SJ_BANNER_RFILE,'/')[1]}" style="width: 100%;">
			  <img class="mySlides w3-animate-right" src="${ctp}/data/banner/${fn:split(bannervos.SJ_BANNER_RFILE,'/')[2]}" style="width: 100%;">
			  <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="width:100%">
			    <div class="w3-left w3-hover-text-khaki" onclick="plusDivs(-1)">❮</div>
			    <div class="w3-right w3-hover-text-khaki" onclick="plusDivs(1)">❯</div>
			    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(1)"></span>
			    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(2)"></span>
			    <span class="w3-badge demo w3-border w3-transparent w3-hover-white w3-white" onclick="currentDiv(3)"></span>
			  </div>
			</div>
	  </div>
	  	  <div class="w3-container">
	  	<div class="w3-content" style="max-width:1200px">
	  		<h3>피치TV</h3>
				<div class="scrollmenu">
					<div>
						<c:forEach var="tvvo" items="${tvvos }" varStatus="st">
						  <a href="${ctp}/service/video?idx=${tvvo.SJ_VIDEO_IDX}"><img src="${tvvo.SJ_VIDEO_IMG}"style="width: 300px; height: 200px;"/></a>
						</c:forEach> 
					</div>
				</div>
			</div>
		</div>	
	  <div class="w3-container">
	  	<div class="w3-content" style="max-width:1200px">
	  		<h3>메거진</h3>
				<div class="scrollmenu">
					<div>
						<c:forEach var="mmvo" items="${magazinevos }" varStatus="st">
						  <a href="${ctp}/service/magazine?idx=${mmvo.SJ_MAGAZINE_IDX}"><img src="${mmvo.SJ_MAGAZINE_IMG}"style="width: 300px; height: 200px;"/></a>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>	
	  <div class="w3-container">
		  <div class="w3-content" style="max-width:1200px">
			  <div class="w3-display-container w3-margin w3-padding-16">
					<div class="row">
						<div class="col-lg-12 w3-margin-bottom">
							피치차트
							<div class="card border-0 chart"><!-- 색상 -->
								<div class="card-header p-0 chart">
	                <table class="table">
	                    <c:forEach var="vo" items="${vos }" varStatus="st">
		                    <tr>
		                        <td style="text-align: center; vertical-align: middle;">${vo.SJ_CHART_RANK}</td>
		                        <td><img name="top100Img" src="${vo.SJ_CHART_IMG }"></td>
		                        <td class="align-middle">
		                            <div name="top100Title">${vo.SJ_CHART_TITLE }</div>
		                            <div name="top100Artist">${vo.SJ_CHART_ARTIST }</div>
		                        </td>
		                    </tr>
	                    </c:forEach>
	                </table>
								</div>
							</div>
						</div>
					</div>
				</div>	
			</div>
		</div>
		<br/><br/><br/><br/>

	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
	<script>
		var slideIndex = 1;
		showDivs(slideIndex);
		function plusDivs(n) {
		  showDivs(slideIndex += n);
		}
		
		function currentDiv(n) {
		  showDivs(slideIndex = n);
		}
		
		function showDivs(n) {
		  var i;
		  var x = document.getElementsByClassName("mySlides");
		  var dots = document.getElementsByClassName("demo");
		  if (n > x.length) {slideIndex = 1}
		  if (n < 1) {slideIndex = x.length}
		  for (i = 0; i < x.length; i++) {
		    x[i].style.display = "none";  
		  }
		  for (i = 0; i < dots.length; i++) {
		    dots[i].className = dots[i].className.replace(" w3-white", "");
		  }
		  x[slideIndex-1].style.display = "block";  
		  dots[slideIndex-1].className += " w3-white";
		}
</script>
<script>
	var myIndex = 0;
	carousel();
	
	function carousel() {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";  
	  }
	  myIndex++;
	  if (myIndex > x.length) {myIndex = 1}    
	  x[myIndex-1].style.display = "block";  
	  setTimeout(carousel, 4000); // Change image every 2 seconds
	}
</script>
</body>
</html>
