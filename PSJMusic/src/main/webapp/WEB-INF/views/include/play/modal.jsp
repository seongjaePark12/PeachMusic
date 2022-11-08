<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("enter", "\n"); %>

<style>
	#myModal {
		color: white;
	}
</style>

<div class="modal" id="myModal">
	<div class="modal-dialog modal-dialog-scrollable">
  		<div class="modal-content" style="background: black;">
      
	        <!-- Modal Header -->
	        <div class="container mt-3">
		        <table>
		        	<tr>
		        		<td><div style="width:200px"><img id="modal_i" src=""></div></td>
		        		<td style="vertical-align: top;"><div class="p-3">
				      		<h2 id="modal_t" class=""><b>제목</b></h2>
				      		<div id="modal_a" >가수</div>
		      			</div></td>
		        	</tr>
		        </table>
	        </div>
      		<div class="modal-header">
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	  			<h5><b>가사</b></h5>
	          	<div id="modal_c" class="mt-3" style="color: gray;">준비중 입니다.</div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	      		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        </div>
        
  		</div>
	</div>
</div>