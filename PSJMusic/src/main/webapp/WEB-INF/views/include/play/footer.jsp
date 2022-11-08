<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<footer>
    <input id="play_bar" type="range" value="0">
    <div class="d-flex">
        <div class="col-1 p-3 mr-3">
        	<c:if test="${empty vos && empty vo }">
                <div class="controls-song mt-1">
                    <div id="controls_title" class="mb-1" title="오늘 뭐 듣지?">오늘 뭐 듣지?</div>
                    <div id="controls_artist" title="재생 버튼을 클릭 해 보세요">재생 버튼을 클릭 해 보세요</div>
                </div>
            </c:if>
        	<c:if test="${!empty vo }">
	            <div class="row">
	                <div class="controls-song ml-2 mt-2">
	                    <div id="controls_title" class="mb-1" title="${vo.SJ_SONG_TITLE }" >
	                    	<c:if test="${fn:length(vo.SJ_SONG_TITLE) <= 10 }">${vo.SJ_SONG_TITLE }</c:if>
	                    	<c:if test="${fn:length(vo.SJ_SONG_TITLE) > 10 }"><marquee scrollamount=3>${vo.SJ_SONG_TITLE }</marquee></c:if>
	                    </div>
	                    <div id="controls_artist" title="${vo.SJ_SONG_ARTIST }">${vo.SJ_SONG_ARTIST }</div>
	                </div>
	            </div>
            </c:if>
        	<c:if test="${!empty vos }">
	            <div class="row">
	                <div class="controls-song ml-2 mt-2">
	                    <div id="controls_title" class="mb-1" title="${vos[0].SJ_SONG_TITLE }">
							<c:if test="${fn:length(vo.SJ_SONG_TITLE) <= 10 }">${vos[0].SJ_SONG_TITLE }</c:if>
	                    	<c:if test="${fn:length(vo.SJ_SONG_TITLE) <= 10 }"><marquee scrollamount=3>${vos[0].SJ_SONG_TITLE }</marquee></c:if>
	                    </div>
	                    <div id="controls_artist" title="${vos[0].SJ_SONG_ARTIST }">${vos[0].SJ_SONG_ARTIST }</div>
	                </div>
	            </div>
            </c:if>
        </div>
        <div class="col-3 p-3 mt-1">
        	<c:if test="${empty sMid }">
	            <button id="like_btn1" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart" style="color: #fff;"></i></button>
	            <button id="like_btn2" style="display: none;" class="btn" type="button"><i class="fa-solid fa-heart text-danger" style="color: #fff;"></i></button>
        	</c:if>
        	<c:if test="${!empty sMid }">
        		<c:if test="${fn:contains(vo.SJ_SONG_LIKELIST, sMid) || fn:contains(vos[0].SJ_SONG_LIKELIST, sMid)}">
        			<button id="like_btn1" style="display: none;" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart" style="color: #fff;"></i></button>
	            	<button id="like_btn2" class="btn" type="button"><i class="fa-solid fa-heart text-danger" style="color: #fff;"></i></button>
        		</c:if>
        		<c:if test="${!(fn:contains(vo.SJ_SONG_LIKELIST, sMid) || fn:contains(vos[0].SJ_SONG_LIKELIST, sMid))}">
        			<button id="like_btn1" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart" style="color: #fff;"></i></button>
	            <button id="like_btn2" style="display: none;" class="btn" type="button"><i class="fa-solid fa-heart text-danger" style="color: #fff;"></i></button>
        		</c:if>
        	</c:if>
            <button id="lyrics_btn" class="btn" type="button" title="가사" data-toggle="modal" data-target="#myModal"><i class="fa-solid fa-music" style="color: #fff;"></i></button>
            <button id="addmore_btn" class="btn" type="button" title="더보기" data-toggle="modal" data-target="#moreShowModal"><i class="fa-solid fa-ellipsis" style="color: #fff;"></i></button>
        </div>
        <div class="col pt-2">
            <div id="shuffle_btn" class="btn" title="재생 방법 변경" style="background: #222; opacity: 0.5;"><i
                    class="fa-solid fa-shuffle" style="color: #fff;"></i></div>
            <button id="back_btn" class="btn" type="button"><i class="fa-solid fa-backward-step fa-2x" style="color: #fff;"></i></button>
            <button id="play_btn" class="btn" type="button" title="재생/일시정지 선택"><i
                    class="fa-regular fa-circle-play fa-3x"></i></button>
            <button id="pause_btn" style="display: none;" class="btn" type="button"><i
                    class="fa-regular fa-circle-pause fa-3x"></i></button>
            <button id="next_btn" class="btn" type="button"><i class="fa-solid fa-forward-step fa-2x" style="color: #fff;"></i></button>
            <div id="repeat_btn" class="btn" title="반복 재생 설정" style="background: #222; opacity: 0.5;"><i
                    class="fa-solid fa-repeat" style="color: #fff;"><span id="one_repeat_mark" style="font-size: 8px; display: none;">1</span></i></div>
        </div>
        <div class="ml-auto d-flex mt-4 mr-3">
            <div id="controls_time" class="mt-2">00:00 / 00:00</div>
            <div id="mute_btn1" class="ml-2"><button class="btn" type="button"><i
                        class="fa-solid fa-volume-high" style="color: #fff;"></i></button></div>
            <div id="mute_btn2" class="ml-2" style="display: none;"><button class="btn" type="button"><i
                        class="fa-solid fa-volume-xmark" style="color: #fff;"></i></button></div>
            <div class="ml-1 mt-1"><input id="volume_bar" type="range" min="0" max="100" <c:if test="${!empty cVol }">value="${cVol * 100 }"</c:if> /></div>
            <div id="vol_no" class="ml-1" style="font-size: 8px; margin-top: 12px;">
            	<c:if test="${empty cVol }">50</c:if>
            	<c:if test="${!empty cVol }">${fn:split(cVol * 100, ".")[0] }</c:if>
        	</div>
        </div>
    </div>
    <audio id="player" src="" <c:if test="${!empty cVol }">onloadstart="this.volume=${cVol }"</c:if>></audio>
</footer>