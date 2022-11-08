<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/font.css">
	<link rel="stylesheet" href="${ctp}/css/main.css">
</head>
<body>
	<!-- top -->
		<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
	<!-- nav -->
		<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
		
		<div class="w3-container">
	  	<div class="w3-content" style="max-width:1200px">
	  		<br/><br/>
				<h1 class="w3-center w3-margin-top">${vo.SJ_SONG_TITLE } 정보</h1>
    		 <br/><br/>
			<div>
				<c:if test="${empty vo.SJ_SONG_IDX }">	
					<h3 class=" pl-3 pt-4">준비중입니다.<span style="float: right;background-color: #f5d9da;" class="text-rigth btn" ><a href="javascript:history.back()">돌아가기</a></span></h3>
				</c:if>
				<c:if test="${!empty vo.SJ_SONG_IDX }">
					<h3 class=" pl-3 pt-4">${vo.SJ_SONG_TITLE }<span style="float: right;background-color: #f5d9da;" class="text-rigth btn"><a href="javascript:history.back()">돌아가기</a></span></h3>
					<p class=" pl-3">
						노래 | ${vo.SJ_SONG_ARTIST } | ${vo.SJ_SONG_DATE }
						<c:if test="${empty sMid }">
				            <button id="songlike_btn1" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
				            <button id="songlike_btn2" style="display: none;" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
			        	</c:if>
			        	<c:if test="${fn:contains(vo.SJ_SONG_LIKELIST, sMid) && !empty sMid }">
				            <button id="songlike_btn1" style="display: none;" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
				            <button id="songlike_btn2" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
			        	</c:if>
			        	<c:if test="${!fn:contains(vo.SJ_SONG_LIKELIST, sMid) && !empty sMid }">
				            <button id="songlike_btn1" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
				            <button id="songlike_btn2" style="display: none;" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
			        	</c:if>
			        	<span id="songLikeCnt">${vo.SJ_SONG_WISHCNT }</span>
		        	</p>
				</c:if>
				<div class="p-3 mb-3" style="border-radius: 15px; background-color: #f5d9da;">
					<h5><b>곡정보</b></h5>
					<c:if test="${!empty vo.SJ_SONG_IDX }">
						<table class="table table-borderless">
							<tr>
								<th width="100px">아티스트</th>
								<td>${vo.SJ_SONG_ARTIST }</td>
								<td rowspan="7"><div style="width: 300px; float: right;"><img style="border-radius: 100%" src="${vo.SJ_SONG_IMG }"></div></td>
							</tr>
							<tr>
								<th>앨범</th>
								<td>${vo.SJ_SONG_ALBUM }</td>
							</tr>
							<tr>
								<th>발매</th>
								<td>${vo.SJ_SONG_DATE }</td>
							</tr>
							<tr>
								<th>장르</th>
								<td>${vo.SJ_SONG_GENRE }</td>
							</tr>
							<tr>
								<th>작곡</th>
								<td>${vo.SJ_SONG_COMPOSING }</td>
							</tr>
							<tr>
								<th>작사</th>
								<td>${vo.SJ_SONG_WRITE }</td>
							</tr>
							<tr>
								<th>편곡</th>
								<td>${vo.SJ_SONG_ARRANGE }</td>
							</tr>
						</table>
					</c:if>
				</div>
			</div>
			<div class="p-3" style="border-radius: 15px;background-color: #f5d9da;">
				<h5><b>가사정보</b></h5>
				<div class="text-center">
					<c:if test="${empty vo.SJ_SONG_LYRICS }">준비중 입니다.</c:if>
					<c:if test="${!empty vo.SJ_SONG_LYRICS }">
						<div id="lyrics_div">${fn:replace(vo.SJ_SONG_LYRICS, enter, "<br>") }</div>
						<button id="lyrics_more_btn" type="button" class="btn form-control mt-5" style="border-radius: 15px;background-color: #da8e93;"onclick="moerLyrics()">더보기</button>
					</c:if>
				</div>
			</div>
	  </div>
	</div>
	<br/><br/><br/><br/><br/><br/><hr/>
	
		<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
    <script>
    	let lyricssw = 0;
    
    	$("#songlike_btn1").click(() => {
    		$("#songlike_btn1").hide();
    		$("#songlike_btn2").show();
    		
    		if (${empty sMid}) return;

    		$.ajax({
    			type : "post",
    			url : "${ctp}/music/like",
    			data : {idx : ${vo.SJ_SONG_IDX}},
    			success : () => {
    				$("#songLikeCnt").load(window.location.href + " #songLikeCnt");
    			}
    		});
    	}); 
    	
    	$("#songlike_btn2").click(() => {
    		$("#songlike_btn2").hide();
    		$("#songlike_btn1").show();
    		
    		if (${empty sMid}) return;
    		
			$.ajax({
				type : "post",
				url : "${ctp}/music/unlike",
				data : {idx : ${vo.SJ_SONG_IDX}},
				success : () => {
    				$("#songLikeCnt").load(window.location.href + " #songLikeCnt");
    			}
			});    		
    	}); 
    		
    	function moerLyrics() {
    		if (lyricssw == 0) {
	    		lyrics_div.style.height = "auto";
	    		lyrics_div.style.overflow = "auto";
	    		lyricssw = 1;
	    		lyrics_more_btn.innerHTML = "접기";
    		}
    		
    		else {
	    		lyrics_div.style.height = "200px";
	    		lyrics_div.style.overflow = "hidden";
	    		lyricssw = 0;    			
	    		lyrics_more_btn.innerHTML = "더보기";
    		}
		}
    	
    </script>
</body>
</html>