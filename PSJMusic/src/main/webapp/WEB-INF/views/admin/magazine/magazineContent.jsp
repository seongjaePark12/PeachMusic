<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매거진 내용</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<script>
		// 선택항목 삭제하기(ajax)
		function selectDelCheck(idx){
			var ans = confirm("선택된 매거진를 삭제 하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "../admin/magazineListDel",
				data:{idx:idx},
				success:function(){
					location.href='${ctp}/admin/main?sw=3&pag=${pag}&pageSize=${pageSize}';
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
	    <h1 style="text-align:center; color: #626262;">${vo.SJ_MAGAZINE_TITLE}</h1>
	    <p><br/></p>
		    <table class="table">
		      <tbody>
			      <tr>
			        <td colspan="2" style="height:200px;">
			          <br><br>
			          ${vo.SJ_MAGAZINE_CONTENT}
			          <br><br>
			        </td>
			      </tr>
			      <tr class="text-center">
			        <td class="con2" colspan="2">
			          <br>
			            <input class="btn" type="button" value="돌아가기" style="background: #f5d9da;;color:black;" onclick="location.href='${ctp}/admin/main?sw=3&pag=${pag}&pageSize=${pageSize}';"/>
			        		<input class="btn" type="button" value="수정" style="background: #f5d9da;;color:black;" onclick="location.href='${ctp}/admin/magazinUpdate?idx=${vo.SJ_MAGAZINE_IDX}&pag=${pag}&pageSize=${pageSize}';"/>
			     				<input class="btn" type="button" value="삭제" style="background: #f5d9da;;color:black;" onclick="selectDelCheck(${vo.SJ_MAGAZINE_IDX})"/>
			        </td>
			      </tr>
		   		</tbody>
		    </table>
			</div>	
   	</div>
</body>
</html>