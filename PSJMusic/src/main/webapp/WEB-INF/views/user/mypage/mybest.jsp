<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	   <style>
    	.ho:hover {
    		cursor: pointer;
    		opacity: 0.7;
    	}
    </style>
</head>
<body>
	<!-- top -->
		<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
	<!-- nav -->
		<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
		<div class="w3-container">
	  	<div class="w3-content" style="max-width:1200px">
	  		<br/><br/>
				<h1 class="w3-center w3-margin-top">가장 즐겨듣는 노래</h1>
    		 <br/><br/>
				<c:if test="${empty sMid }">
					<div><a href="${ctp }/user/login" style="color: rgb(216, 148, 148);">로그인</a>을 하고 지금 나의 차트를 확인 하세요</div>
				</c:if>
				<c:if test="${!empty sMid && empty vos }">
					<div><p><font color="yellow">${sVO.SJ_USER_NICKNAME }</font>님 아직 들으신 음악이 없으시네요~<p> 
						 <p>피치뮤직에서 노래를 들어보세요.</p>
					</div>
				</c:if>
				<c:if test="${!empty sMid && !empty vos}">
					<h4><font color="yellow;">${sVO.SJ_USER_NICKNAME }</font>님이 즐겨 듣는 곡을 모아 봤어요!!</h4>
					<div style="width: 350px; margin: auto;" class="mt-5 mb-5 text-center ho" onclick="javascript:location.href='${ctp}/music/songinfor?idx=${vos[0].SJ_SONG_IDX}'">
						<div><img src="${vos[0].SJ_SONG_IMG }"></div>
						<div>${vos[0].SJ_SONG_TITLE }</div>
						<div>${vos[0].SJ_SONG_ARTIST }</div>
						<div>재생수 : ${vos[0].SJ_PLAY_CNT }</div>
					</div>
					<div class="row mb-5">
						<c:if test="${!empty vos[1].SJ_SONG_IMG }">
							<div class="col text-center ho" onclick="javascript:location.href='${ctp}/music/songinfor?idx=${vos[1].SJ_SONG_IDX }'">
								<div><img src="${vos[1].SJ_SONG_IMG }"></div>
								<div>${vos[1].SJ_SONG_TITLE}</div>
								<div>${vos[1].SJ_SONG_ARTIST }</div>
								<div>재생수 : ${vos[1].SJ_PLAY_CNT }</div>
							</div>
						</c:if>
						<c:if test="${!empty vos[2].SJ_SONG_IMG }">
							<div class="col text-center ho" onclick="javascript:location.href='${ctp}/music/songinfor?idx=${vos[2].SJ_SONG_IDX }'">
								<div><img src="${vos[2].SJ_SONG_IMG }"></div>
								<div>${vos[2].SJ_SONG_TITLE}</div>
								<div>${vos[2].SJ_SONG_ARTIST }</div>
								<div>재생수 : ${vos[2].SJ_PLAY_CNT }</div>
							</div>
						</c:if>
					</div>
					<table class="table">
						<tr style="border-top: none;">
							<td class="text-right" colspan="7"><button id="add_btn" class="btn" type="button" style="background-color: #f5d9da">선택추가</button></td>
						</tr>
						<tr>
							<th class="text-center align-middle"><input id="allch" type="checkbox"></th>
							<th class="text-center align-middle">순위</th>
							<th></th>
							<th></th>
							<th></th>
							<th class="text-center align-middle">재생수</th>
						</tr>
						<c:forEach var="vo" items="${vos}" varStatus="st">
							<tr>
								<td class="text-center align-middle"><input name="tch" type="checkbox"></td>
								<td class="text-center align-middle">${st.count }</td>
								<c:if test="${st.index <= 2}"><td class="align-middle"><img style="width: 50px;" src="${vo.SJ_SONG_IMG }"></td></c:if>
								<c:if test="${st.index > 2}"><td class="align-middle"><img src="${vo.SJ_SONG_IMG }"></td></c:if>
								<td class="align-middle" title="${vo.SJ_SONG_TITLE}">
									<a href="${ctp}/music/songinfor?idx=${vo.SJ_SONG_IDX }">
										<c:if test="${fn:length(vo.SJ_SONG_TITLE) < 20 }">${vo.SJ_SONG_TITLE}</c:if>
										<c:if test="${fn:length(vo.SJ_SONG_TITLE) >= 20 }">${fn:substring(vo.SJ_SONG_TITLE, 0, 20) }...</c:if>
									</a>
								</td>
								<td class="align-middle" title="${vo.SJ_SONG_ARTIST }">
									<c:if test="${fn:length(vo.SJ_SONG_ARTIST) < 20 }">${vo.SJ_SONG_ARTIST }</c:if>
									<c:if test="${fn:length(vo.SJ_SONG_ARTIST) >= 20 }">${fn:substring(vo.SJ_SONG_ARTIST, 0, 20) }...</c:if>
								</td>
								<td class="align-middle text-center">${vo.SJ_PLAY_CNT }</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
	  </div>
	</div>
	<br/><br/><br/><br/><br/><br/><hr/>
	
		<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
			<script>
	  //전체선택
		allch.addEventListener("click", () => {
			if (allch.checked) {
				$("input:checkbox[name='tch']").prop("checked", true);
			}
			else {
				$("input:checkbox[name='tch']").prop("checked", false);
			}
		});
		
		//전체선택 해제
		$("input:checkbox[name='tch']").click(() => {
			for (let i=0; i<100; i++) {
				if (!$("input:checkbox[name='tch']")[i].checked) {
					$("#allch").prop("checked", false);
					return;
				}
			}
		});
		
		add_btn.addEventListener("click", () => {
			let idxs = "";
			
			<c:forEach var="vo" items="${vos}" varStatus="st">
				if($("input:checkbox[name='tch']")[${st.index}].checked) {
					idxs += ${vo.SJ_SONG_IDX} + "/";
				}
			</c:forEach>
			
			$('#hiden_btn_many').click();
			idx_box_many.innerHTML = idxs;
		});
    </script>
