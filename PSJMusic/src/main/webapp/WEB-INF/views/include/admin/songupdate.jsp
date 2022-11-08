<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	function pageCheck(){
  		var pageSize = document.getElementById("pageSize").value;
  		location.href= "../admin/main?sw=8&page="+${pag}+"&pageSize="+pageSize;
  	}
</script>
	<h2 style="text-align: center;">음악 업데이트</h2>
		<c:if test="${empty flag }">
			<div class="sticky">
				<ul class="pagination">
				<c:if test="${totPage == 0}"><p style="text-align:center">자료가 없습니다</p></c:if>
				<c:if test="${totPage != 0}">
					<c:if test="${pag != 1}">
						<li class="page-item"><a href="${ctp}/admin/main?sw=8&pag=1&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="첫페이지">◀◀</a></li>
					</c:if>
					<c:if test="${curBlock > 0}">
						<li class="page-item"><a href="${ctp}/admin/main?sw=8&pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da;color:black;" title="이전">◀</a></li>
					</c:if>
					<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
						<c:if test="${i == pag && i <= totPage}">
							<li class="page-item active"><a href='${ctp}/admin/main?sw=8&pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
						</c:if>
						<c:if test="${i != pag && i <= totPage}">
							<li class="page-item"><a href='${ctp}/admin/main?sw=8&pag=${i}&pageSize=${pageSize}' class="page-link text-dark" style="background: #f5d9da;color:black;">${i}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${curBlock < lastBlock}">
						<li class="page-item"><a href="${ctp}/admin/main?sw=8&pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="다음">▶</a></li>
					</c:if>
					<c:if test="${pag != totPage}">
						<li class="page-item"><a href="${ctp}/admin/main?sw=8&pag=${totPage}&pageSize=${pageSize}" class="page-link" style="background: #f5d9da; color:black;" title="마지막">▶▶</a></li>
					</c:if>
				</c:if>
			</ul>
				<form id="srchform" action="${ctp }/admin/srch">
					<div class="input-group mb-3 mr-5">
						<input id="srch" name="srch" type="text" class="form-control" placeholder="검색">
				  		<div class="input-group-append">
					    	<button id="srch_btn" class="btn"style="background: #f5d9da;" type="button">검색</button>
				  		</div>
			  		</div>
			  		<input type="hidden" name="sw" value="${sw }">
			  		<input type="hidden" name="pag" value="${pag }">
		  		</form>
			</div>
		</c:if>
	    <div class="sticky2">
	    	<input class="btn"style="background: #f5d9da;" type="button" value="추가" data-toggle="modal" data-target="#addSongModal">
	    	<input class="btn"style="background: #f5d9da;" type="button" value="변경사항 적용" onclick="commit()">
    	</div>
		<div class="mt-3">
			<form method="post" name="myform">
			<div>수정 하려는 항목을 더블 클릭 하세요!</div>
				<table class="table table-bordered">
					<thead style="background: #f5d9da;">
						<tr>
							<th class="text-right" style="width: 50px;">#</th>
							<th style="width: 80px;">썸네일</th>
							<th>제목</th>
							<th>가수</th>
							<th>앨범명</th>
							<th>발매일</th>
							<th>장르</th>
							<th>작곡</th>
							<th>작사</th>
							<th>편곡</th>
							<th>가사</th>
						</tr>
					</thead>
             <c:forEach var="vo" items="${vos }" varStatus="st">
              <tr>
                  <td class="text-right align-middle">${vo.SJ_SONG_IDX}</td>
                  <td class="text-center"><div class="imgBox"><img src="${vo.SJ_SONG_IMG }" alt=""></div></td>
                  <td class="align-middle" style="overflow: hidden;" title="${vo.SJ_SONG_TITLE }">
                  	<c:if test="${fn:length(vo.SJ_SONG_TITLE) > 35 }">${fn:substring(vo.SJ_SONG_TITLE, 0, 35) }...</c:if>
                  	<c:if test="${fn:length(vo.SJ_SONG_TITLE) < 35 }">${vo.SJ_SONG_TITLE }</c:if>
                 	</td>
                  <td class="align-middle" title="${vo.SJ_SONG_ARTIST }">${vo.SJ_SONG_ARTIST }</td>
                  <td class="align-middle" ondblclick="updt_album(${vo.SJ_SONG_IDX}, `${vo.SJ_SONG_ALBUM }`)" title="${vo.SJ_SONG_ALBUM }"><div class="ho" id="SJ_SONG_ALBUM-${vo.SJ_SONG_IDX }" >${fn:substring(vo.SJ_SONG_ALBUM, 0, 5) }<c:if test="${!empty vo.SJ_SONG_ALBUM }">...</c:if></div></td>
                  <td class="align-middle" ondblclick="updt_releaseDate(${vo.SJ_SONG_IDX}, `${vo.SJ_SONG_DATE }`)" title="${vo.SJ_SONG_DATE }"><div class="ho" id="SJ_SONG_DATE-${vo.SJ_SONG_IDX }" >${fn:substring(vo.SJ_SONG_DATE, 0, 5) }<c:if test="${!empty vo.SJ_SONG_DATE }">...</c:if></div></td>
                  <td class="align-middle" ondblclick="updt_genre(${vo.SJ_SONG_IDX}, `${vo.SJ_SONG_GENRE }`)" title="${vo.SJ_SONG_GENRE }"><div class="ho" id="SJ_SONG_GENRE-${vo.SJ_SONG_IDX }" >${fn:substring(vo.SJ_SONG_GENRE, 0, 5) }<c:if test="${!empty vo.SJ_SONG_GENRE }">...</c:if></div></td>
                  <td class="align-middle" ondblclick="updt_music(${vo.SJ_SONG_IDX}, `${vo.SJ_SONG_COMPOSING }`)" title="${vo.SJ_SONG_COMPOSING }"><div class="ho" id="SJ_SONG_COMPOSING-${vo.SJ_SONG_IDX }" >${fn:substring(vo.SJ_SONG_COMPOSING, 0, 5) }<c:if test="${!empty vo.SJ_SONG_COMPOSING }">...</c:if></div></td>
                  <td class="align-middle" ondblclick="updt_words(${vo.SJ_SONG_IDX}, `${vo.SJ_SONG_WRITE }`)" title="${vo.SJ_SONG_WRITE }"><div class="ho" id="SJ_SONG_WRITE-${vo.SJ_SONG_IDX }" >${fn:substring(vo.SJ_SONG_WRITE, 0, 5) }<c:if test="${!empty vo.SJ_SONG_WRITE }">...</c:if></div></td>
                  <td class="align-middle" ondblclick="updt_arranger(${vo.SJ_SONG_IDX}, `${vo.SJ_SONG_ARRANGE }`)" title="${vo.SJ_SONG_ARRANGE }"><div class="ho" id="SJ_SONG_ARRANGE-${vo.SJ_SONG_IDX }" >${fn:substring(vo.SJ_SONG_ARRANGE, 0, 5) }<c:if test="${!empty vo.SJ_SONG_ARRANGE }">...</c:if></div></td>
                  <td class="align-middle" ondblclick="updt_lyrics(${vo.SJ_SONG_IDX}, `${vo.SJ_SONG_LYRICS }`)" title="${vo.SJ_SONG_LYRICS }"><div class="ho" id="SJ_SONG_LYRICS-${vo.SJ_SONG_IDX }" >${fn:substring(vo.SJ_SONG_LYRICS, 0, 5) }<c:if test="${!empty vo.SJ_SONG_LYRICS }">...</c:if></div></td>
                  <td class="align-middle text-center">
                  	<div class="ho" onclick="more(${vo.SJ_SONG_IDX})" data-toggle="modal" data-target="#myModal">더보기</div>
                 	</td>
              </tr>
             </c:forEach>
         </table>
         <input type="hidden" name="sw" value="${sw }" >
         <input type="hidden" id="demo" name="item">
         <input type="hidden" name="pag" value="${pag}">
     </form>
		</div>
		<c:if test="${!empty flag }"><div class="btn" style="background: #f5d9da;" onclick="location.href='${ctp}/admin/main?sw=${sw }&pageNo=${pageNo }'">돌아가기</div></c:if>