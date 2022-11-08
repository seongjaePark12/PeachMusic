<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비디오 내용</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<script>
	// 선택항목 삭제하기(ajax)
		function selectDelCheck(idx){
			var ans = confirm("선택된 비디오를 삭제 하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "../admin/videoListDel",
				data:{idx:idx},
				success:function(){
					location.href='${ctp}/admin/main?sw=2&pag=${pag}&pageSize=${pageSize}';
				},
				error:function(){
					alert("전송오류");
				}
			});			
		}
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav/adminNav.jsp"/>
	<div id="section">
			<div class="container">
			<div><h1 style="text-align:center; color: #626262;">피치TV</h1></div><hr/>
			<div>
		    <h2 style="text-align:center;"><b>${vo.SJ_VIDEO_TITLE}</b></h2>
			</div>
	    <p><br/></p>
		    <table class="table">
		      <tbody>
			      <tr class="text-center">
			        <td>${vo.SJ_VIDEO_LINK}</td>
			      </tr>
			      <tr class="text-center">
			        <td class="con1">${vo.SJ_VIDEO_ARTIST}</td>
			      </tr>
			      <tr class="text-center">
			        <td class="con1">${vo.SJ_VIDEO_ALBUM}</td>
			      </tr>
			      <tr class="text-center">
			        <td class="con2" colspan="2">
			          <br>
			            <input class="btn" type="button" value="돌아가기" style="background: #f5d9da;;color:black;" onclick="location.href='${ctp}/admin/main?sw=2&pag=${pag}&pageSize=${pageSize}';"/>
			        		<input class="btn" type="button" value="수정" style="background: #f5d9da;;color:black;" onclick="location.href='${ctp}/admin/videoUpdate?idx=${vo.SJ_VIDEO_IDX}&pag=${pag}&pageSize=${pageSize}';"/>
			     				<input class="btn" type="button" value="삭제" style="background: #f5d9da;;color:black;" onclick="selectDelCheck(${vo.SJ_VIDEO_IDX})"/>
			        </td>
			      </tr>
		   		</tbody>
		    </table>
		    <br/>
			</div>
   	</div>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>