	// 전체선택
	$(function(){
		$("#checkAll").click(function(){
			if($("#checkAll").prop("checked")){
				$(".chk").prop("checked", true);
			}
			else{
				$(".chk").prop("checked", false);
			}
		});
	});
	// 선택항목 삭제하기(ajax)
	function selectDelCheck(){
		var ans = confirm("선택된 문의를 삭제 하시겠습니까?");
		if(!ans) return false;
		var delItems = "";
		
		for(var i=0; i<noticeForm.chk.length; i++){
			if(noticeForm.chk[i].checked == true) delItems += noticeForm.chk[i].value + "/";
		}
		
		$.ajax({
			type : "post",
			url : "../admin/noticeListDel",
			data:{delItems:delItems},
			success:function(){
				location.reload();
			},
			error:function(){
				alert("전송오류");
			}
		});			
	}
	// 선택항목 공지수정(ajax)
	function selectLevelCheck(){
		var ans = confirm("선택항목의 공지를 변경 하시겠습니까?");
		if(!ans) return false;
		var anserItems = "";
		var SJ_NOTICE_NOTICE = noticeForm.SJ_NOTICE_NOTICE.value;
		
		for(var i=0; i<noticeForm.chk.length; i++){
			if(noticeForm.chk[i].checked == true) anserItems += noticeForm.chk[i].value + "/";
		}
		$.ajax({
			type : "post",
			url : "../admin/noticeListAnser",
			data:{
				anserItems:anserItems,
				SJ_NOTICE_NOTICE : SJ_NOTICE_NOTICE
				},
			success:function(){
				location.reload();
			},
			error:function(){
				alert("전송오류");
			}
		});			
	}