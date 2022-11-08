<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	<nav class="navbar navbar-expand-sm bg-light justify-content-center" style="background: linear-gradient(25deg, #da8e93, #e9b3b6, #f5d9da);">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" style="margin-right:50px" href="${ctp}/user/login"><b>로그인</b></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" style="margin-right:50px" href="${ctp}/user/midConfirm"><b>아이디 찾기</b></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" style="margin-right:50px; color: white;" href="${ctp}/"><b>Peach Music</b></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" style="margin-right:50px" href="${ctp}/user/pwdConfirm"><b>비밀번호 찾기</b></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" style="margin-right:50px" href="${ctp}/user/register"><b>회원가입</b></a>
	    </li>
	  </ul>
	</nav>
