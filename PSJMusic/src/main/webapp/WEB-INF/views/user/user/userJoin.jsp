<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입화면</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<script src="${ctp}/js/join.js"></script>
		<link rel="stylesheet" href="${ctp}/css/join.css">
	<link rel="stylesheet" href="${ctp}/css/font.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav/userNav.jsp"/>
	<div class="container" style="margin-top:20px;">
		<div style="height:100px; width:555px; margin:0 auto">
      	<div style="width:100px; float: none; position: absolute; text-align:center; left: 35%;">
          <i class="fa-solid fas fa-edit" style="font-size:25px;"></i><br>
          <p style="color: #777777; margin-top:15px"><b>약관동의</b><br/></p>
      	</div>
      	<div style="width:50px; float: none; position: absolute; text-align:center; left: 43%;">
          <i class="fa-solid fas fa-angle-right" style="font-size:25px;"></i>
      	</div>
      	<div style="width:100px; float: none; position: absolute; text-align:center; left: 47%;">
          <i class="fa-solid fas fa-pencil-alt" style="font-size:25px;"></i><br/>
          <p style="margin-top:15px"><b>회원정보 입력</b></p>
      	</div>
      	<div style="width:50px; float: none; position: absolute; text-align:center; left: 55%;">
          <i class="fa-solid fas fa-angle-right" style="font-size:25px;"></i>
      	</div>
      	<div style="width:100px; height:100%; float: none; position: absolute; text-align:center; left: 60%;">
          <i class="fa-solid fas fa-check" style="font-size:25px;"></i><br/>
          <p style="color: #777777; margin-top:15px"><b>완료</b></p>
      	</div>
     </div>
    <div class="bg-white" style=" text-align: center; width: 100%">
			<form name="myform"  style="display: inline-block; border: none;" method="post" class="was-validated bg-white" >
	      <h1 class="font-weight-bold" ><a href="${ctp}/member/join" id="jojo">REGISTRATION</a></h1>
	        <div>
	          <label for="SJ_USER_MID"><b>아이디</b><font size="2px" color="#AF4034"> *</font></label>
	        </div>
	        <div>
	          <input type="text" class="form-control" name="SJ_USER_MID" id="SJ_USER_MID" onkeyup="idReset()" placeholder="아이디를 입력해주세요" min="4" maxlength="20" autofocus required />
	          <div class="valid-feedback"></div>
	          <div class="invalid-feedback"  style="text-align: left;">아이디는 영문 또는 숫자를 포함하여 4 ~ 20자로 작성해주세요</div>
	        </div>
	        <div class="text-left" style="padding-top: 3px; padding-right: 3px;">
	          <input type="button" class="bubu" name="btnIdCheck" value="중복체크" onclick="idCheck()" />
	        </div>
	        <br/>
	        <div>
	          <label for="SJ_USER_PWD"><b>비밀번호</b><font size="2px" color="#AF4034"> *</font></label>
	        </div>
	        <div>
	          <input type="password" class="form-control" name="SJ_USER_PWD" id="SJ_USER_PWD" placeholder="비밀번호를 입력해주세요" min="4" maxlength="20" required />
	          <div class="valid-feedback"></div>
	          <div class="invalid-feedback" style="text-align: left;">비밀번호는 영문, 숫자, 특수문자를 포함하여 6 ~ 20자로 작성해주세요</div>
	        </div>
	        <div>
	          <input type="password" class="form-control" name="pwdTest" id="pwdTest" placeholder="비밀번호를 확인해주세요" min="8" maxlength="20" required />
	          <div class="valid-feedback"></div>
	          <div class="invalid-feedback" style="text-align: left;">입력하신 비밀번호와 일치하게 입력해주세요</div>
	       	</div>
	        <br/>
	        <div>
	          <label for="SJ_USER_NICKNAME"><b>이름/닉네임</b><font size="2px" color="#AF4034"> *</font></label>
	        </div>   
	        <div>
	          <input type="text" class="form-control" name="SJ_USER_NICKNAME" id="SJ_USER_NICKNAME" placeholder="이름 또는 닉네임을 입력해주세요" min="1" maxlength="20" required />
	        </div>
	        <br/>
	         <div>
	          <label for="SJ_USER_EMAIL"><b>이메일</b><font size="2px" color="#AF4034"> *</font></label><br/>
	        </div>
	        <div>
	          <input type="text" class="form-control" name="SJ_USER_EMAIL" id="SJ_USER_EMAIL" onkeyup="emailReset()" placeholder="예) name@example.com" required />
	          <div class="valid-feedback"></div>
	          <div class="invalid-feedback" style="text-align: left;">이메일은 비밀번호 찾기에 사용됩니다</div>
	        </div>
	        <div class="text-left" style="padding-top: 3px; padding-right: 3px;">
	          <input type="button" class="bubu" name="btnIdCheck" value="중복체크" onclick="emailCheck()" />
	        </div>
	        <br/>
	        <div>
	          <label for="SJ_USER_NUMBER"><b>휴대 전화</b><font size="2px" color="#AF4034"> *</font></label><br/>
	        </div>
	        <div class="input-group mb-3">
	          <input class="form-control" type="text" name="getCode1" id="getCode1" required  min="2" maxlength="3" />
	          <font style="margin-top: 17px;">-</font>
	          <input class="form-control" type="text" name="getCode2" id="getCode2" required  min="2" maxlength="4" />
	          <font style="margin-top: 17px;">-</font>
	          <input class="form-control" type="text" name="getCode3" id="getCode3" required  min="3" maxlength="4" />
	        </div>
	        <br/>
	        <div>
	          <input style="text-align:center;" type="button" id="joinbtn" value="가입하기" onclick="joinCheck()">
	        </div>
	        <br/>
 					<input type="hidden" name="SJ_USER_NUMBER"/>
			</form>
		  <p class="w3-medium">Made by 성재</p>
    </div> 
  </div> 
</body>
</html>