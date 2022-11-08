<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	function whatCheck(){
  		var pageSize = document.getElementById("pageSize").value;
  		var what = document.getElementById("what").value;
  		location.href= "../admin/main?sw=6&page="+${pag}+"&pageSize="+pageSize+"&what="+what;
  	}
</script>
	  <form name="questionForm" method="post">
	  	<h2 style="text-align: center;">Q ＆ A</h2>
			<table class="table table-borderless">
		    <tr>
		      <td class="text-left p-0">
		      	<select class="w3-panel w3-border w3-round-xxlarge font6" name="what" id="what" onchange="whatCheck()">
							<option value="" ${what == '' ? 'selected' : ''}>문의유형 전체</option>
							<option value="음악업로드해주세요" ${what == '음악업로드해주세요' ? 'selected' : ''}>음악 업로드 해주세요!</option>
							<option value="음원관련문의" ${what == '음원관련문의' ? 'selected' : ''}>음원 관련 문의</option>
							<option value="회원관련문의" ${what == '회원관련문의' ? 'selected' : ''}>회원 관련 문의</option>
							<option value="결제관련문의" ${what == '결제관련문의' ? 'selected' : ''}>결제 관련 문의</option>
							<option value="기타" ${what == '기타' ? 'selected' : ''}>기타</option>
						</select>
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
						<select name="SJ_QUESTION_ANSER" onchange="selectwhatCheck()">
								<option value="">답변변경</option>
								<option value="1">답변완료</option>
								<option value="0">답변대기</option>
						</select>					
					</td>
				</tr>
	  	</table>
		  <table class="table table-hover text-center">
		    <tr class="text-dark" style="background: #f5d9da;">
		    	<th style="width:5%">선택</th>
		      <th style="width:5%">번호</th>
		    	<th style="width:10%">답변</th>
		      <th style="width:8%">문의유형</th>
		      <th style="width:35%">제목</th>
		      <th style="width:12%">작성자</th>
		      <th style="width:10%">작성일</th>
		    </tr>
		    <c:forEach var="questionVO" items="${questionvos}">
			    <tr>
		   			<td><input type="checkbox" name="chk" class="chk" value="${questionVO.SJ_QUESTION_IDX}"/></td>
			    	<td>${curScrStartNo}</td>
			    	<td>
			    		<c:if test="${questionVO.SJ_QUESTION_ANSER == 1}"><font color="blue"><b>답변완료</b></font></c:if>
			    		<c:if test="${questionVO.SJ_QUESTION_ANSER == 0}"><font color="red"><b>답변대기</b></font></c:if>
			    	</td>
			    	<td>
			    		<c:if test="${questionVO.SJ_QUESTION_WHAT == '음악업로드해주세요'}">음악업로드</c:if>
			    		<c:if test="${questionVO.SJ_QUESTION_WHAT == '음원관련문의'}">음원문의</c:if>
			    		<c:if test="${questionVO.SJ_QUESTION_WHAT == '회원관련문의'}">회원문의</c:if>
			    		<c:if test="${questionVO.SJ_QUESTION_WHAT == '결제관련문의'}">결제문의</c:if>
			    		<c:if test="${questionVO.SJ_QUESTION_WHAT == '기타'}">기타</c:if>
			    	</td>
			      <td>
			      	<a href="${ctp}/admin/qaContent?idx=${questionVO.SJ_QUESTION_IDX}&pag=${pag}&pageSize=${pageSize}">${questionVO.SJ_QUESTION_TITLE}</a>
			      </td>
			      <td>${questionVO.SJ_USER_MID}</td>
			      <td>
			      	<c:if test="${questionVO.diffTime <= 24}">${fn:substring(questionVO.SJ_QUESTION_DATE,11,16)}</c:if>
			      	<c:if test="${questionVO.diffTime >= 24}">${fn:substring(questionVO.SJ_QUESTION_DATE,0,10)}</c:if>
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
					<li class="page-item"><a href="${ctp}/admin/main?sw=6&pag=1&pageSize=${pageSize}&what=${what}" class="page-link" style="background: #f5d9da;color:black;" title="첫페이지">◀◀</a></li>
				</c:if>
				<c:if test="${curBlock > 0}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=6&pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&what=${what}" class="page-link" style="background: #f5d9da;color:black;" title="이전">◀</a></li>
				</c:if>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
					<c:if test="${i == pag && i <= totPage}">
						<li class="page-item active"><a href='${ctp}/admin/main?sw=6&pag=${i}&pageSize=${pageSize}&what=${what}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
					<c:if test="${i != pag && i <= totPage}">
						<li class="page-item"><a href='${ctp}/admin/main?sw=6&pag=${i}&pageSize=${pageSize}&what=${what}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${curBlock < lastBlock}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=6&pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&what=${what}" class="page-link" style="background: #f5d9da; color:black;" title="다음">▶</a></li>
				</c:if>
				<c:if test="${pag != totPage}">
					<li class="page-item"><a href="${ctp}/admin/main?sw=6&pag=${totPage}&pageSize=${pageSize}&what=${what}" class="page-link" style="background: #f5d9da; color:black;" title="마지막">▶▶</a></li>
				</c:if>
			</c:if>
		</ul>
	</div>