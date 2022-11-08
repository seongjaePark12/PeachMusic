<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	function pageCheck(){
  		var pageSize = document.getElementById("pageSize").value;
  		location.href= "../admin/main?sw=5&page="+${pag}+"&pageSize="+pageSize;
  	}
</script>
	  <form name="noticeForm" method="post">
	  	<h2 style="text-align: center;">NOTICE</h2>
			<table class="table table-borderless">
		    <tr>
		      <td class="text-left p-0">
		        <a href="${ctp}/admin/noticeInput" class="btn btn-outline w3-border w3-round-xxlarge" style="background: #f5d9da;">글쓰기</a>
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
		    <tr>
					<td>
						<input type="checkbox" id="checkAll"/>전체선택/해제 &nbsp;
						<input type="button" value="선택항목 삭제" onclick="selectDelCheck()" class="btn btn-sm" style="background: #f5d9da;"/>
						<select name="SJ_NOTICE_NOTICE" onchange="selectLevelCheck()">
								<option value="">공지변경</option>
								<option value="1">Main공지</option>
								<option value="0">비공지</option>
						</select>					
					</td>
				</tr>
	  	</table>
		  <table class="table table-hover text-center">
		    <tr class="text-dark" style="background: #f5d9da;">
		    	<th style="width:5%">공지</th>
		    	<th style="width:5%">선택</th>
		      <th style="width:5%">번호</th>
		      <th style="width:48%">제목</th>
		      <th style="width:12%">작성자</th>
		      <th style="width:10%">작성일</th>
		    </tr>
		    <c:forEach var="noticevo" items="${noticevos}">
			    <tr>
			    	<td><c:if test="${noticevo.SJ_NOTICE_NOTICE == 1}"><font color="red"><b>공지</b></font></c:if></td>
		   			<td><input type="checkbox" name="chk" class="chk" value="${noticevo.SJ_NOTICE_IDX}"/></td>
			    	<td>${curScrStartNo}</td>
			      <td>
			      	<a href="${ctp}/admin/noticeContent?idx=${noticevo.SJ_NOTICE_IDX}&pag=${pag}&pageSize=${pageSize}">${noticevo.SJ_NOTICE_TITLE}</a>
			      	<c:if test="${noticevo.diffTime <= 24}"><img src="${ctp}/images/new.png" width="40px" height="20px"/></c:if>
			      </td>
			      <td>${noticevo.SJ_NOTICE_NAME}</td>
			      <td>
			      	<c:if test="${noticevo.diffTime <= 24}">${fn:substring(noticevo.SJ_NOTICE_DATENOW,11,16)}</c:if>
			      	<c:if test="${noticevo.diffTime >= 24}">${fn:substring(noticevo.SJ_NOTICE_DATENOW,0,10)}</c:if>
			      </td>
			    </tr>
			    <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		    </c:forEach>
		  </table>
		  </form>
 <!-- 블록 페이징처리 시작(bs4 스타일 적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${totPage == 0}"><p style="text-align:center">자료가 없습니다</p></c:if>
			<c:if test="${totPage != 0}">
				<c:if test="${pag != 1}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=5&pag=1&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="첫페이지">◀◀</a></li>
				</c:if>
				<c:if test="${curBlock > 0}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=5&pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="이전">◀</a></li>
				</c:if>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
					<c:if test="${i == pag && i <= totPage}">
						<li class="page-item active"><a href='${ctp}/admin/main?sw=5&pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
					<c:if test="${i != pag && i <= totPage}">
						<li class="page-item"><a href='${ctp}/admin/main?sw=5&pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${curBlock < lastBlock}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=5&pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="다음">▶</a></li>
				</c:if>
				<c:if test="${pag != totPage}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=5&pag=${totPage}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="마지막">▶▶</a></li>
				</c:if>
			</c:if>
		</ul>
	</div>