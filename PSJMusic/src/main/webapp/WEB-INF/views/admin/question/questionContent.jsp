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
  		if(ans) location.href="${ctp}/admin/qaDelete?idx=${vo.SJ_QUESTION_IDX}&pag=${pag}&pageSize=${pageSize}";
  	}
  	// 댓글입력
  	function replyCheck(){
  		var SJ_QUESTION_IDX = "${vo.SJ_QUESTION_IDX}";
  		var SJ_USER_MID = "${sMid}";
  		var SJ_QUESTIONRE_CONTENT = replyForm.SJ_QUESTIONRE_CONTENT.value;
  		if(SJ_QUESTIONRE_CONTENT == ""){
  			alert("댓글을 입력하세요");
  			replyForm.SJ_QUESTIONRE_CONTENT.focus();
  			return false;
  		}
  		var query = {
  				SJ_QUESTION_IDX : SJ_QUESTION_IDX,
  				SJ_USER_MID : SJ_USER_MID,
  				SJ_QUESTIONRE_CONTENT : SJ_QUESTIONRE_CONTENT
  		}
  		$.ajax({
  			type : "post",
  			url : "${ctp}/admin/qaReplyInsert",
  			data : query,
  			success:function(){
  				location.reload();
  			}
  		});
  	}
	
  	// 답변글(부모댓글의 댓글)
  	function updateOpen(idx){
  		var insReply = "";
  		insReply += "<div class='w3-container' id='showcase'>";
  		insReply += "<table style='width:90%'>";
  		insReply += "<tr>";
  		insReply += "<td>";
  		insReply += "<div class='form-group'>";
  		insReply += "<label for='content'>수정폼:</label> &nbsp;";
  		insReply += "<textarea rows='3' class='form-control' name='SJ_QUESTIONRE_CONTENT' id='SJ_QUESTIONRE_CONTENT"+idx+"'></textarea>";
  		insReply += "</div>";
  		insReply += "</td>";
  		insReply += "<td>";
  		insReply += "<input type='button' value='수정하기' class='btn btn-sm' style='background: #f5d9da;' onclick='replyCheck2("+idx+")'/>";
  		insReply += "</td>";
  		insReply += "</tr>";
  		insReply += "</table>";
  		insReply += "<hr style='margin:0px'/>";
  		insReply += "</div>";
  		
  		$("#replyUpdateOpen"+idx).hide();
  		$("#replyUpdateClose"+idx).show();
  		$("#replyBox"+idx).slideDown(500);
  		$("#replyBox"+idx).html(insReply);
  	}
  	
  	// 대댓글 입력폼 닫기 처리(대댓글에 해당하는 가상 테이블을 보이지 않게 처리한다)
  	function updateClose(idx){
  		$("#replyUpdateOpen"+idx).show();
  		$("#replyUpdateClose"+idx).hide();
  		$("#replyBox"+idx).slideUp(500);
  	}
  	
  	// 수정하기
  	function replyCheck2(idx){
  		var SJ_QUESTIONRE_IDX = idx;
  		var SJ_USER_MID = "${sMid}";
  		var SJ_QUESTIONRE_CONTENT = "SJ_QUESTIONRE_CONTENT"+idx;
  		var contentVal = $("#"+SJ_QUESTIONRE_CONTENT).val();
  		
  		if(SJ_QUESTIONRE_CONTENT == ""){
  			alert("댓글을 입력하세요");
  			$("#"+SJ_QUESTIONRE_CONTENT).focus();
  			return false;
  		}
  		var query = {
  				SJ_QUESTIONRE_IDX : SJ_QUESTIONRE_IDX,
  				SJ_USER_MID : SJ_USER_MID,
  				SJ_QUESTIONRE_CONTENT : contentVal
  		}
  		
  		$.ajax({
  			type : "post",
  			url : "${ctp}/admin/qaReplyInsert2",
  			data : query,
  			success:function(){
  				location.reload();
  			}
  		});
  	}
  	
  	// 댓글 삭제하기
  	function replyDelCheck(replyIdx){
  		var ans = confirm("선택하신 댓글을 삭제 하시겠습니까?");
  		if(!ans) return false;
  		
  		$.ajax({
  			type : "post",
  			url : "${ctp}/admin/qaReplyDelete",
  			data : {replyIdx : replyIdx},
  			success:function(){
  				location.reload();
  			},
  			error : function(){
  				alert("전송오류");
  			}
  		});
  	}
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav/adminNav.jsp"/>
	<div class="w3-container">
	<div id="section">
			<div class="container">
	    <h1 style="text-align:center; color: #626262;">${vo.SJ_QUESTION_TITLE}</h1>
	    <p><br/></p>
		    <table class="table">
		      <tbody>
			      <tr class="text-right">
			        <td>
			          ${vo.SJ_QUESTION_WHAT}
			        </td>
			      </tr>
			      <tr>
			        <td colspan="2" style="height:200px;">
			          <br><br>
			          ${vo.SJ_QUESTION_CONTENT}
			          <br><br>
			        </td>
			      </tr>
			      <tr class="text-center">
			        <td class="con2" colspan="2">
			          <br>
			            <input class="btn" type="button" value="돌아가기" style="background: #f5d9da;color:black;" onclick="location.href='${ctp}/service/qaList';"/>
			        </td>
			      </tr>
		   		</tbody>
		    </table>
		    
				<!-- 댓글 출력/입력 처리부분 -->
		    <!-- 댓글 출력 -->
		    <c:forEach var="rVo" items="${rVos}">
			    <table class="table">
				    <tbody>
				    	<tr>
				        <th>관리자 답변</th>
				        <td>
					        <c:if test="${sMid == rVo.SJ_USER_MID}">
					        	<input type="button" value="수정" id="replyUpdateOpen${rVo.SJ_QUESTIONRE_IDX}" onclick="updateOpen('${rVo.SJ_QUESTIONRE_IDX}')" class="btn btn-sm" style="background: #f5d9da;"/> 
										<input type="button" value="닫기" id="replyUpdateClose${rVo.SJ_QUESTIONRE_IDX}" onclick="updateClose(${rVo.SJ_QUESTIONRE_IDX})" class="replyBoxClose btn btn-sm" style="display:none;background: #f5d9da;" /> 
							  	</c:if>
									<c:if test="${sMid == rVo.SJ_USER_MID}">
									  <a href="javascript:replyDelCheck(${rVo.SJ_QUESTIONRE_IDX})" class="btn btn-sm" style="background: #f5d9da;">삭제</a>
							  	</c:if>
				        </td>
				        <th style="text-align:center;width:15%;">작성일</th>
				        <td style="width:28%;">${rVo.SJ_QUESTIONRE_DATE}</td>
				      </tr>
				      <tr style="border-bottom: 1px solid #EAEAEA; text-align:left;">
				        <td colspan="4">${fn:replace(rVo.SJ_QUESTIONRE_CONTENT,newLine,'<br/>')}</td>
				      </tr>
				      <tr>
								<td colspan="5"><div id="replyBox${rVo.SJ_QUESTIONRE_IDX}"></div></td>
							</tr>
				 	 </tbody>
			   </table>
		 	 </c:forEach>
			<!-- 댓글 입력 -->
			<c:if test="${sMid == 'admin'}">
				<form name="replyForm" id="replyForm" method="post">
					<div class="w3-row-padding">
					  <div class="w3-col m12">
					    <div class="w3-round w3-white">
						    <div class="w3-container w3-padding">
						      <h6 class="w3-opacity"></h6>
						      <textarea rows="4" name="SJ_QUESTIONRE_CONTENT" id="SJ_QUESTIONRE_CONTENT" class="form-control"></textarea>
						      <br/>
						      <div>
							      <input type="button" value="댓글달기" onclick="replyCheck()" style="background: #f5d9da;" class="btn "/>
						   		</div>
						    </div>
						    <input type="hidden" name="SJ_QUESTION_IDX" value="${vo.SJ_QUESTION_IDX}"/>
								<input type="hidden" name="SJ_USER_MID" value="${sMid}"/>
					    </div>
				    </div>
			    </div>
		    </form>
	    </c:if>
			</div>	
   	</div>
	</div>	
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>