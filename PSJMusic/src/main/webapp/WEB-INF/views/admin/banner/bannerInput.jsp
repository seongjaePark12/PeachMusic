<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너 사진 업로드</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<script>
    function fCheck() {
    	var maxSize = 1024 * 1024 * 50;
    	var file = myform.file.value;
    	var ext = file.substring(file.lastIndexOf(".")+1);  // 화일의 확장자만 구하기
    	var uExt = ext.toUpperCase();  // 확장자를 대문자로 치환
	  	if(file == "") {
	  		alert("업로드할 파일을 선택하세요!");
	  		return false;
	  	}
	  	var fileSize = 0;
	  	var files = document.getElementById("file").files;
	  	var file;
	 	  for(var i=0; i<files.length; i++) {
	  		  file = files[i];
	  	  	if(file.name != "" && file.name != null) {
	  	  	  var fname = file.name;
	  	  		var ext = fname.substring(fname.lastIndexOf(".")+1);  // 확장자 발
		        var uExt = ext.toUpperCase();
		        
		        if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG") {
		      	  alert("업로드 가능한 파일은 'JPG/GIF/PNG'입니다.");
		      	  return false;
		        }
		        else if(fname.indexOf(" ") != -1) {
		      	  alert("업로드하는 파일에는 공백이 포함될 수 없습니다.");
		      	  return false;
		        }
		        else {
		        	fileSize += file.size;
		        }
	  	  	}
	  	  	
	  	  }
	  	  if(fileSize == 0 || fileSize > maxSize) {
	    	  alert("업로드하는 파일의 최대용량은 50MByte 입니다.");
	    	  return false;
	  	  }
	  	  else {
	  		  myform.submit();
	  	  }
    }
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav/adminNav.jsp"/>
	<div id="section">
			<div class="container">
				<form name="myform" method="post" enctype="multipart/form-data">
					<table class="table table-boderless">
						<tr>
							<td><h2>배너 등록</h2></td>
						</tr>
					</table>
					<table class="table">
						<tr>
							<th>배너사진 3장 등록</th>
							<td><input type="file" name="file" id="file" multiple="multiple" accept=".jpg,.png" /></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center">
								<input type="button" value="배너등록" onclick="fCheck()" class="btn" style="background: #f5d9da;"/>
								<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/main?sw=7';" style="background: #f5d9da;" class="btn"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
   	</div>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>