<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	<h2 style="text-align: center;">차트 업데이트</h2>
		<div class="mt-5">
		<c:set var="ok" value="0" />
		<P class="h4">업데이트 필요한 곡</p>
			<table class="table">
					<tr>
						<td><div type="button" class="btn" title="현재 시각 차트로 업데이트 합니다" onclick="chartUpdate()" style="background: #f5d9da;">차트 업데이트</div></td>
						<td><button class="btn" type="button" title="아래 내용 모두를 데이터베이스에 추가 합니다" onclick="addall()" style="background: #f5d9da;">모두 추가</button></td>
					</tr>
				<c:forEach var="vo" items="${vos }" varStatus="st">
					<c:if test="${vo.SJ_SONG_IDX == 0 }">
						<tr>
							<td><img src="${vo.SJ_CHART_IMG}" width="50px;"></td>
							<td>
								<c:if test="${fn:length(vo.SJ_CHART_TITLE) < 20 }">${vo.SJ_CHART_TITLE }</c:if> 
								<c:if test="${fn:length(vo.SJ_CHART_TITLE) >= 20 }">${fn:substring(vo.SJ_CHART_TITLE, 0, 20) }...</c:if> 
								- 
								<c:if test="${fn:length(vo.SJ_CHART_ARTIST) < 20 }">${vo.SJ_CHART_ARTIST }</c:if> 
								<c:if test="${fn:length(vo.SJ_CHART_ARTIST) >= 20 }">${fn:substring(vo.SJ_CHART_ARTIST, 0, 20) }...</c:if> 
							</td>
							<td>
								<button class="btn" style="background: #f5d9da;" type="button" onclick="adddb('${vo.SJ_CHART_IMG}', `${vo.SJ_CHART_TITLE }`, `${vo.SJ_CHART_ARTIST }`)">노래 업로드</button>
							</td>
							<c:set var="ok" value="${ok + 1 }" />
						</tr>
					</c:if>
				</c:forEach>
			</table>
		<c:if test="${ok == 0 }">업데이트가 필요한 곡이 없습니다.</c:if>
	</div>
