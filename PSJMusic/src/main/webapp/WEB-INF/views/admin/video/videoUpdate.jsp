<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비디오 수정</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<script>
    function fCheck() {
    	var SJ_VIDEO_IMG = myform.SJ_VIDEO_IMG.value;
    	var SJ_VIDEO_LINK = myform.SJ_VIDEO_LINK.value;
    	var SJ_VIDEO_TITLE = myform.SJ_VIDEO_TITLE.value;
    	var SJ_VIDEO_ARTIST = myform.SJ_VIDEO_ARTIST.value;
    	var SJ_VIDEO_ALBUM = myform.SJ_VIDEO_ALBUM.value;
    	
    	if(SJ_VIDEO_IMG.trim() == "") {
    		alert("이미지를 입력하세요");
    		myform.SJ_VIDEO_IMG.focus();
    	}else if(SJ_VIDEO_LINK.trim() == "") {
    		alert("비디오링크를 입력하세요");
    		myform.SJ_VIDEO_LINK.focus();
    	}else if(SJ_VIDEO_TITLE.trim() == "") {
    		alert("비디오 제목을 입력하세요");
    		myform.SJ_VIDEO_TITLE.focus();
    	}else if(SJ_VIDEO_ARTIST.trim() == "") {
    		alert("아티스트를 입력하세요");
    		myform.SJ_VIDEO_ARTIST.focus();
    	}else if(SJ_VIDEO_ALBUM.trim() == "") {
    		alert("앨범명을 입력하세요");
    		myform.SJ_VIDEO_ALBUM.focus();
    	}else {
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
							<td><h2>동영상 수정</h2></td>
						</tr>
					</table>
					<table class="table">
						<tr>
							<th>이미지링크</th>
							<td><input type="text" name="SJ_VIDEO_IMG" placeholder="이미지링크를 입력하세요" value="${vo.SJ_VIDEO_IMG}" class="form-control" autofocus required /></td>
						</tr>
						<tr>
							<th>비디오링크</th>
							<td><textarea name="SJ_VIDEO_LINK" placeholder="비디오링크를 입력하세요" class="form-control" required >${vo.SJ_VIDEO_LINK}</textarea></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" name="SJ_VIDEO_TITLE" placeholder="제목을 입력하세요" value="${vo.SJ_VIDEO_TITLE}" class="form-control" required /></td>
						</tr>
						<tr>
							<th>가수</th>
							<td><input type="text" name="SJ_VIDEO_ARTIST" placeholder="가수를 입력하세요" value="${vo.SJ_VIDEO_ARTIST}" class="form-control" required /></td>
						</tr>
						<tr>
							<th>앨범</th>
							<td><input type="text" name="SJ_VIDEO_ALBUM" placeholder="앨범명 입력하세요" value="${vo.SJ_VIDEO_ALBUM}" class="form-control" required /></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center">
								<input type="button" value="글올리기" onclick="fCheck()" class="btn" style="background: #f5d9da;"/>
								<input type="reset" value="다시입력" class="btn" style="background: #f5d9da;"/>
								<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/videoContent?idx=${videoVo.SJ_VIDEO_IDX}&pag=${pag}&pageSize=${pageSize}';" style="background: #f5d9da;" class="btn"/>
							</td>
						</tr>
					</table>
					<input type="hidden" name="SJ_VIDEO_IDX" value="${vo.SJ_VIDEO_IDX}"/>
					<input type="hidden" name="pag" value="${pag}"/>
					<input type="hidden" name="pagSize" value="${pagSize}"/>
				</form>
			</div>
   	</div>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>