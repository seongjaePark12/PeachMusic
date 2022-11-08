<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>message</title>
<script>
	var msg = "${msg}";
	var url = "${ctp}/${url}";

	alert(msg);
	if(url != "")location.href = url;
</script>
</head>
<body>
</body>
</html>