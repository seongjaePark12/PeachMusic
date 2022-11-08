<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	<h2 style="text-align: center;">배너 관리</h2>
	<div class="text-right">1200x675사이즈 추천</div>
		<div id="upload"><input type="button" value="업로드" onclick="location.href='${ctp}/admin/bannerInput'" id="uplo"></div>
			<form method="post" name="bannerForm">
				<c:forEach var="BannerVo" items="${BannerVos}">
					<c:if test="${BannerVo.SJ_BANNER_FLAG == 'OK'}"><div class="w3-center"><b style="color: rgb(216, 148, 148); border: 2px;">♥선택중인 배너♥</b></div></c:if>
					<div id="frame">
						<div class="part"><img src="${ctp}/data/banner/${fn:split(BannerVo.SJ_BANNER_RFILE,'/')[0]}" style="width:100%; height:100%;"></div>
						<div class="part"><img src="${ctp}/data/banner/${fn:split(BannerVo.SJ_BANNER_RFILE,'/')[1]}" style="width:100%; height:100%;"></div>
						<div class="part"><img src="${ctp}/data/banner/${fn:split(BannerVo.SJ_BANNER_RFILE,'/')[2]}" style="width:100%; height:100%;"></div>
						<c:if test="${BannerVo.SJ_BANNER_FLAG == 'OK'}">
							<div style="float:left" class="btn2"><input type="button" value="배너해제" onclick="upload(${BannerVo.SJ_BANNER_IDX},'NO')" class="btn22"></div>
						</c:if>
						<c:if test="${BannerVo.SJ_BANNER_FLAG == 'NO'}">
							<div style="float:left" class="btn2"><input type="button" value="배너선택" onclick="upload(${BannerVo.SJ_BANNER_IDX},'OK')" class="btn22"></div>
						</c:if>
						<div style="float:left; margin-top:20px; " class="btn2"><input type="button" value="배너삭제" onclick="bannerDelete(${BannerVo.SJ_BANNER_IDX})" class="btn22"></div>
					</div>
				</c:forEach>
			</form>