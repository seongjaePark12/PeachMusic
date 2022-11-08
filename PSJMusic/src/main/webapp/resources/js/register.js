 $('#allcheck').on('click', function(){
	    	var checked = $(this).is(':checked');
	        
	        if(checked) {
	        	$(this).closest('.agreement-container').find('.input-check').prop('checked', true);
	        } else {
	        	$(this).closest('.agreement-container').find('.input-check').prop('checked', false);
	        }
	    });
	    
	    window.onload = function(){
	        var checkWrap = document.getElementById('checkWrap'),
	            check = checkWrap.getElementsByTagName('input');
	        checkWrap.addEventListener('click', function(e){
	            var target = e.target,
	                checkNum = 0;
	            if(target === check[0]){
	                if(target.checked){
	                    for(var i = 1;i < check.length;i++){
	                        check[i].checked = true;
	                    };
	                }else{
	                    for(var i = 1;i < check.length;i++){
	                        check[i].checked = false;
	                    };
	                };
	            }else{
	                for(var i = 1;i < check.length;i++){
	                    if(check[i].checked){
	                        checkNum++;
	                    };
	                };
	                if(checkNum >= check.length - 1){
	                    check[0].checked = true;
	                }else{
	                    check[0].checked = false;
	                };
	            };
	        });
	    };
	    
	    function fCheck() {
	    	var checkWrap = document.getElementById('checkWrap'),
            check = checkWrap.getElementsByTagName('input');
	    	
	    	if(!check[1].checked || !check[2].checked) {
	    		alert("필수 항목을 동의해주세요.");
	    		return false;
	    	}
	    	
	    	myForm.submit();
		}