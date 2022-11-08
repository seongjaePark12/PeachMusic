	  	// 개별회원검색
	  	function songSearch() {
				var song = musicform.song.value;
				if(song == ""){
					alert("음악를 입력하세요");
					musicform.song.focus();
				}else{
					location.href="../admin/main?sw=1&song="+song;
				}
			}
	  	
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
				var ans = confirm("선택된 음악을 삭제 하시겠습니까?");
				if(!ans) return false;
				var delItems = "";
				
				for(var i=0; i<musicform.chk.length; i++){
					if(musicform.chk[i].checked == true) delItems += musicform.chk[i].value + "/";
				}
				
				$.ajax({
					type : "post",
					url : "../admin/musicListDel",
					data:{delItems:delItems},
					success:function(){
						location.reload();
					},
					error:function(){
						alert("전송오류");
					}
				});			
			}
