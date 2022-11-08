<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<script>
    function fCheck() {
    	var SJ_MAGAZINE_IMG = myform.SJ_MAGAZINE_IMG.value;
    	var SJ_MAGAZINE_TITLE = myform.SJ_MAGAZINE_TITLE.value;
    	
    	if(SJ_MAGAZINE_IMG.trim() == "") {
    		alert("이미지링크를 입력하세요");
    		myform.SJ_MAGAZINE_IMG.focus();
    	}else if(SJ_MAGAZINE_TITLE.trim() == ""){
    		alert("게시글 제목을 입력하세요");
    		myform.SJ_MAGAZINE_TITLE.focus();
    	}else {
    		myform.oriContent.value = document.getElementById("oriContent").innerHTML;
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav/adminNav.jsp"/>
	<div id="section">
			<div class="container">
				<form name="myform" method="post">
					<table class="table table-boderless">
						<tr>
							<td><h2>매거진 수정</h2></td>
						</tr>
					</table>
					<table class="table">
						<tr>
							<th>이미지링크</th>
							<td><input type="text" name="SJ_MAGAZINE_IMG" value="${vo.SJ_MAGAZINE_IMG}" placeholder="이미지링크를 입력하세요" class="form-control" autofocus required /></td>
						</tr>
						<tr>
							<th>글제목</th>
							<td><input type="text" name="SJ_MAGAZINE_TITLE" value="${vo.SJ_MAGAZINE_TITLE}" placeholder="글제목을 입력하세요" class="form-control" required /></td>
						</tr>
						<tr>
							<th>글내용</th>
							<td><textarea rows="6" name="SJ_MAGAZINE_CONTENT" id="CKEDITOR" class="form-control" required >${vo.SJ_MAGAZINE_CONTENT}</textarea></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center">
								<input type="button" value="수정하기" onclick="fCheck()" class="btn" style="background: #f5d9da;"/>
								<input type="reset" value="다시입력" class="btn" style="background: #f5d9da;"/>
								<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/magazinContent?idx=${magazinvo.SJ_MAGAZINE_IDX}&pag=${pag}&pageSize=${pageSize}';" style="background: #f5d9da;" class="btn"/>
							</td>
						</tr>
					</table>
					<input type="hidden" name="SJ_MAGAZINE_IDX" value="${vo.SJ_MAGAZINE_IDX}"/>
					<input type="hidden" name="pag" value="${pag}"/>
					<input type="hidden" name="pagSize" value="${pagSize}"/>
					<input type="hidden" name="oriContent" />
					<div id="oriContent" style="display:none;">${vo.SJ_MAGAZINE_CONTENT}</div>
				</form>
			</div>
   	</div>
<script>
	CKEDITOR.replace("SJ_MAGAZINE_CONTENT", {
		uploadUrl:"${ctp}/admin/imageUpload",		/* 여러개의 그림파일을 드래그&드롭으로 처리 */
		filebrowserUploadUrl : "${ctp}/admin/imageUpload", /* 파일(이미지) 업로드시 처리 */
		height:400
	});
</script>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>