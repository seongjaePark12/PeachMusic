<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<form name="userform" method="post">
		<h2 style="text-align: center;">회원 리스트</h2>
		<table class="table table-boderless m-0">
			<tr>
				<td style="text-align: left">
					<input type="checkbox" id="checkAll"/>전체선택/해제 &nbsp;
					<input type="button" value="선택회원 삭제" onclick="selectDelCheck()" class="btn btn-sm" style="background: #f5d9da;"/>
				</td>
				<td style="text-align: right;">
					<input type="text" name="mid" value="${mid}" placeholder="검색할아이디입력"/>
					<input type="button" value="개별검색" onclick="midSearch()" class="btn btn-sm" style="background: #f5d9da;"/>
					<input type="button" value="전체보기" onclick="location.href='${ctp}/admin/main?sw=4';" class="btn btn-sm" style="background: #f5d9da;"/>
				</td>
			</tr>
		</table>
		<table class="table table-hover">
			<tr class="text-dark text-center" style="background: #f5d9da;">
				<th>선택</th>
				<th>아이디</th>
				<th>이름/별명</th>
				<th>연락처</th>
				<th>이메일</th>
				<th>탈퇴여부</th>
			</tr>
			<c:forEach var="uservo" items="${uservos}">
				<tr class="text-center">
					<td><input type="checkbox" name="chk" class="chk" value="${uservo.SJ_USER_IDX}"/></td>
					<td>${uservo.SJ_USER_MID}</td>
					<td>${uservo.SJ_USER_NICKNAME}</td>
					<td>${uservo.SJ_USER_NUMBER}</td>
					<td>${uservo.SJ_USER_EMAIL}</td>
					<td>
						<c:if test="${uservo.SJ_USER_DEL=='OK'}"><font color=red>탈퇴신청</font></c:if>
	    	    <c:if test="${uservo.SJ_USER_DEL!='OK'}">활동중</c:if>
    	    </td>
				</tr>
			</c:forEach>
		</table>
</form>  