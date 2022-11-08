<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장르별 음악</title>
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/font.css">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<script>
		function login(){
			alert("로그인 후 이용해주세요");
			location.href="../user/login";
		}
	</script>
	   <style>
    	.ho:hover {
    		cursor: pointer;
    		opacity: 0.7;
    	}
    </style>	
</head>
<body>
	<c:if test="${sMid != null}">
	<!-- 음악 재생을 위한곳 -->
		<jsp:include page="/WEB-INF/views/include/addlist.jsp" />
		<jsp:include page="/WEB-INF/views/include/addlist_many.jsp" />
		<button id="hiden_btn" type="button" data-toggle="modal" data-target="#addlist" style="display: none;" onclick=""></button>
		<button id="hiden_btn_many" type="button" data-toggle="modal" data-target="#addlist_many" style="display: none;" onclick=""></button>	
	</c:if>	
	<!-- top -->
		<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
	<!-- nav -->
		<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
		
     <div class="container">
        <div class="card-body">
          <h3 class="w3-center">장르별 음악</h3><br/>
          <div class="row" style="font-size: 15px">
	          <div class="w3-margin-right"><a href="${ctp}/music/genre"><b>가요</b></a></div><div class="w3-margin-right">/</div>
	          <div class="w3-margin-right"><a href="${ctp}/music/genre?genre=POP"><b>POP</b></a></div><div class="w3-margin-right">/</div>
	          <div class="w3-margin-right"><a href="${ctp}/music/genre?genre=발라드"><b>발라드</b></a></div><div class="w3-margin-right">/</div>
	          <div class="w3-margin-right"><a href="${ctp}/music/genre?genre=댄스"><b>댄스</b></a></div><div class="w3-margin-right">/</div>
	          <div class="w3-margin-right"><a href="${ctp}/music/genre?genre=R＆B"><b>R＆B</b></a></div><div class="w3-margin-right">/</div>
	          <div class="w3-margin-right"><a href="${ctp}/music/genre?genre=락"><b>락</b></a></div><div class="w3-margin-right">/</div>
	          <div class="w3-margin-right"><a href="${ctp}/music/genre?genre=랩/힙합"><b>랩/힙합</b></a></div>
          </div>
	         <div id="top_btn" class="btn" style="position: fixed; right: 30px; bottom: 100px;background: #f5d9da;">top</div>
	         <c:if test="${!empty vos && sMid != null}"><div id="add_btn" class="btn  btn-sm" style="background: #f5d9da; position: sticky; right: 30px; top: 50px; float: right;" onclick="">선택추가</div></c:if>
	         <c:if test="${sMid == null}"><div id="add_btn" class="btn btn-sm" style="background: #f5d9da; position: sticky; right: 30px; top: 50px; float: right;" onclick="login()">선택추가</div></c:if>
	          <table class="table">
	          	<tr>
	          		<td style="border-top: none;"><input id="allch" type="checkbox" ></td>
	          		<td id="cnt_box" colspan="2" style="vertical-align: middle; border-top: none;">0 곡 선택 됨</td>
	      			</tr>
	              <c:forEach var="vo" items="${vos }" varStatus="st">
	               <tr>
	               	<td><input name="tch" type="checkbox" value="${vo.SJ_SONG_IDX }"></td>
	                   <td><div class="imgBox ho" onclick="oneplay(${vo.SJ_SONG_IDX}, ${vo.SJ_SONG_ISFILE })"><img name="top100Img" src="${vo.SJ_SONG_IMG }"></div></td>
	                   <td class="align-middle">
	                       <div name="top100Title"><a href="${ctp}/music/songinfor?idx=${vo.SJ_SONG_IDX}">${vo.SJ_SONG_TITLE}</a></div>
	                       <div name="top100Artist">${vo.SJ_SONG_ARTIST }</div>
	                   </td>
	                   <td>발매일 : ${vo.SJ_SONG_DATE}</td>
	                   <c:if test="${sMid != null}">
	                     <td class="align-middle"><button name="add_btn" type="button" class="btn" onclick="senddata(${vo.SJ_SONG_IDX}, ${vo.SJ_SONG_ISFILE })"><i title="곡 추가" class="fas fa-plus" ></i></button></td>
	               		 </c:if>
	               		 <c:if test="${sMid == null}">
	               		 	 <td class="align-middle"><button type="button" class="btn" onclick="login()"><i title="곡 추가" class="fas fa-plus" ></i></button></td>
	               		 </c:if>
	               </tr>
	              </c:forEach>
	          </table>
        </div>
    </div>
		
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
			cnt_box.innerHTML = $("input:checkbox[name='tch']:checked").length + " 곡 선택 됨";
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