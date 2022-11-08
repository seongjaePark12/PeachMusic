<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>피치뮤직 메거진</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/font.css">
	<link rel="stylesheet" href="${ctp}/css/main.css">
		<script>
  	// 댓글입력
  	function replyCheck(){
  		var SJ_MAGAZINE_IDX = "${vo.SJ_MAGAZINE_IDX}";
  		var SJ_USER_NICKNAME = "${sNickName}";
  		var SJ_MAGAZINERE_CONTENT = replyForm.SJ_MAGAZINERE_CONTENT.value;
  		if(SJ_MAGAZINERE_CONTENT == ""){
  			alert("댓글을 입력하세요");
  			replyForm.SJ_MAGAZINERE_CONTENT.focus();
  			return false;
  		}
  		var query = {
  				SJ_MAGAZINE_IDX : SJ_MAGAZINE_IDX,
  				SJ_USER_NICKNAME : SJ_USER_NICKNAME,
  				SJ_MAGAZINERE_CONTENT : SJ_MAGAZINERE_CONTENT
  		}
  		$.ajax({
  			type : "post",
  			url : "${ctp}/service/magazineReplyInsert",
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
  		insReply += "<textarea rows='3' class='form-control' name='SJ_MAGAZINERE_CONTENT' id='SJ_MAGAZINERE_CONTENT"+idx+"'></textarea>";
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
  		var SJ_MAGAZINERE_IDX = idx;
  		var SJ_USER_NICKNAME = "${sNickName}";
  		var SJ_MAGAZINERE_CONTENT = "SJ_MAGAZINERE_CONTENT"+idx;
  		var contentVal = $("#"+SJ_MAGAZINERE_CONTENT).val();
  		
  		if(SJ_MAGAZINERE_CONTENT == ""){
  			alert("댓글을 입력하세요");
  			$("#"+SJ_MAGAZINERE_CONTENT).focus();
  			return false;
  		}
  		var query = {
  				SJ_MAGAZINERE_IDX : SJ_MAGAZINERE_IDX,
  				SJ_USER_NICKNAME : SJ_USER_NICKNAME,
  				SJ_MAGAZINERE_CONTENT : contentVal
  		}
  		
  		$.ajax({
  			type : "post",
  			url : "${ctp}/service/magazineReplyInsert2",
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
  			url : "${ctp}/service/magazineReplyDelete",
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
<!-- top -->
	<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
<!-- nav -->
	<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
	<div class="w3-container">
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
		            <input class="btn" type="button" value="돌아가기" style="background: #f5d9da;color:black;" onclick="location.href='${ctp}/service/magazineMain';"/>
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
			        <th>${rVo.SJ_USER_NICKNAME} | ${fn:substring(rVo.SJ_MAGAZINERE_DATE,0,10)}</th>
			        <th>
				        <c:if test="${sNickName == rVo.SJ_USER_NICKNAME}">
				        	<input type="button" value="수정" id="replyUpdateOpen${rVo.SJ_MAGAZINERE_IDX}" onclick="updateOpen('${rVo.SJ_MAGAZINERE_IDX}')" class="btn btn-sm" style="background: #f5d9da;"/> 
									<input type="button" value="닫기" id="replyUpdateClose${rVo.SJ_MAGAZINERE_IDX}" onclick="updateClose(${rVo.SJ_MAGAZINERE_IDX})" class="replyBoxClose btn btn-sm" style="display:none;background: #f5d9da;" /> 
						  	</c:if>
								<c:if test="${sNickName == rVo.SJ_USER_NICKNAME}">
								  <a href="javascript:replyDelCheck(${rVo.SJ_MAGAZINERE_IDX})" class="btn btn-sm" style="background: #f5d9da;">삭제</a>
						  	</c:if>
			        </th>
			      </tr>
			      <tr style="border-bottom: 1px solid #EAEAEA; text-align:left;">
			        <td colspan="4">${fn:replace(rVo.SJ_MAGAZINERE_CONTENT,newLine,'<br/>')}</td>
			      </tr>
			      <tr>
							<td colspan="5"><div id="replyBox${rVo.SJ_MAGAZINERE_IDX}"></div></td>
						</tr>
			 	 </tbody>
		   </table>
	 	 </c:forEach>
		<!-- 댓글 입력 -->
		<c:if test="${sMid != null}">
			<form name="replyForm" id="replyForm" method="post">
				<div class="w3-row-padding">
				  <div class="w3-col m12">
				    <div class="w3-round w3-white">
					    <div class="w3-container w3-padding">
					      <h6 class="w3-opacity"></h6>
					      <textarea rows="4" name="SJ_MAGAZINERE_CONTENT" id="SJ_MAGAZINERE_CONTENT" class="form-control"></textarea>
					      <br/>
					      <div>
						      <input type="button" value="댓글달기" onclick="replyCheck()" class="btn" style="background: #f5d9da;"/>
					   		</div>
					    </div>
					    <input type="hidden" name="SJ_MAGAZINE_IDX" value="${vo.SJ_MAGAZINE_IDX}"/>
							<input type="hidden" name="SJ_USER_NICKNAME" value="${sNickName}"/>
				    </div>
			    </div>
		    </div>
	    </form>
    </c:if>
		</div>	
  </div>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
</body>
</html>
