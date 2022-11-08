<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>플레이리스트</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/font.css">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	    <style>
    	.ho:hover {
    		cursor: pointer;
    		opacity: 0.7;
    	}
    	
    	th {
    		border-top: none;
    	}
    	
    </style>
</head>
<body>
<!-- top -->
	<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
<!-- nav -->
	<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
	<div class="w3-container">
			<div class="card-body" style="padding-bottom: 300px;">
			<h2 class="mt-5 mb-5"><b>${sNickName}</b>님 플레이리스트</h2>
			<div class="row">
				<button type="button" class="btn ml-3" style="background-color: #f5d9da" onclick="javascript:location.href='${ctp}/user/playlist?idx=${sIdx}'">목록</button>
				<div class="col"></div>
				<button type="button" class="btn mr-3" style="background-color: #f5d9da" title="수정" onclick="update()"><i class="fas fa-pen-square"></i></button>
				<button type="button" class="btn mr-3" style="background-color: #f5d9da" onclick="playlistdel()">삭제</button>
			</div>
			<div class="p-3 row">
				<div style="width: 200px; height: 200px;">
					<c:if test="${empty vo.thum1 }">
	    				<div><img src="https://i1.sndcdn.com/avatars-000606604806-j6ghpm-t500x500.jpg" style="width: 100%;"></div>
	    			</c:if>
	    			<c:if test="${empty vo.thum2 }">
	    				<div><img src="${vo.thum1 }"></div>
	    			</c:if>
	    			<c:if test="${!empty vo.thum2 }">
	    				<div class="row" style="margin-left: 0px;">
		    				<div><img src="${vo.thum1 }"></div>
		    				<div><img src="${vo.thum2 }"></div>
	    				</div>
	    				<div class="row" style="margin-left: 0px;">
		    				<div><img src="${vo.thum3 }"></div>
		    				<div><img src="${vo.thum4 }"></div>
	    				</div>
	    			</c:if>
	   			</div>
	   			<div class="ml-5">
					<h4 id="listNm_box">${vo.listNm }</h4>
					<div id="comment_box">${fn:replace(vo.SJ_PLAYLIST_COMMENT, enter, "<br>") }</div>
	   			</div>
	  		</div>
			<div class="d-flex justify-content-around p-3 mt-5">
				<button type="button" class="btn col" style="background-color: #f5d9da" onclick="listplay(${vo.idx})"><i class="fas fa-play fa-2x"></i><span class="ml-5" style="font-size: 28px;">play</span></button>
				<div class="col"></div>
				<button type="button" class="btn col" style="background-color: #f5d9da" onclick="shuffle(${vo.idx})"><i class="fas fa-random fa-2x"></i><span class="ml-5" style="font-size: 28px;">shuffle</span></button>
			</div>
			<c:if test="${!empty vos }">
				<table class="table">
					<tr>
						<th class="text-center align-middle"><input id="allch" type="checkbox" checked></th>
						<th id="cnt_box">${fn:length(vos) } 곡 선택됨</th>
						<th></th>
						<th></th>
						<th class="text-center align-middle ho"><div class="btn" style="background-color: #f5d9da" onclick="listSongDel()">선택삭제</div></th>
					</tr>
					<c:forEach var="vo" items="${vos}" varStatus="st">
						<tr>
							<td class="text-center align-middle"><input name="tch" type="checkbox" checked></td>
							<td class="align-middle"><img src="${vo.SJ_SONG_IMG }"></td>
							<td class="align-middle" title="${vo.SJ_SONG_TITLE }">
								<a href="${ctp }/infor?idx=${vo.SJ_SONG_IDX }">
									<c:if test="${fn:length(vo.SJ_SONG_TITLE) < 20 }">${vo.SJ_SONG_TITLE }</c:if>
									<c:if test="${fn:length(vo.SJ_SONG_TITLE) >= 20 }">${fn:substring(vo.SJ_SONG_TITLE, 0, 20) }...</c:if>
								</a>
							</td>
							<td class="align-middle" title="${vo.SJ_SONG_ARTIST }">
								<c:if test="${fn:length(vo.SJ_SONG_ARTIST) < 20 }">${vo.SJ_SONG_ARTIST }</c:if>
								<c:if test="${fn:length(vo.SJ_SONG_ARTIST) >= 20 }">${fn:substring(vo.SJ_SONG_ARTIST, 0, 20) }...</c:if>
							</td>
							<td class="text-center"><button type="button" class="btn" title="플레이리스트에서 제거" onclick="playlistdelsong(${vo.SJ_SONG_IDX})"><i class='fa-regular fa-trash-can'></i></button></td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
		<script>
		let sw;
		let player;
	
	  //전체선택
		allch.addEventListener("click", () => {
			if (allch.checked) {
				$("input:checkbox[name='tch']").prop("checked", true);
			}
			else {
				$("input:checkbox[name='tch']").prop("checked", false);
			}
			cnt_box.innerHTML = $("input:checkbox[name='tch']:checked").length + "곡 선택됨";
		});
		
		//전체선택 해제
		$("input:checkbox[name='tch']").click(() => {
			cnt_box.innerHTML = $("input:checkbox[name='tch']:checked").length + "곡 선택됨";
			for (let i=0; i<$("input:checkbox[name='tch']").length; i++) {
				if (!$("input:checkbox[name='tch']")[i].checked) {
					$("#allch").prop("checked", false);
					return;
				}
			}
		});
		
		function listplay(idx) {
			let idxs = "";
			
			<c:forEach var="vo" items="${vos}" varStatus="st">
				if($("input:checkbox[name='tch']")[${st.index}].checked) {
					idxs += ${vo.SJ_SONG_IDX} + "/";
				}
			</c:forEach>
			
			if (idxs == "") return;
			
			let url = "${ctp}/music/player?idxs=" + idxs + "&listIdx=" + idx + "&play=1";
			player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
			
		};
		
		function shuffle(idx) {
			let idxs = "";
			let idx_list = [];
			
			<c:forEach var="vo" items="${vos}" varStatus="st">
				if ($("input:checkbox[name='tch']")[${st.index}].checked) {
					idx_list.push(${vo.SJ_SONG_IDX});
				}
			</c:forEach>

			idx_list.sort(() => Math.random() - 0.5);
			idx_list.forEach((e) => {
				idxs += e + "/";
			});
			
			if (idxs == "") return;
			
			let url = "${ctp}/music/player?idxs=" + idxs + "&listIdx=" + idx + "&play=1";
			player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
		}
		
		function playlistdel() {
			if (confirm("현재 플레이리스트(${vo.listNm})를 삭제 하시겠습니까?")) {
				location.href="${ctp}/user/playlistdel?idx=${vo.idx}&useridx=${sIdx}";
			}
		}
		
		function playlistdelsong(idx) {
			if (confirm("이 곡을 플레이리스트에서 제거 하시겠습니까?")) {
				let data = {
					idx : ${vo.idx},
					songIdx : idx
				}
				
				$.ajax({
					type : "post",
					url : "${ctp}/user/playlistdelsong",
					data : data,
					success : () => {
						location.reload();
					}
				});
				
			}
		}
		
		function update() {
			listNm_box.innerHTML = "<input id='listNm_update_box' type='text' value='${vo.listNm}' style='background: #f5d9da; border: none;'><span class='ml-3 ho btn btn-sm' style='background-color: #f5d9da' onclick='goupdate()'>적용</span><span class='ml-3 ho btn btn-sm' style='background-color: #f5d9da' onclick='location.reload();'>취소</span>";
			let len = listNm_update_box.value.length;
			listNm_update_box.focus();
			listNm_update_box.setSelectionRange(0, len);
			comment_box.innerHTML = "<textarea id='comment_update_box' rows='6' class='form-control' style='background: #f5d9da; border: none; white-space: pre;'>${fn:replace(vo.SJ_PLAYLIST_COMMENT, enter, '&#10;')}</textarea>";
		}
		
		function goupdate() {
			if (confirm("변경사항을 적용 하시겠습니까?")) {
				let data = {
					idx : ${vo.idx},
					listNm : listNm_update_box.value,
					comment : comment_update_box.value
				}
				
				$.ajax({
					type : "post",
					url : "${ctp}/user/playlistoneupdate",
					data : data,
					success : () => {
						location.reload();
					}
				});
			}
		}
		
		function listSongDel() {
			let idxs = "";
			
			<c:forEach var="vo" items="${vos}" varStatus="st">
				if($("input:checkbox[name='tch']")[${st.index}].checked) {
					idxs += ${vo.SJ_SONG_IDX} + "/";
				}
			</c:forEach>
			
			if (idxs == "") return;
			
			if (confirm("선택하신 곡을 플레이리스트에서 제거 하시겠습니까?")) {
				let data = {
					idx : ${vo.idx},
					songIdxs : idxs
				}
				
				$.ajax({
					type : "post",
					url : "${ctp}/user/playlistdelsongs",
					data : data,
					success : () => {
						location.reload();
					}
				});
			}
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
