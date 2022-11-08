<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<style>
	.imgBox:hover {
		opacity: 0.7;
		cursor: pointer;
	}
	
	#listCnt {
		position: fixed;
		top: 15px;
		right: 50px;
	}
</style>
<div id="play_listContainer">
	<img id="play_listbg" src="${img2000 }">
	<div id="play_listImg">
		<div>
			<c:if test="${empty sPlaylist }"><img id="play_listImg_img" style="width: 100%;" src="${img1000}"></c:if>
			<c:if test="${!empty sPlaylist }"><img id="play_listImg_img" src="${fn:replace(sPlaylist[0].SJ_SONG_IMG, '50', '400') }"></c:if>
		</div>
	</div>
	<div id="play_listBox">
		<div id="listCnt">
			<c:if test="${!empty vo }">1 곡</c:if>
			<c:if test="${!empty vos }">${fn:length(vos) } 곡</c:if>
		</div>
	    <div class="mt-3">
	        <div id="play_list" class="pfc" tabindex="0">
				<c:if test="${!empty vo }">
		        	<div id="p_${vo.SJ_SONG_IDX }" class='d-flex p-3'>
		        		<div class='imgBox mr-3'>
		        			<img src='${vo.SJ_SONG_IMG}' title="재생" onclick="startThis(${vo.SJ_SONG_IDX})">
	        			</div>
		    			<div>
		    				<div class='playlist_t' title="${vo.SJ_SONG_TITLE }">
		    					<c:if test="${fn:length(vo.SJ_SONG_TITLE) > 13 }">${fn:substring(vo.SJ_SONG_TITLE, 0, 13) }...</c:if>
		    					<c:if test="${fn:length(vo.SJ_SONG_TITLE) <= 13 }">${vo.SJ_SONG_TITLE }</c:if>
		    				</div>
		    				<div class='playlist_a' title="${vo.SJ_SONG_ARTIST }">
		    					<c:if test="${fn:length(vo.SJ_SONG_ARTIST) > 13 }">${fn:substring(vo.SJ_SONG_ARTIST, 0, 13) }...</c:if>
		    					<c:if test="${fn:length(vo.SJ_SONG_ARTIST) <= 13 }">${vo.SJ_SONG_ARTIST }</c:if>
	    					</div>
		    			</div>
		    			<div class='ml-auto'>
		    				<button name='delete_btn' type='button' class='btn' onclick='delList(${vo.SJ_SONG_IDX})' ><i title="플레이리스트에서 제거" class='fa-regular fa-trash-can'></i></button>
						</div>
					</div>
				</c:if>
				<c:if test="${!empty vos }">
					<c:forEach var="vo" items="${vos }" varStatus="st">
			        	<div id="p_${vo.SJ_SONG_IDX }" class='d-flex p-3'>
			        		<div class='imgBox mr-3'>
			        			<img src='${vo.SJ_SONG_IMG}' title="재생" onclick="startThis(${vo.SJ_SONG_IDX})">
		        			</div>
			    			<div>
			    				<div class='playlist_t' title="${vo.SJ_SONG_TITLE }">
				    				<c:if test="${fn:length(vo.SJ_SONG_TITLE) > 13 }">${fn:substring(vo.SJ_SONG_TITLE, 0, 13) }...</c:if>
			    					<c:if test="${fn:length(vo.SJ_SONG_TITLE) <= 13 }">${vo.SJ_SONG_TITLE }</c:if>
			    				</div>
			    				<div class='playlist_a' title="${vo.SJ_SONG_ARTIST }">
				    				<c:if test="${fn:length(vo.SJ_SONG_ARTIST) > 13 }">${fn:substring(vo.SJ_SONG_ARTIST, 0, 13) }...</c:if>
			    					<c:if test="${fn:length(vo.SJ_SONG_ARTIST) <= 13 }">${vo.SJ_SONG_ARTIST }</c:if>
			    				</div>
			    			</div>
			    			<div class='ml-auto'>
			    				<button name='delete_btn' type='button' class='btn' onclick='delList(${vo.SJ_SONG_IDX })' ><i title="플레이리스트에서 제거" class='fa-regular fa-trash-can'></i></button>
							</div>
						</div>
					</c:forEach>
				</c:if>
	        </div>
	    </div>
	</div>
</div>
