	  	// 개별회원검색
	  	function midSearch() {
				var mid = userform.mid.value;
				if(mid == ""){
					alert("아이디를 입력하세요");
					userform.mid.focus();
				}else{
					location.href="../admin/main?sw=4&mid="+mid;
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
				var ans = confirm("선택된 회원을 삭제 하시겠습니까?");
				if(!ans) return false;
				var delItems = "";
				
				for(var i=0; i<userform.chk.length; i++){
					if(userform.chk[i].checked == true) delItems += userform.chk[i].value + "/";
				}
				
				$.ajax({
					type : "post",
					url : "../admin/memberListDel",
					data:{delItems:delItems},
					success:function(){
						location.reload();
					},
					error:function(){
						alert("전송오류");
					}
				});			
			}
