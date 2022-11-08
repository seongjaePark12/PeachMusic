<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	function pageCheck(){
  		var pageSize = document.getElementById("pageSize").value;
  		location.href= "../admin/main?sw=9&page="+${pag}+"&pageSize="+pageSize;
  	}
</script>
	<h2 style="text-align: center;">음원파일</h2>
		<div class="sticky">
			<ul class="pagination">
			<c:if test="${totPage == 0}"><p style="text-align:center">자료가 없습니다</p></c:if>
			<c:if test="${totPage != 0}">
				<c:if test="${pag != 1}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=9&pag=1&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="첫페이지">◀◀</a></li>
				</c:if>
				<c:if test="${curBlock > 0}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=9&pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="이전">◀</a></li>
				</c:if>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
					<c:if test="${i == pag && i <= totPage}">
						<li class="page-item active"><a href='${ctp}/admin/main?sw=9&pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
					<c:if test="${i != pag && i <= totPage}">
						<li class="page-item"><a href='${ctp}/admin/main?sw=9&pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${curBlock < lastBlock}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=9&pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="다음">▶</a></li>
				</c:if>
				<c:if test="${pag != totPage}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=9&pag=${totPage}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="마지막">▶▶</a></li>
				</c:if>
			</c:if>
		</ul>
	</div>
		<div class="mt-5">
			<audio id="player" src="" controls="controls"></audio>
			<form id="srchform" action="${ctp }/admin/srch">
				<div class="input-group mb-3 mr-5">
					<c:if test="${empty flag }"><div class="btn " style="background: #f5d9da;" title="파일 없는 곡 보기" onclick="location.href='${ctp}/admin/srch?sw=${sw}&pageNo=${pageNo}&noFile=1'">No File</div></c:if>
					<c:if test="${!empty flag }"><div class="btn " style="background: #f5d9da;" onclick="location.href='${ctp}/admin/main?sw=${sw }&pageNo=${pageNo }'">돌아가기</div></c:if>
					<div style="width: 50%"></div>
					<input id="srch" name="srch" type="text" class="form-control" placeholder="검색">
			  		<div class="input-group-append">
				    	<button id="srch_btn" class="btn" style="background: #f5d9da;" type="button">검색</button>
			  		</div>
		  		</div>
		  		<input type="hidden" name="sw" value="${sw }">
		  		<input type="hidden" name="pag" value="${pag }">
	  		</form>
			<table class="table text-center">
				<tr>
					<th>#</th>
					<th>제목</th>
					<th>가수</th>
					<th></th>
					<th>
						<button class="btn" style="background: #f5d9da;" type="button" onclick="$('#fup').click()">파일 선택</button>
						<button class="btn" style="background: #f5d9da;" type="button" onclick="play2()">미리 듣기</button>
					</th>
				</tr>
				<c:forEach var="vo" items="${vos}">
					<tr>
						<td>${vo.SJ_SONG_IDX }</td>
						<td title="${vo.SJ_SONG_TITLE }">
							<c:if test="${fn:length(vo.SJ_SONG_TITLE) >= 20 }">${fn:substring(vo.SJ_SONG_TITLE, 0, 20) }...</c:if>
							<c:if test="${fn:length(vo.SJ_SONG_TITLE) < 20 }">${vo.SJ_SONG_TITLE }</c:if>
						</td>
						<td>${vo.SJ_SONG_ARTIST }</td>
						<td>
							<c:if test="${vo.SJ_SONG_ISFILE == 0}">음원 파일 없음</c:if>
						</td>
						<td>
							<button class="btn" style="background: #f5d9da;" type="button" onclick="play1(`${vo.SJ_SONG_TITLE}`, `${vo.SJ_SONG_ARTIST }`)">재생</button>
							<button class="btn" style="background: #f5d9da;" type="button" onclick="fileupload(${vo.SJ_SONG_IDX})">파일 업로드</button>
							<input type="file" id="fup" style="display: none;">
						</td>
					</tr>
				</c:forEach>
			</table>
			<button class="btn pull-right" style="background: #f5d9da;" type="button" title="파일 존재 유무를 업데이트 합니다" onclick="javascript:location.href='${ctp}/admin/isFileUpdate?sw=${sw}&pageNo=${pageNo}'">업데이트</button>
		</div>
