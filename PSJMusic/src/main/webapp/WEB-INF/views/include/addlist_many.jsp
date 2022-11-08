<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
	<style>
	.ho:hover {
		cursor: pointer;
	    opacity: 0.7;			
	}
	</style>
<!DOCTYPE html>
<div class="modal fade" id="addlist_many">
	<div class="modal-dialog">
		<div class="modal-content" style="background: #f5d9da;">
			<!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">곡 추가</h4>
	          <button type="button" class="close" data-dismiss="modal" onclick='mylist_box_re()'>&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	        	<button type="button" class="btn form-control btn-danger" onclick="godata_many()" data-dismiss="modal">현재 재생 목록에 추가</button>
	        	<button type="button" class="btn form-control btn-danger mt-3" onclick="getlist_many()">플레이리스트에 추가</button>
	        	<div id="idx_box_many" style="display: none;"></div>
	        	<div id="mylist_box_many" class="mt-5"></div>
	        	<div id="message_box_many" style="display: none;" class="text-center">추가 되었습니다</div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button id="mclose_btn" type="button" class="btn btn-danger" data-dismiss="modal" onclick='mylist_box_re()'>Close</button>
	        </div>
        </div>
	</div>
</div>

<script>
	function getlist_many() {
		$.ajax({
			type : "post",
			data : {idx : ${sIdx}},
			url : "${ctp}/user/getlist",
			success : (data) => {
				let res = "";
				data.forEach((e) => {
					res += "<div class='d-flex justify-content-center ho mb-3' onclick='action_many(" + e.idx + ")'>";
					res += '<div style="width: 50px; height: 50px;" class="col-2">';
					res += '<div class="row" style="margin-left: 0px;">';
					if (e.thum1 == null) {
						res += '<div><img width="50px" src="https://i1.sndcdn.com/avatars-000606604806-j6ghpm-t500x500.jpg"></div>';
						res += '</div></div><div class="col">';
						res += e.listNm;
						res += '</div></div>';
					}
					else if (e.thum4 == null) {
						res += '<div><img width="50px" src="' + e.thum1 + '"></div>';
						res += '</div></div><div class="col">';
						res += e.listNm;
						res += '</div></div>';
					}
					else {
						res += '<div><img width="25px" src="' + e.thum1 + '"></div>';
						res += '<div><img width="25px" src="' + e.thum2 + '"></div>';
						res += '</div>';
						res += '<div class="row" style="margin-left: 0px;">';
						res += '<div><img width="25px" src="' + e.thum3 + '"></div>';
						res += '<div><img width="25px" src="' + e.thum4 + '"></div>';
						res += '</div></div><div class="col">';
						res += e.listNm;
						res += "</div></div></div>";
					}
				});
				document.getElementById("mylist_box_many").innerHTML = res;
			}
		});
	}
	
	function action_many(idx) {
		let data = {
			idx : idx,
			songIdxs : idx_box_many.innerHTML
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/addmylistmany",
			data : data,
			success : () => {
				$("#message_box_many").slideDown(300);
				setTimeout(() => $("#message_box_many").slideUp(), 1000);
			}
		});
	}
	
	function mylist_box_re() {
		mylist_box_many.innerHTML = "";
	}
	
	
</script>