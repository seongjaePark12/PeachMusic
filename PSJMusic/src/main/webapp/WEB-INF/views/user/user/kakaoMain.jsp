<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
	<link rel="icon" href="${ctp}/resources/images/title/title.ico">
	  <script>
    location.href = "${ctp}/user/kakaoLogin?nickName=${nickName}&mid=${email}";
  </script>
</head>
<body>
 이름 : ${nickName}<br/>메일주소 : ${email}<br/>
</body>
</html>