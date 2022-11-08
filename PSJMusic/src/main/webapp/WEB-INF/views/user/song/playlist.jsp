<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>플레이리스트</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/font.css">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<style>
	.ho:hover {
		cursor: pointer;
	    opacity: 0.7;			
	}
	</style>
</head>
	<jsp:include page="/WEB-INF/views/include/addsonglist.jsp" />
<body>
<!-- top -->
	<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
<!-- nav -->
	<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
	<div class="w3-container">
  		<div class="card-body" style="padding-bottom: 300px;">
   		<h2 class="mt-5 mb-5"><b>${sNickName}</b>님 플레이리스트</h2>
   		<div class="row">
    		<div class="p-3 ho" onclick="" data-toggle="modal" data-target="#addSonglist">
    			<div style="width: 200px; height: 200px; border: 1px solid white; text-align: center; background: #111;"><i style="position: relative; top: 50px;" title="새 플레이리스트 추가" class="fas fa-plus fa-5x"></i></div>
    			<div style="width: 200px;" class="mt-3 text-center">새 플레이리스트 추가</div>
    		</div>
    		<c:forEach var="vo" items="${vos }">
    			<div class="p-3 ho" title="${vo.SJ_PLAYLIST_COMMENT }" onclick="javacript:location.href='${ctp}/user/playlistcontent?idx=${vo.idx}';">
	    		<div style="width: 200px; height: 200px;">
	    			<c:if test="${empty vo.thum1 }">
	    				<div><img src="https://i1.sndcdn.com/avatars-000606604806-j6ghpm-t500x500.jpg" style="width: 100%;"></div>
	    			</c:if>
	    			<c:if test="${empty vo.thum2 }">
	    				<div><img src="${vo.thum1 }"></div>
	    			</c:if>
	    			<c:if test="${!empty vo.thum2 }">
	    				<div class="row" style="margin-left: 0px;">
		    				<div><img src="${vo.thum1 }"></div>
		    				<div><img src="${vo.thum2 }"></div>
	    				</div>
	    				<div class="row" style="margin-left: 0px;">
		    				<div><img src="${vo.thum3 }"></div>
		    				<div><img src="${vo.thum4 }"></div>
	    				</div>
	    			</c:if>
	    			</div>
	    			<div style="width: 200px;" class="mt-3 text-center">${vo.listNm}</div>
    			</div>
    		</c:forEach>
   		</div>
 		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>
