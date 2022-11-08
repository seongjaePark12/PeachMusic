<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>피치뮤직 메거진</title>
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
	<div id="section">
			<div class="container">
	    <h1 style="text-align:center; color: #626262;">${vo.SJ_VIDEO_TITLE}</h1>
	    <p><br/></p>
		    <table class="table">
		      <tbody>
			      <tr class="text-center">
			        <td>${vo.SJ_VIDEO_LINK}</td>
			      </tr>
			      <tr class="text-center">
			        <td class="text-left">가수 : ${vo.SJ_VIDEO_ARTIST}</td>
			      </tr>
			      <tr class="text-center">
			        <td class="text-left">앨범 : ${vo.SJ_VIDEO_ALBUM}</td>
			      </tr>
			      <tr class="text-center">
			        <td class="con2" colspan="2">
			          <br>
			            <input class="btn" type="button" value="돌아가기" style="background: #f5d9da;;color:black;" onclick="location.href='${ctp}/service/videoMain';"/>
			        </td>
			      </tr>
		   		</tbody>
		    </table>
			</div>	
   	</div>
	</div>	
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>
