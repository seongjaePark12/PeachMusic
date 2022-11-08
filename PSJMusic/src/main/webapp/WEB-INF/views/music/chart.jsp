<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<% pageContext.setAttribute("enter", "\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>피치차트</title>
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
		
	<c:set var="today"><fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd"/></c:set>
	
	<section>
        <div class="container">
            <div class="card-body">
                <h2 class="w3-center">피치차트 Top 100</h2>
                <h3 class="w3-center">Top 100</h3><br/>
                <div>
	                <input type="date" id="calendar" min="${minDate }" max="${today }">
	                <div id="go_btn" class="btn btn-sm" style="background: #f5d9da;">go</div>
                </div>
                <div id="top_btn" class="btn" style="position: fixed; right: 30px; bottom: 100px;background: #f5d9da;">top</div>
			          <c:if test="${!empty vos && sMid != null}"><div id="add_btn" class="btn  btn-sm" style="background: #f5d9da; position: sticky; right: 30px; top: 50px; float: right;" onclick="">선택추가</div></c:if>
			          <c:if test="${sMid == null}"><div id="add_btn" class="btn btn-sm" style="background: #f5d9da; position: sticky; right: 30px; top: 50px; float: right;" onclick="login()">선택추가</div></c:if>
                <div class="text-center h4">
                	${fn:replace(fn:split(vos[0].SJ_CHART_DATE, " ")[0], "-", ".") }
            	</div>
            	<c:if test="${empty vos }"><p class="h5 mt-5" style="padding-bottom: 400px;">${date }의 차트 데이터가 존재하지 않습니다.</p></c:if>
            	<c:if test="${!empty vos }">
	                <table class="table">
	                	<tr>
	                		<td style="border-top: none;"><input id="allch" type="checkbox" ></td>
	                		<td id="cnt_box" colspan="2" style="vertical-align: middle; border-top: none;">0 곡 선택 됨</td>
	            		</tr>
	                    <c:forEach var="vo" items="${vos }" varStatus="st">
		                    <tr>
		                    	<td><input name="tch" type="checkbox" value="${vo.SJ_SONG_IDX }" <c:if test="${vo.SJ_CHART_ISFILE == 0 }">disabled</c:if>></td>
		                        <td style="text-align: center; vertical-align: middle;">${vo.SJ_CHART_RANK}</td>
		                        <td><div class="imgBox ho" onclick="oneplay(${vo.SJ_SONG_IDX}, ${vo.SJ_CHART_ISFILE })"><img name="top100Img" src="${vo.SJ_CHART_IMG }"></div></td>
		                        <td class="align-middle">
		                            <div name="top100Title"><a href="${ctp}/music/songinfor?idx=${vo.SJ_SONG_IDX}">${vo.SJ_CHART_TITLE }</a></div>
		                            <div name="top100Artist">${vo.SJ_CHART_ARTIST }</div>
		                        </td>
		                        <c:if test="${sMid != null}">
		                        	<td class="align-middle"><button name="add_btn" type="button" class="btn" onclick="senddata(${vo.SJ_SONG_IDX}, ${vo.SJ_CHART_ISFILE })"><i title="곡 추가" class="fas fa-plus" ></i></button></td>
		                    	  </c:if>
		                    	  <c:if test="${sMid == null}">
				               		 	 <td class="align-middle"><button type="button" class="btn" onclick="login()"><i title="곡 추가" class="fas fa-plus" ></i></button></td>
				               		  </c:if>
		                    </tr>
	                    </c:forEach>
	                </table>
                </c:if>
            </div>
        </div>
			<jsp:include page="/WEB-INF/views/include/main/footer.jsp"/>
    </section>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
	<script>
		top_btn.addEventListener("click", () => {
			window.scrollTo({top: 0, behavior: 'smooth'});
		});
		
		<c:if test="${!empty vos }">
			//전체선택
			allch.addEventListener("click", () => {
				if (allch.checked) {
					$("input:checkbox[name='tch']:not(:disabled)").prop("checked", true);
				}
				else {
					$("input:checkbox[name='tch']").prop("checked", false);
				}
				cnt_box.innerHTML = $("input:checkbox[name='tch']:checked").length + " 곡 선택 됨"
			});
			
			//전체선택 해제
			$("input:checkbox[name='tch']").click(() => {
				cnt_box.innerHTML = $("input:checkbox[name='tch']:checked").length + " 곡 선택 됨"
				for (let i=0; i<100; i++) {
					if (!$("input:checkbox[name='tch']")[i].checked) {
						$("#allch").prop("checked", false);
						return;
					}
				}
			});
			
			//선택 추가 버튼
			add_btn.addEventListener("click", () => {
				let idxs = "";
				
				for (let i=0; i<100; i++) {
					if($("input:checkbox[name='tch']")[i].checked) {
						if ($("input:checkbox[name='tch']")[i].value != 0) {
							idxs += $("input:checkbox[name='tch']")[i].value + "/";
						}
					}
				}
				
				$('#hiden_btn_many').click();
				idx_box_many.innerHTML = idxs;
			});
			
		</c:if>
			
		go_btn.addEventListener("click", () => {
			let date1 = new Date(calendar.value);
			let date2 = new Date("${minDate}");
			let date3 = new Date("${today}");
			
			if (date1 < date2 || date1 > date3) {
				return;
			}
			
			location.href = "${ctp}/music/chart?date=" + calendar.value;
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