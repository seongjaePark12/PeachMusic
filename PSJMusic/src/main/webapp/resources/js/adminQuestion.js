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
		
		for(var i=0; i<questionForm.chk.length; i++){
			if(questionForm.chk[i].checked == true) delItems += questionForm.chk[i].value + "/";
		}
		
		$.ajax({
			type : "post",
			url : "../admin/questionListDel",
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
	function selectwhatCheck(){
		var ans = confirm("선택항목의 공지를 변경 하시겠습니까?");
		if(!ans) return false;
		var anserItems = "";
		var SJ_QUESTION_ANSER = questionForm.SJ_QUESTION_ANSER.value;
		
		for(var i=0; i<questionForm.chk.length; i++){
			if(questionForm.chk[i].checked == true) anserItems += questionForm.chk[i].value + "/";
		}
		$.ajax({
			type : "post",
			url : "../admin/questionListWhat",
			data:{
				anserItems:anserItems,
				SJ_QUESTION_ANSER : SJ_QUESTION_ANSER
				},
			success:function(){
				location.reload();
			},
			error:function(){
				alert("전송오류");
			}
		});			
	}