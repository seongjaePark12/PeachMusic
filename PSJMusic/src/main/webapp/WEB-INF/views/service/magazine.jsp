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
			<h1 style="font-size: 80px; color: black;"><b>Magazine</b></h1>
		</div>
		<br/><br/><br/><br/>
	</div>
		<div class="container">
		<div class="w3-content" style="max-width:100%;">
			<a href="${ctp}/service/magazine?idx=${mvo.SJ_MAGAZINE_IDX}">
				<img src="${mvo.SJ_MAGAZINE_IMG}" class="card-img-bottom img-fluid" alt="image">
			</a>
			<h3 style="text-align: center; font-size: 25px; color: black;"><a href="${ctp}/service/magazine?idx=${mvo.SJ_MAGAZINE_IDX}"><b>${mvo.SJ_MAGAZINE_TITLE}</b></a></h3>
		</div>
	</div>
	<br/><br/><br/><br/>
	<div class="row w3-margin">
		<c:forEach var="vo" items="${magazinevos}">
			<div class="col-lg-3 w3-margin-bottom">
				<div class="card border-0">
					<div class="card-header p-0">
						<a href="${ctp}/service/magazine?idx=${vo.SJ_MAGAZINE_IDX}">
							<img src="${vo.SJ_MAGAZINE_IMG}" width="600" height="650" class="card-img-bottom img-fluid" alt="image">
						</a>
					</div>
					<h2 style="text-align: center; font-size: 20px; color: black;"><a href="${ctp}/service/magazine?idx=${vo.SJ_MAGAZINE_IDX}"><b>${vo.SJ_MAGAZINE_TITLE}</b></a></h2>
				</div>
			</div>
		</c:forEach>
	</div>	
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>
