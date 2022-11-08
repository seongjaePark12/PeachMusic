<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	<div id="top2">
		<span id="logo"><a href="${ctp}/"><img src="${ctp}/images/title/logo.png" width="150px"></a></span>
		<a href="${ctp }/admin/main?sw=0" class="menu">관리자메인</a>
		<a href="${ctp }/admin/main?sw=1" class="menu">차트</a>
		<a href="${ctp }/admin/main?sw=8" class="menu">음악</a>
		<a href="${ctp }/admin/main?sw=9" class="menu">음악파일</a>
		<a href="${ctp }/admin/main?sw=2" class="menu">동영상 관리</a>
		<a href="${ctp }/admin/main?sw=3" class="menu">매거진 관리</a>
		<a href="${ctp }/admin/main?sw=4" class="menu">회원 관리</a>
		<a href="${ctp }/admin/main?sw=5" class="menu">공지 관리</a>
		<a href="${ctp }/admin/main?sw=6" class="menu">문의 관리</a>
		<a href="${ctp }/admin/main?sw=7" class="menu">배너 관리</a>
	</div>