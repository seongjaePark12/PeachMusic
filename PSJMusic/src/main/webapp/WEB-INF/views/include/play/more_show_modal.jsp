<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<div class="modal fade" id="moreShowModal">
	<div class="modal-dialog modal-sm modal-dialog-scrollable">
		<div class="modal-content" style="background: black;">
			<!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">더보기</h4>
	          <button type="button" class="close" data-dismiss="modal" onclick='mylist_box_re()'>&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	        	<button type="button" class="btn btn-danger form-control" onclick="delList(idx_list[playerIndex])" data-dismiss="modal">현재 재생 목록에서 제거</button>
	        	<button type="button" class="btn btn-danger form-control mt-3" onclick="like_click()">좋아요</button>
	        	<button type="button" class="btn btn-danger form-control mt-3" onclick="$('#lyrics_btn').click()" data-dismiss="modal">가사 보기</button>
	        	<button type="button" class="btn btn-danger form-control mt-3" onclick="getlist2()">플레이리스트에 추가</button>
	        	<div id="idx_box" style="display: none;"></div>
	        	<div id="isFile_box" style="display: none;"></div>
	        	<div id="mylist_box" class="mt-5"></div>
	        	<div id="message_box1" style="display: none;" class="text-center">추가 되었습니다</div>
	        	<div id="message_box2" style="display: none;" class="text-center">이미 추가 된 곡입니다</div>
	        	<div id="message_box3" style="display: none;" class="text-center"></div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button id="mclose_btn" type="button" class="btn btn-danger" data-dismiss="modal" onclick='mylist_box_re()'>Close</button>
	        </div>
        </div>
	</div>
</div>

<script>
	function getlist2() {
		$.ajax({
			type : "post",
			data : {idx : ${sIdx}},
			url : "${ctp}/user/getlist",
			success : (data) => {
				let res = "";
				data.forEach((e) => {
					res += "<div class='d-flex justify-content-center ho mb-3' onclick='action2(" + e.SJ_PLAYLIST_IDX + ")'>";
					res += '<div style="width: 50px; height: 50px;" class="col-2">';
					res += '<div class="row" style="margin-left: 0px;">';
					if (e.thum1 == null) {
						res += '<div width="50px"><img width="100%" src="https://i1.sndcdn.com/avatars-000606604806-j6ghpm-t500x500.jpg"></div>';
						res += '</div></div><div class="col">';
						res += e.SJ_PLAYLIST_LISTNM;
						res += '</div></div>';
					}
					else {
						res += '<div width="50px"><img width="100%" src="' + e.thum1 + '"></div>';
						res += '</div></div><div class="col">';
						res += e.SJ_PLAYLIST_LISTNM;
						res += '</div></div>';
					}
				});
				mylist_box.innerHTML = res;
			}
		});
	}
	
	function action2(idx) {
		let songIdx = idx_box.innerHTML;
		if (songIdx == "") songIdx = idx_list[playerIndex];
		let data = {
			idx : idx,
			songIdx : songIdx
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
	
	function like_click() {
		if ($("#like_btn2").css("display") == "none") $("#like_btn1").click();
		else if ($("#like_btn1").css("display") == "none") $("#like_btn2").click();
	}
	
	function mylist_box_re() {
		mylist_box.innerHTML = "";
	}
	
</script>