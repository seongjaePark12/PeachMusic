	// 선택항목 삭제하기(ajax)
	function selectDelCheck(idx){
		var ans = confirm("선택된 매거진를 삭제 하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "../admin/magazineListDel",
			data:{idx:idx},
			success:function(){
				location.reload();
			},
			error:function(){
				alert("전송오류");
			}
		});			
	}
