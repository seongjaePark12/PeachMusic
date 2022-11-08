<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	function tagCheck(){
		srchmainform.submit();
	}
</script>
	<div class="main-header">
		<form name="srchmainform" method="post" action="${ctp}/music/musicsech">
			<div>
				<a href="${ctp}/"><img src="${ctp}/images/title/logo.png"></a>
				<a href="javascript:tagCheck()" class="w3-right" style="margin-top: 70px; color: #f5d9da"><i class="fa fa-search"></i></a>
				<input type="text" id="srchKwd" name="srchKwd" class="w3-input w3-round w3-right" style="width: 300px;height:40px;color:black;font-size: 18px;margin-top: 70px;" placeholder="여러분의 노래는 무엇인가요?">
			</div>
		</form>
	</div>
	<nav>
		<div class="nav">
			<ul class="nav_menu">
				<li>
					<h5><a href="${ctp}/music/chart"><b>피치차트</b></a></h5>
				</li>
				<li>
					<h5><a href="${ctp}/music/latest"><b>최신음악</b></a></h5>
				</li>
				<li>
					<h5><a href="${ctp}/music/genre"><b>장르음악</b></a></h5>
				</li>
				<li>
					<h5><a href="${ctp}/music/songrank"><b>인기추천</b></a></h5>
				</li>
				<li>
					<h5><a href="${ctp}/service/videoMain"><b>피치TV</b></a></h5>
				</li>
				<li>
					<h5><a href="${ctp}/service/magazineMain"><b>매거진</b></a></h5>
				</li>
			</ul>
		</div>
	</nav>