<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />

<style>
	#addSongModal {
		color: white;
	}
</style>

<div class="modal" id="addSonglist">
	<div class="modal-dialog modal-dialog-scrollable">
  		<div class="modal-content" style="background: #f5d9da;">
      
	        <!-- Modal Header -->
	        <div class="container mt-3">
	        	<h2>새 플레이리스트 추가</h2>
	        </div>
      		<div class="modal-header">
      			나만의 플레이 리스트를 만들어 보세요!
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
		        <div class="form-group">
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="SJ_PLAYLIST_LISTNM" class="form-control" type="text" placeholder="title"></div>
		        </div>
		        <div class="form-group">
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="SJ_PLAYLIST_COMMENT" class="form-control" type="text" placeholder="플레이리스트 설명을 입력해 주세요."></div>
		        </div>
		        <div class="text-danger ho" onclick="showsrch()">
		        	<div class="btn btn-danger btn-sm"><i title="새로운 곡 추가" class="fas fa-plus"></i></div>
		        	<span class="ml-2">새로운 곡 추가</span>
	        	</div>
	        	<div id="playlist_"></div>
	        	<div class="mt-3">
	        		<div id="srchform" name="srchform" style="display: none;">
	        			<div class="input-group mb-3">
					  		<input type="text" class="form-control" placeholder="Search" id="keyword">
					  		<div class="input-group-append">
					    		<button class="btn btn-danger" type="button" onclick="getres()"><i class="fa-solid fa-magnifying-glass"></i></button>
					  		</div>
						</div>
	        		</div>
		        	<div name="srchform" class="form-group" style="display: none;">
		        		<div id="srchResult"></div>
		        		<input type="hidden" id="SJ_PLAYLIST_CONTENT">
		        	</div>
	        	</div>
	        </div>
        	<div id="message_box1" class="text-center p-3" style="display: none;">플레이리스트에 추가 되었습니다.</div>
        	<div id="message_box2" class="text-center p-3" style="display: none;">이미 추가 된 곡입니다.</div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	      		<button type="button" class="btn btn-danger" onclick="saveList()">저장</button>
	      		<button type="button" class="btn btn-danger" onclick="goClose()">Close</button>
	      		<button id="close_btn" type="button" class="btn btn-danger" data-dismiss="modal" style="display: none;">Close</button>
	        </div>
        
  		</div>
	</div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	let playlist_res = "";
	let idx_list = [];
	
	function goClose() {
		if (confirm("변경사항을 저장하지 않고 편집을 종료합니다. 정말 나가시겠어요?")) {
			location.href="../user/playlist";
		}
	}

	function saveList() {
		if (SJ_PLAYLIST_LISTNM.value == "") {
			alert("플레이 리스트 제목을 입력하세요.");
			SJ_PLAYLIST_LISTNM.focus();
			return;
		}
		
		let data = {
			SJ_USER_IDX : "${sIdx}",
			SJ_PLAYLIST_LISTNM : SJ_PLAYLIST_LISTNM.value,
			SJ_PLAYLIST_COMMENT : SJ_PLAYLIST_COMMENT.value,
			SJ_PLAYLIST_CONTENT : SJ_PLAYLIST_CONTENT.value,
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/savelist",
			data : data,
			success : () => {
				location.reload();
			}
		});
	}
	
	function showsrch() {
		$("div[name='srchform']").toggle();
	}
	
	function getres() {
		if ($("#keyword").val().trim() == "") return;
		$.ajax({
			type : "post",
			url : "${ctp}/music/srch",
			data : {srchKwd : $("#keyword").val()},
			success : (data) => {
				let res = "";
				data.forEach((e) => {
					res += "<div id='p_" + e.idx +"' class='d-flex p-3'>";
					res += "<div class='imgBox mr-3'>";
					res += "<img src='" + e.img + "'>";
					res += "</div>";
					res += "<div>";
					res += "<div class='playlist_t' title='" + e.title + "'>";
					res += e.title;
					res += "</div>";
					res += "<div class='playlist_a' title='" + e.artist + "'>";
					res += e.artist;
					res += "</div>";
					res += "</div>";
					res += "<div class='ml-auto'>";
					res += "<button name='add_btn' type='button' class='btn'><i title='곡 추가' class='fas fa-plus' onclick='setpl(" + e.idx + ")'></i></button>";
					res += "</div>";
					res += "</div>";
				});
				srchResult.innerHTML = res;
			}
		});
	}
	
	function setpl(idx) {
		playlist_res = playlist_.innerHTML;
		$.ajax({
			type : "post",
			url : "${ctp}/music/getaddsong",
			data : {idx : idx},
			success : (data) => {
				if (!idx_list.includes(data.idx)) {
					idx_list.push(data.idx);
					
					playlist_res += "<div class='d-flex p-3'>";
					playlist_res += "<div class='imgBox mr-3'>";
					playlist_res += "<img src='" + data.img + "'>";
					playlist_res += "</div>";
					playlist_res += "<div>";
					playlist_res += "<div class='playlist_t' title='" + data.title + "'>";
					playlist_res += data.title;
					playlist_res += "</div>";
					playlist_res += "<div class='playlist_a' title='" + data.artist + "'>";
					playlist_res += data.artist;
					playlist_res += "</div>";
					playlist_res += "</div>";
					playlist_res += "</div>";
					
					playlist_.innerHTML = playlist_res;
					
					SJ_PLAYLIST_CONTENT.value = SJ_PLAYLIST_CONTENT.value + data.idx + "/";
					
					$("#message_box1").slideDown(300);
					setTimeout(() => $("#message_box1").slideUp(), 1000);
				}
				else {
					$("#message_box2").slideDown(300);
					setTimeout(() => $("#message_box2").slideUp(), 1000);
				}
			}
		});
	}
	
	$("#keyword").keyup((e) => {
		if (e.keyCode == 13) {
			getres();
		}
	});
	
</script>