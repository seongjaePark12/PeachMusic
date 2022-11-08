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
		<br/><br/><br/><br/>
		<div class="text-center">
			<h1>피치TV</h1>
		</div>
		<br/><br/><br/><br/>
	</div>
	<div class="row w3-margin">
		<c:forEach var="vo" items="${videovos}">
			<div class="col-lg-2 w3-margin-bottom">
				<div class="card border-0">
					<div class="card-header p-0">
						<a href="${ctp}/service/video?idx=${vo.SJ_VIDEO_IDX}">
							<img src="${vo.SJ_VIDEO_IMG}" width="600" height="650" class="card-img-bottom img-fluid" alt="image">
						</a>
					</div>
					<a href="${ctp}/service/video?idx=${vo.SJ_VIDEO_IDX}" style="text-align: center; font-size: 20px; color: black;">${vo.SJ_VIDEO_ARTIST}</a>
					<a href="${ctp}/service/video?idx=${vo.SJ_VIDEO_IDX}" style="text-align: center; font-size: 20px; color: black;">${vo.SJ_VIDEO_TITLE}</a>
				</div>
			</div>
		</c:forEach>
	</div>	
	<br/><br/><br/><br/>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>
