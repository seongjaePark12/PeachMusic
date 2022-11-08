	  function upload(idx1,flag1) {
  		let idx = idx1;
  		let flag = flag1;
  		let query = {
  				idx : idx,
  				flag : flag
  		}
			
  		$.ajax({
    		type  : "post",
    		url   : "../admin/bannerChoice",
    		data  : query,
    		success:function() {
    			location.reload();
    			alert("배너가 변경되었습니다.");
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    } 
  	function bannerDelete(idx) {
  		let ans = confirm("선택된 배너를 삭제 하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "../admin/bannerDelete",
				data:{idx:idx},
				success:function(){
					location.reload();
				},
				error:function(){
					alert("전송오류");
				}
			});
  	}	