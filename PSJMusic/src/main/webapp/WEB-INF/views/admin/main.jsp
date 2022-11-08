<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자</title>
	
	<jsp:include page="/WEB-INF/views/include/bootstrap.jsp"/>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<link rel="icon" href="${ctp}/images/title/title.ico">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/admin.css">
	<!-- 0: 차트 1:음악 2: 비디오 3: 매거진 4: 회원 5: 공지 6: 질문 7: 배너 -->
	<c:if test="${sw == 2}"><script src="${ctp}/js/adminVideo.js"></script></c:if>
	<c:if test="${sw == 3}"><script src="${ctp}/js/adminMagazine.js"></script></c:if>
	<c:if test="${sw == 4}"><script src="${ctp}/js/adminUser.js"></script></c:if>
	<c:if test="${sw == 5}"><script src="${ctp}/js/adminNotice.js"></script></c:if>
	<c:if test="${sw == 6}"><script src="${ctp}/js/adminQuestion.js"></script></c:if>
	<c:if test="${sw == 7}">
		<link rel="stylesheet" href="${ctp}/css/banner.css">
		<script src="${ctp}/js/adminBanner.js"></script>
	</c:if>
</head>
<style>
	.ho:hover {
		cursor: pointer;
	}
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/nav/adminNav.jsp"/>
	<jsp:include page="/WEB-INF/views/include/play/modal.jsp" />
	<jsp:include page="/WEB-INF/views/include/addsongform.jsp" />
	<c:if test="${sw == 0}">
		<jsp:include page="/WEB-INF/views/include/admin/main.jsp" />
	</c:if>
	<c:if test="${sw != 0}">
		<div id="section">
			<!-- 0: 차트 1:음악 2: 비디오 3: 매거진 4: 회원 5: 공지 6: 질문 7: 배너 -->
			<c:if test="${sw == 1}">
				<jsp:include page="/WEB-INF/views/include/admin/chart.jsp" />
			</c:if>
			<c:if test="${sw == 2}">
				<jsp:include page="/WEB-INF/views/include/admin/video.jsp" />
			</c:if>
			<c:if test="${sw == 3}">
				<jsp:include page="/WEB-INF/views/include/admin/magazine.jsp" />
			</c:if>
			<c:if test="${sw == 4}">
				<jsp:include page="/WEB-INF/views/include/admin/user.jsp" />
			</c:if>
			<c:if test="${sw == 5}">
				<jsp:include page="/WEB-INF/views/include/admin/notice.jsp" />
			</c:if>
			<c:if test="${sw == 6}">
				<jsp:include page="/WEB-INF/views/include/admin/question.jsp" />
			</c:if>
			<c:if test="${sw == 7}">
				<jsp:include page="/WEB-INF/views/include/admin/banner.jsp" />
			</c:if>
			<c:if test="${sw == 8}">
				<jsp:include page="/WEB-INF/views/include/admin/songupdate.jsp" />
			</c:if>
			<c:if test="${sw == 9}">
				<jsp:include page="/WEB-INF/views/include/admin/fileupload.jsp" />
			</c:if>
		</div>
	</c:if>	
	<c:if test="${sw != 1}"><jsp:include page="/WEB-INF/views/include/main/footer.jsp"/></c:if>
		<script>
		var item = "";
	
		function updt_album(idx, SJ_SONG_ALBUM) {
			let albumId = "SJ_SONG_ALBUM-" + idx;
			$("#" + albumId).html("<input class='form-control' type='text' name='" + albumId +"' value='" + SJ_SONG_ALBUM + "' autofocus >");
			
			item += albumId + "/";
		}
	
		function updt_releaseDate(idx, SJ_SONG_DATE) {
			let releaseDateId = "SJ_SONG_DATE-" + idx;
			$("#" + releaseDateId).html("<input class='form-control' type='text' name='" + releaseDateId +"' value='" + SJ_SONG_DATE + "' autofocus >");
			
			item += releaseDateId + "/";
		}
		
		function updt_genre(idx, SJ_SONG_GENRE) {
			let genreId = "SJ_SONG_GENRE-" + idx;
			$("#" + genreId).html("<input class='form-control' type='text' name='" + genreId +"' value='" + SJ_SONG_GENRE + "' autofocus >");
			
			item += genreId + "/";
		}
		
		function updt_music(idx, SJ_SONG_COMPOSING) {
			let musicId = "SJ_SONG_COMPOSING-" + idx;
			$("#" + musicId).html("<input class='form-control' type='text' name='" + musicId +"' value='" + SJ_SONG_COMPOSING + "' autofocus >");
			
			item += musicId + "/";
		}
		
		function updt_words(idx, SJ_SONG_WRITE) {
			let wordsId = "SJ_SONG_WRITE-" + idx;
			$("#" + wordsId).html("<input class='form-control' type='text' name='" + wordsId +"' value='" + SJ_SONG_WRITE + "' autofocus >");
			
			item += wordsId + "/";
		}
		
		function updt_arranger(idx, SJ_SONG_ARRANGE) {
			let arrangerId = "SJ_SONG_ARRANGE-" + idx;
			$("#" + arrangerId).html("<input class='form-control' type='text' name='" + arrangerId +"' value='" + SJ_SONG_ARRANGE + "' autofocus >");
			
			item += arrangerId + "/";
		}
		function updt_lyrics(idx, SJ_SONG_LYRICS) {
			let lyricsId = "SJ_SONG_LYRICS-" + idx;
			$("#" + lyricsId).html("<textarea class='form-control' name='" + lyricsId +"' value='" + SJ_SONG_LYRICS + "' autofocus ></textarea>");
			
			item += lyricsId + "/";
		}
		
		// 음원 정보 변경
		function commit() {
			if (item.length == 0) return;
			if (confirm("변경 사항을 저장하시겠습니까?")) {
				demo.value = item;
				myform.submit();	
			}
		}
		
		// 가사 더 보기
		function more(idx) {
			console.log(idx);
			let data = {
				idx : idx
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/lyrics",
				data : data,
				success : (data) => {
					console.log(data);
					modal_i.src = data.sj_SONG_IMG;
					$("#modal_t").html(data.sj_SONG_TITLE);
					$("#modal_a").html(data.sj_SONG_ARTIST);
						let lyrics = data.sj_SONG_LYRICS.replace(/\n/g, "<br>");
					$("#modal_c").html(lyrics);
				}
			});
		}
		
		// 음원 정보(이미지, 제목, 가수) 디비 저장
		function adddb(img, title, artist) {
			if (confirm(title + " - " + artist + "를 데이터베이스에 추가 하시겠습니까?")) {
				let data = {
					img : img,
					title : title,
					artist : artist
				}
				
				$.ajax({
					type : "post",
					url : "${ctp}/admin/addsong",
					data : data,
					success : () => {
						location.reload();
						alert(title + "-" + artist + "가 정상적으로 데이터베이스에 등록 되었습니다.");
					}
				});
			}
		}
		
		// 모두 추가
		function addall() {
			if (confirm("모든 내용을 데이터베이스에 추가 하시겠습니까?"))
			$.ajax({
				type : "post",
				url : "${ctp}/admin/addsongall",
				success : () => {
					location.reload();
				}
			});
		}

		// 음원 재생
		function play1(title, artist) {
			title = title.replace(/[\\\/:*?\"<>|]/g, "");
			artist = artist.replace(/[\\\/:*?\"<>|]/g, "");
			
			let hostIndex = location.href.indexOf(location.host) + location.host.length;
			let contextPath = location.href.substring(hostIndex, location.href.indexOf("/", hostIndex + 1));
	
		    songUrl = contextPath + "/music/" + title + " - " + artist + ".mp3";
		    $.get(songUrl).fail(() => {
		    	alert("파일이 없습니다.");
		    }).done(() => {
			    player.src = songUrl;
			    player.load();
			    player.play();
		    });
		}
		
		//미리 듣기
		function play2() {
			if ($("#fup")[0].files[0] == null) {
				alert("파일을 선택해 주세요.");
				return;
			}
			
			let reader = new FileReader();
		    reader.readAsDataURL($("#fup")[0].files[0]);
		    reader.onload = (e) => {
		    	$("#player").prop("src", e.target.result);
		    	player.play();
		    };
		}
		
		// 파일 업로드
		function fileupload(idx) {
			let ext = $("#fup").val().split(".").pop().toLowerCase();
			if (ext == "") {
				alert("파일을 선택하세요.");
				return;
			}
			if (ext == "mp3") {
				if (confirm("현재 파일을 업로드 하시겠습니까?")) {
					let data = new FormData();
					data.append("idx", idx);
					data.append("file", $("#fup")[0].files[0]);
					
					$.ajax({
						type : "post",
						url : "${ctp}/admin/upload",
						contentType : false,
						processData : false,
						data : data,
						success : () => {
							alert("파일이 업로드 되었습니다.");
							location.reload();
						}
					})
				}
				return;
			}
			alert("mp3 파일만 업로드 가능 합니다.")
		}
		
		// esc 이벤트
		window.onkeydown = (e) => {
			if (e.keyCode == 27) {
				location.reload();
			}
		}
		
		// 검색 내용 없을 때 엔터 막기
		$("#srch").keydown((e) => {
			if (e.keyCode == 13) {
				if ($("#srch").val().trim() == "") {
					e.preventDefault();
				}
			}
		});
		
		// 검색 내용 없을 때 버튼 클릭 비활성
		$("#srch_btn").click((e) => {
			if ($("#srch").val().trim() == "") {
				return;
			}
			
			$("#srchform").submit();
		});
		
		// 차트 업데이트
		function chartUpdate() {
			if (confirm("현재 시각으로 차트를 업테이트 하시겠습니까?")) {
				$('.loader').fadeIn();
				$.ajax({
					type : "post",
					url : "${ctp}/admin/chartupdate",
					success : () => {
						$('.loader').fadeOut();
						location.reload();
					}
				});
			}
		}
		
	</script>
</body>
</html>