<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 내용</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<script>
  	// 게시글 삭제
  	function delCheck(){
  		var ans = confirm("게시글을 삭제하시겠습니까?");
  		if(ans) location.href="${ctp}/admin/noticeDelete?idx=${vo.SJ_NOTICE_IDX}&pag=${pag}&pageSize=${pageSize}";
  	}
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav/adminNav.jsp"/>
	<div id="section">
			<div class="container">
				<h2 style="text-align:center; color: #626262;"><a href="${ctp}/admin/main?sw=5" style="text-decoration: none;">NOTICE</a></h2>
	    <br>
	    <p style="text-align:center; color: #626262;">피치뮤직 공지사항입니다.</p>
	    <p><br/></p>
		    <table class="table">
		      <tbody>
			      <tr class="text-center">
			        <th class="con1" style="background: #f5d9da;;color:black;">제목</th>
			        <td class="con2">${vo.SJ_NOTICE_TITLE}</td>
			      </tr>
			      <tr class="text-center">
			        <th class="con1" style="background: #f5d9da;;color:black;">작성자</th>
			        <td class="con2">${vo.SJ_NOTICE_NAME}</td>
			      </tr>
			      <tr>
			        <td colspan="2" align="right" style="color:#818381;">
			          작성일 &nbsp;<span class="bb">${fn:substring(vo.SJ_NOTICE_DATENOW,0,19)}</span>
			        </td>
			      </tr>
			      <tr>
			        <td colspan="2" style="height:200px;">
			          <br><br>
			          ${fn:replace(vo.SJ_NOTICE_CONTENT,newLine,'<br/>')}
			          <br><br>
			        </td>
			      </tr>
			      <tr class="text-center">
			        <td class="con2" colspan="2">
			          <br>
			            <input class="btn" type="button" value="돌아가기" style="background: #f5d9da;;color:black;" onclick="location.href='${ctp}/admin/main?sw=5&pag=${pag}&pageSize=${pageSize}';"/>
			        		<input class="btn" type="button" value="수정" style="background: #f5d9da;;color:black;" onclick="location.href='${ctp}/admin/noticeUpdate?idx=${vo.SJ_NOTICE_IDX}&pag=${pag}&pageSize=${pageSize}';"/>
			     				<input class="btn" type="button" value="삭제" style="background: #f5d9da;;color:black;" onclick="delCheck()"/>
			        </td>
			      </tr>
		   		</tbody>
		    </table>
		    <br/>
		    <%-- <c:if test="${sw != 'search'}"> --%>
		    <table class="table">
			  	<tbody>
				  	<tr style="border-bottom: 1px solid #E2E2E2;">
				  		<th class="con1">다음글</th>
				  		<td class="con2" align="left" style="padding-left: 30px;">
				  			<c:if test="${!empty pnVos[1]}">
									<a href="${ctp}/admin/noticeContent?idx=${pnVos[1].SJ_NOTICE_IDX}&pag=${pag}&pageSize=${pageSize}">${pnVos[1].SJ_NOTICE_TITLE}</a><br/>
								</c:if>
				  		</td>
				  	</tr>
				  	<tr>
				  		<th class="con1">이전글</th>
				  		<td class="con2" align="left" style="padding-left: 30px;">
				  			<c:if test="${!empty pnVos[0]}">
									<a href="${ctp}/admin/noticeContent?idx=${pnVos[0].SJ_NOTICE_IDX}&pag=${pag}&pageSize=${pageSize}">${pnVos[0].SJ_NOTICE_TITLE}</a><br/>
								</c:if>
				  		</td>
				  	</tr>
		  		</tbody>
		  	</table>
			</div>
   	</div>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>