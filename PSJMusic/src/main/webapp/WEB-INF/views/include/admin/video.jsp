<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	function pageCheck(){
  		var pageSize = document.getElementById("pageSize").value;
  		location.href= "../admin/main?sw=2&page="+${pag}+"&pageSize="+pageSize;
  	}
</script>
	  <form name="videoForm" method="post">
	  	<h2 style="text-align: center;">피치TV</h2>
			<table class="table table-borderless">
		    <tr>
		      <td class="text-left p-0">
		        <a href="${ctp}/admin/videoInput" class="btn btn-outline w3-border w3-round-xxlarge" style="background: #f5d9da;">영상 업로드</a>
		      </td>
		      <td class="text-right p-0">
						<select class="w3-panel w3-border w3-round-xxlarge font6" name="pageSize" id="pageSize" onchange="pageCheck()">
							<option value="5" ${pageSize==5 ? 'selected' : ''}>5건</option>
							<option value="10" ${pageSize==10 ? 'selected' : ''}>10건</option>
							<option value="15" ${pageSize==15 ? 'selected' : ''}>15건</option>
							<option value="20" ${pageSize==20 ? 'selected' : ''}>20건</option>
							<option value="50" ${pageSize==50 ? 'selected' : ''}>50건</option>
						</select>
		      </td>
		    </tr>
	  	</table>
	  		<div class="w3-display-container w3-margin w3-padding-16">
					<div class="row">
	  				<c:forEach var="videoVo" items="${videovos}">
							<div class="col-lg-3 w3-margin-bottom">
								<div class="card border-0">
									<div class="card-header p-0" style="background: #f5d9da;">
										<a href="${ctp}/admin/videoContent?idx=${videoVo.SJ_VIDEO_IDX}&pag=${pag}&pageSize=${pageSize}">
											<img src="${videoVo.SJ_VIDEO_IMG}" class="card-img-bottom img-fluid" width="100px;">
										</a>
										<div class="text-left">
											<h4 style="color: black; font-size: 16px;"><a href="${ctp}/admin/videoContent?idx=${videoVo.SJ_VIDEO_IDX}&pag=${pag}&pageSize=${pageSize}"><b>${videoVo.SJ_VIDEO_TITLE}</b></a></h4>
										</div>
										<div class="w3-border-top w3-border-bottom w3-border-pink">
											<input type="button" value="비디오 수정" onclick="location.href='${ctp}/admin/videoUpdate?idx=${videoVo.SJ_VIDEO_IDX}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-sm"/>
											<input type="button" value="비디오 삭제" onclick="selectDelCheck(${videoVo.SJ_VIDEO_IDX})" class="btn btn-sm"/>
										</div>
									</div>
								</div>
							</div>
			  		</c:forEach>
					</div>
				</div>				
		  </form>
 <!-- 블록 페이징처리 시작(bs4 스타일 적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${totPage == 0}"><p style="text-align:center">자료가 없습니다</p></c:if>
			<c:if test="${totPage != 0}">
				<c:if test="${pag != 1}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=2&pag=1&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="첫페이지">◀◀</a></li>
				</c:if>
				<c:if test="${curBlock > 0}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=2&pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="이전">◀</a></li>
				</c:if>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
					<c:if test="${i == pag && i <= totPage}">
						<li class="page-item active"><a href='${ctp}/admin/main?sw=2&pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
					<c:if test="${i != pag && i <= totPage}">
						<li class="page-item"><a href='${ctp}/admin/main?sw=2&pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${curBlock < lastBlock}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=2&pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="다음">▶</a></li>
				</c:if>
				<c:if test="${pag != totPage}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=2&pag=${totPage}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="마지막">▶▶</a></li>
				</c:if>
			</c:if>
		</ul>
	</div>