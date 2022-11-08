<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 내용</title>
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
	<div id="section">
		<div class="container">
	  	<h2 style="text-align: center;">NOTICE</h2>
		  <table class="table table-hover text-center">
		    <tr class="text-dark" style="background: #f5d9da;">
		    	<th style="width:5%">공지</th>
		      <th style="width:5%">번호</th>
		      <th style="width:50%">제목</th>
		      <th style="width:15%">작성자</th>
		      <th style="width:10%">작성일</th>
		    </tr>
		    <c:forEach var="noticevo" items="${noticevos}">
			    <tr>
			    	<td><c:if test="${noticevo.SJ_NOTICE_NOTICE == 1}"><font color="red"><b>공지</b></font></c:if></td>
			    	<td>${curScrStartNo}</td>
			      <td>
			      	<a href="${ctp}/user/noticeContent?idx=${noticevo.SJ_NOTICE_IDX}&pag=${pag}&pageSize=${pageSize}">${noticevo.SJ_NOTICE_TITLE}</a>
			      	<c:if test="${noticevo.diffTime <= 24}"><img src="${ctp}/images/new.png" width="40px" height="20px"/></c:if>
			      </td>
			      <td>${noticevo.SJ_NOTICE_NAME}</td>
			      <td>
			      	<c:if test="${noticevo.diffTime <= 24}">${fn:substring(noticevo.SJ_NOTICE_DATENOW,11,16)}</c:if>
			      	<c:if test="${noticevo.diffTime >= 24}">${fn:substring(noticevo.SJ_NOTICE_DATENOW,0,10)}</c:if>
			      </td>
			    </tr>
			    <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		    </c:forEach>
		  </table>
	</div>
</div>	  
 <!-- 블록 페이징처리 시작(bs4 스타일 적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${totPage == 0}"><p style="text-align:center">자료가 없습니다</p></c:if>
			<c:if test="${totPage != 0}">
				<c:if test="${pag != 1}">
					<li class="page-item"><a href="${ctp}/user/notice?pag=1&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="첫페이지">◀◀</a></li>
				</c:if>
				<c:if test="${curBlock > 0}">
					<li class="page-item"><a href="${ctp}/user/notice?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="이전">◀</a></li>
				</c:if>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
					<c:if test="${i == pag && i <= totPage}">
						<li class="page-item active"><a href='${ctp}/user/notice?pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
					<c:if test="${i != pag && i <= totPage}">
						<li class="page-item"><a href='${ctp}/user/notice?pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${curBlock < lastBlock}">
					<li class="page-item"><a href="${ctp}/user/notice?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="다음">▶</a></li>
				</c:if>
				<c:if test="${pag != totPage}">
					<li class="page-item"><a href="${ctp}/user/notice?pag=${totPage}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="마지막">▶▶</a></li>
				</c:if>
			</c:if>
		</ul>
	</div>
</body>
</html>	