<script>
	let sw;
	let player;
	
	 $(document).ready(() => {
        $('.loader').fadeOut();
	 });
	 
	 function oneplay(idx, isFile) {
		 	if (isFile == 0) {
		 		alert("준비중입니다.");
		 		return;
		 	}
			let url = "${ctp}/music/player?idx=" + idx + "&play=1";
			player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
			sw = true;
	 }
		
	function addf(idx, isFile, autoplay) {
		<c:if test="${!empty sPlayer}">
			<% 
			   	boolean sPlayer = (boolean) session.getAttribute("sPlayer");
				pageContext.setAttribute("player1", sPlayer); 
			%>
			if (${player1}) {
				player = window.open("", "player", "width=1100px, height=800px, left=50px, top=150px");
				$.ajax({
					type : "post",
					url : "${ctp}/music/player",
					data : {idx : idx},
					success : (data) => {
						player.addList(data);
						player.setList();
					}
				});
				return;
			}
		</c:if>
		
		if (!sw) {
			let url = "${ctp}/music/player?idx=" + idx + "&play=0";
			player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
			sw = true;
		}
		else {
			if (!player.closed && sw) {
				$.ajax({
					type : "post",
					url : "${ctp}/music/player",
					data : {idx : idx},
					success : (data) => {
						player.addList(data);
						player.setList();
					}
				});
			} 
			else {
				let url = "${ctp}/music/player?idx=" + idx + "&play=0";
				player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
				sw = true;
			}
		}
	}
	
	function senddata(idx, isFile) {
		if (idx == 0 || isFile == 0) {
			alert("아직 준비 중인 곡입니다.");
			return;
		}
		
		$('#hiden_btn').click();
		idx_box.innerHTML = idx;
		isFile_box.innerHTML = isFile;
	}
	
	function godata() {
		let idx = idx_box.innerHTML;
		let isFile = isFile_box.innerHTML;
		addf(idx, isFile);
	}
	
	function godata_many() {
		let idxs = idx_box_many.innerHTML;
		
		<c:if test="${!empty sPlayer}">
			<% 
			   	boolean sPlayer = (boolean) session.getAttribute("sPlayer");
				pageContext.setAttribute("player1", sPlayer); 
			%>
			if (${player1} && player) {
				player = window.open("", "player", "width=1100px, height=800px, left=50px, top=150px");
				let idx_list = idxs.split("/");
				for (let i=0; i<idx_list.length - 1; i++) {
					$.ajax({
						type : "post",
						url : "${ctp}/music/player",
						data : {idx : idx_list[i]},
						success : (data) => {
							player.addList(data);
							player.setList();
						}
					});
				}
				return;
			}
		</c:if>
		
		if (!sw) {
			let url = "${ctp}/music/player?idxs=" + idxs + "&play=0";
			player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
			sw = true;
		}
		else {
			if (!player.closed && sw) {
				let idx_list = idxs.split("/");
				for (let i=0; i<idx_list.length - 1; i++) {
					$.ajax({
						type : "post",
						url : "${ctp}/music/player",
						data : {idx : idx_list[i]},
						success : (data) => {
							player.addList(data);
							player.setList();
							
							$("#message_box_many").slideDown(300);
							setTimeout(() => $("#message_box_many").slideUp(), 1000);
						}
					});
				}
			}
			else {
				let url = "${ctp}/music/player?idxs=" + idxs + "&play=0";
				player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
				sw = true;
			}
		}
	}
	
	function action(idx) {
		let data = {
			idx : idx,
			songIdx : idx_box.innerHTML
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/addmylist",
			data : data,
			success : (data) => {
				if (data == 1) {
					$("#message_box1").slideDown(300);
					setTimeout(() => $("#message_box1").slideUp(), 1000);
					return;
				}
				$("#message_box2").slideDown(300);
				setTimeout(() => $("#message_box2").slideUp(), 1000);
			}
		});
	}
	
	
	function player_close() {
		$.ajax({
			type : "post",
			url : "${ctp}/music/close",
			success : () => {
				location.reload();
			}
		});
	}
	
</script>	    
</body>
</html>