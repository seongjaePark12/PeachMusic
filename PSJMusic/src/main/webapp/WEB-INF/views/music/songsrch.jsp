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
	   <style>
    	.ho:hover {
    		cursor: pointer;
    		opacity: 0.7;
    	}
    </style>	
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/play/modal.jsp" />
	<!-- top -->
		<jsp:include page="/WEB-INF/views/include/main/top.jsp"/>
	<!-- nav -->
		<jsp:include page="/WEB-INF/views/include/main/nav.jsp"/>
	  <%
   		String srchKwd = request.getParameter("srchKwd");
   		String srchKwdU = srchKwd.toUpperCase();
   		String srchKwdL = srchKwd.toLowerCase();
   	  	pageContext.setAttribute("srchKwdU", srchKwd.toUpperCase());
   	  	pageContext.setAttribute("srchKwdL", srchKwd.toLowerCase());
   	  	pageContext.setAttribute("active", "<span class='bg-warning'>" + srchKwd + "</span>");
   	  	pageContext.setAttribute("activeU", "<span class='bg-warning'>" + srchKwdU + "</span>");
   	  	pageContext.setAttribute("activeL", "<span class='bg-warning'>" + srchKwdL + "</span>");
   	%>
		<div class="w3-container">
	  	<div class="w3-content" style="max-width:1200px">
         <div class="card-body" style="padding-bottom: 300px;">
             <h2 class="w3-center">피치뮤직 '${srchKwd }' 검색결과</h2>
             <c:if test="${empty srchvos }">검색 결과가 없습니다.</c:if>
             <table class="table" style="width: 80%; margin: auto;">
                 <c:forEach var="vo" items="${srchvos }" varStatus="st">
                  <tr>
                      <td><div class="imgBox"><a href="${ctp}/music/songinfor?idx=${vo.SJ_SONG_IDX }"><img name="top100Img" src="${vo.SJ_SONG_IMG }" alt=""></a></div></td>
                      <td>
                          <div>
                          	<a href="${ctp}/music/songinfor?idx=${vo.SJ_SONG_IDX }">
                          		${fn:replace(vo.SJ_SONG_TITLE, srchKwd, active) }
                          	</a>
                         	</div>
                          <div>
                         		${fn:replace(vo.SJ_SONG_ARTIST, srchKwd, active) }
                          </div>
                      </td> 
                      <td class="align-middle"><button name="add_btn" type="button" class="btn" onclick="senddata(${vo.SJ_SONG_IDX}, ${vo.SJ_SONG_ISFILE })"><i title="곡 추가" class="fas fa-plus"></i></button></td>
                  </tr>
                 </c:forEach>
             </table>
         </div>
       </div>  
		</div>
	
		<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
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