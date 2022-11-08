<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 수정</title>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/font.css">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<script>
    function fCheck() {
    	var SJ_QUESTION_TITLE = myform.SJ_QUESTION_TITLE.value;
    	var SJ_QUESTION_CONTENT = myform.SJ_QUESTION_CONTENT.value;
    	
    	if(SJ_QUESTION_TITLE.trim() == "") {
    		alert("게시글 제목을 입력하세요");
    		myform.SJ_QUESTION_TITLE.focus();
    	}
    	else {
    		myform.oriContent.value = document.getElementById("oriContent").innerHTML;
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<!-- top -->
	<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
<!-- nav -->
	<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
	<div class="w3-container">
		<div id="section">
				<form name="myform" method="post">
					<table class="table table-boderless">
						<tr>
							<td><h2>문의 수정</h2></td>
						</tr>
					</table>
					<table class="table">
						<tr>
							<th>글쓴이</th>
							<td>${sMid}</td>
						</tr>
						<tr>
							<th>글제목</th>
							<td><input type="text" name="SJ_QUESTION_TITLE" value="${vo.SJ_QUESTION_TITLE}" placeholder="글제목을 입력하세요" class="form-control" autofocus required /></td>
						</tr>
						<tr>
							<th>문의유형</th>
							<td>
								<select name="SJ_QUESTION_WHAT" id="SJ_QUESTION_WHAT" class="nice-select w3-round-xxlarge" required >
		              <option value="" disabled selected>문의유형</option>
		              <option value="음악업로드해주세요"${vo.SJ_QUESTION_WHAT=='음악업로드해주세요' ? 'selected' : ''}>음악업로드해주세요</option>
		              <option value="음원관련문의"${vo.SJ_QUESTION_WHAT=='음원관련문의' ? 'selected' : ''}>음원관련문의</option>
		              <option value="회원관련문의"${vo.SJ_QUESTION_WHAT=='회원관련문의' ? 'selected' : ''}>회원관련문의</option>
		              <option value="결제관련문의"${vo.SJ_QUESTION_WHAT=='결제관련문의' ? 'selected' : ''}>결제관련문의</option>
		              <option value="기타"${vo.SJ_QUESTION_WHAT=='기타' ? 'selected' : ''}>기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>글내용</th>
							<td><textarea rows="6" name="SJ_QUESTION_CONTENT" id="CKEDITOR" class="form-control" required >${vo.SJ_QUESTION_CONTENT}</textarea></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center">
								<input type="button" value="글올리기" onclick="fCheck()" class="btn" style="background: #f5d9da;"/>
								<input type="reset" value="다시입력" class="btn" style="background: #f5d9da;"/>
								<input type="button" value="돌아가기" onclick="location.href='${ctp}/service/qaList';" style="background: #f5d9da;" class="btn"/>
							</td>
						</tr>
					</table>
					<input type="hidden" name="SJ_USER_MID" value="${sMid}"/>
					<input type="hidden" name="SJ_QUESTION_IDX" value="${vo.SJ_QUESTION_IDX}"/>
					<input type="hidden" name="pag" value="${pag}"/>
					<input type="hidden" name="pagSize" value="${pagSize}"/>
					<input type="hidden" name="oriContent" />
					<div id="oriContent" style="display:none;">${vo.SJ_QUESTION_CONTENT}</div>
				</form>
			</div>
   	</div>
<script>
	CKEDITOR.replace("SJ_QUESTION_CONTENT", {
		uploadUrl:"${ctp}/admin/imageUpload",		/* 여러개의 그림파일을 드래그&드롭으로 처리 */
		filebrowserUploadUrl : "${ctp}/admin/imageUpload", /* 파일(이미지) 업로드시 처리 */
		height:400
	});
</script>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>