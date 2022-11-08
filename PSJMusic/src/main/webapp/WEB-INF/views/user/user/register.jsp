<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>약관동의</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<script src="${ctp}/js/register.js"></script>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/register.css">
	<link rel="stylesheet" href="${ctp}/css/font.css">
</head>
<body><jsp:include page="/WEB-INF/views/include/nav/userNav.jsp"/>
<div class="terms-form">
	<h2 class="text-center"><b>회원가입</b></h2>
	<form name="myForm" method="post">
		<div class="container" style="margin-top:50px;">
			<div style="height:100px; width:555px; margin:0 auto">
		      	<div style="width:100px; float: none; position: absolute; text-align:center; left: 35%;">
		          <i class="fa-solid fas fa-edit" style="font-size:25px;"></i><br>
		          <p style="margin-top:15px"><b>약관동의</b><br/></p>
		      	</div>
		      	<div style="width:50px; float: none; position: absolute; text-align:center; left: 43%;">
		          <i class="fa-solid fas fa-angle-right" style="font-size:25px;"></i>
		      	</div>
		      	<div style="width:100px; float: none; position: absolute; text-align:center; left: 47%;">
		          <i class="fa-solid fas fa-pencil-alt" style="font-size:25px;"></i><br/>
		          <p style="color: #777777; margin-top:15px"><b>회원정보 입력</b></p>
		      	</div>
		      	<div style="width:50px; float: none; position: absolute; text-align:center; left: 55%;">
		          <i class="fa-solid fas fa-angle-right" style="font-size:25px;"></i>
		      	</div>
		      	<div style="width:100px; float: none; position: absolute; text-align:center; left: 60%;">
		          <i class="fa-solid fas fa-check" style="font-size:25px;"></i><br/>
		          <p style="color: #777777; margin-top:15px"><b>완료</b></p>
		      	</div>
		     </div>
		</div>
		<h3 style="color:#00256C"><b>약관동의</b></h3>
		<p style="font-size:15px; color:#555555; margin-top:15px"><b>약관 및 개인정보 수집 이용에 동의 해주세요.</b></p>
		<br>
		<div id="checkWrap">
			<label for="cheeck01"><input type="checkbox" id="cheeck01">&nbsp;<b>전체 동의</b></label>
			<br>
		  	<p style="width:200px; font-size:14px; margin-top: 15px"><b>[필수 1]</b><span style="color:red">&nbsp;*</span></p>  
			<div class="box">
				<p>약관1 내용 <br/><br/>나를 웃게 만들어 주는 생각을 하자. 당신이 어떤 생각을 하느냐에 따라서 얼굴이 달라집니다. 긍정적인 생각을 많이 하면 웃고 있는 사람이 되지만 부정적인 생각으로 하루를 보내면 화난 사람이 되는 것입니다. 잠시 거울을 보세요. 어떤 표정을 짓고 있나요? 마치 화난듯한 표정을 짓고 있다면 웃어 보세요. 거울 보고 웃는 자신의 표정이 어색해 보이는 것은 그동안 웃지 않았기 때문입니다. 이 글을 읽는 순간에도 자신의 얼굴을 기억해 보시길 바랍니다. 길을 걸을 때, 일할 때, 밥 먹을 때 아침에 일어나서 잠들기 전까지 웃음을 잃지 않도록 노력합시다. 이 글을 보고 계시다면 나쁜 생각은 머릿속에서 지우고 긍정적이며 행복한 생각들로 머리를 채워 보시길 바랍니다. 행복은 항상 멀리 있지 않습니다.</p>
			</div>
			<label for="cheeck02"><input type="checkbox" id="cheeck02" name="check" style="margin-bottom:15px">&nbsp;<b>동의함</b></label>
			<br/>
		  <p style="width:300px; font-size:14px; margin-top: 15px"><b>[필수 2]</b><span style="color:red">&nbsp;*</span></p>  
			<div class="box">		
				<p>약관2 내용 <br/><br/>자유로운 것은 어떤 틀이나 기준을 세우지 않을 때 가능합니다. 내가 세워놓은 틀에 맞춰서 타인의 행동이나 생각을 평가하면 오해를 하거나 잘못된 판단을 할 수 있습니다. "그건 아니지"라는 기준보다 "그럴 수도 있구나"라는 열린 마음으로 세상을 바라보면 부정의 생각보다 긍정적인 마음을 가질 수 있습니다.</p>
			</div>	
			<label for="cheeck03"><input type="checkbox" id="cheeck03" name="check" style="margin-bottom:15px">&nbsp;<b>동의함</b></label>
			<br>
		  	<p style="width:300px; font-size:14px; margin-top: 15px"><b>[선택 1]</b></p>  
			<div class="box">		
				<p>선택사항 동의 <br/><br/>"우와 대단해"<br/>"네가 최고야"<br/>"할 수 있어"</p>
			</div>	
			<label for="cheeck04"><input type="checkbox" id="cheeck04" name="check" style="margin-bottom:15px">&nbsp;<b>동의함</b></label>
			<br>
		</div>
		<div style="width:520px; margin:0 auto; margin-top:30px">
			<button type="button" onclick="location.href='${ctp}/user/login';" style="color:#013066; background-color:#FFFFFF; width:250px; height:60px; margin-right:5px; font-size:15px"><b>취소</b></button> 
			<button type="button" onclick="fCheck()" style="color:#FFFFFF; background-color:#013066; width:250px; height:60px; margin-left:5px; font-size:15px"><b>확인</b></button> 
		</div>
	</form>
</div>
<br><br>
<!-- Footer -->
<footer class="w3-container w3-padding-64 w3-center w3-opacity w3-light-grey w3-xlarge">
  <p class="w3-medium">Made by 성재</p>
</footer>
</body>
</html>