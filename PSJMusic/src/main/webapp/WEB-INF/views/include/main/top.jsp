<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
	<div class="back"></div>
	<div class="w3-border-bottom">
		<div style="margin-right: 20%">
			<div class="w3-bar w3-small">
			  <c:if test="${sMid == null}"><a href="${ctp}/user/login" class="w3-bar-item w3-padding-large w3-right">로그인</a></c:if>
			  <c:if test="${sMid != null}">
				  <a href="${ctp}/user/logout" class="w3-bar-item w3-padding-large w3-right">로그아웃</a>
			  	<a href="${ctp}/user/main" class="w3-bar-item w3-padding-large w3-right">마이페이지</a>
		  	</c:if>
		  	<a href="${ctp}/service/qaList" class="w3-bar-item w3-padding-large w3-right">Q＆A</a>
		  	<a href="${ctp}/user/notice" class="w3-bar-item w3-padding-large w3-right">공지사항</a>
		  	<a href="${ctp}/user/pay" class="w3-bar-item w3-padding-large w3-right">이용권구매</a>
		  	<c:if test="${sMid == 'admin'}"><a href="${ctp}/admin/main" class="w3-bar-item w3-padding-large w3-right"><b>관리자</b></a></c:if>
			</div>
		</div>
	</div>
	<br/>