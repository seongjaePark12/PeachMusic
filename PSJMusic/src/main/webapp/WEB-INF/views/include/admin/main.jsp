<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	google.charts.load('current', {packages: ['corechart', 'bar']});
	google.charts.setOnLoadCallback(drawMultSeries);
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawVisualization);
  // 전체통계
  function drawVisualization() {
   	 var data = google.visualization.arrayToDataTable([
        ['통계', '전체회원'],
        ['노래총재생',${musicvo.SJ_PLAY_CNT}],
        ['메거진조회',${magazinevo.SJ_MAGAZINE_VISIT}],
        ['비디오재생',${videovo.SJ_VIDEO_VISIT}],
        ['총방문자',${visitvo.SJ_ALLCHART_VISIT}],
        ['총가입자',${joinvo.SJ_ALLCHART_JOIN}]
      ]);
   	 var options = {
  	        title : '전체통계',
  	        seriesType: 'bars',
  	        series: {5: {type: 'line'}}
  	      };
  	      var chart = new google.visualization.ComboChart(document.getElementById('chart_main'));
  	      chart.draw(data, options);
  }
	// 상위 노래 재생수 보기
	function drawMultSeries() {
      var data = google.visualization.arrayToDataTable([
        ['노래 제목', '재생수'],
        ['${musicTopvos[0].SJ_SONG_TITLE}',${musicTopvos[0].playCntSum}],
        ['${musicTopvos[1].SJ_SONG_TITLE}',${musicTopvos[1].playCntSum}],
        ['${musicTopvos[2].SJ_SONG_TITLE}',${musicTopvos[2].playCntSum}],
        ['${musicTopvos[3].SJ_SONG_TITLE}',${musicTopvos[3].playCntSum}],
        ['${musicTopvos[4].SJ_SONG_TITLE}',${musicTopvos[4].playCntSum}],
        ['${musicTopvos[5].SJ_SONG_TITLE}',${musicTopvos[5].playCntSum}],
        ['${musicTopvos[6].SJ_SONG_TITLE}',${musicTopvos[6].playCntSum}],
        ['${musicTopvos[7].SJ_SONG_TITLE}',${musicTopvos[7].playCntSum}],
        ['${musicTopvos[8].SJ_SONG_TITLE}',${musicTopvos[8].playCntSum}],
        ['${musicTopvos[9].SJ_SONG_TITLE}',${musicTopvos[9].playCntSum}]
      ]);

      var options = {
        title: '상위 노래 재생수',
        chartArea: {width: '50%'},
        hAxis: {
          title: 'TOP 10',
          minValue: 0
        },
        vAxis: {
          title: '노래제목'
        }
      };

      var chart = new google.visualization.BarChart(document.getElementById('music_chart'));
      chart.draw(data, options);
	}
  	function Music() {
  		document.getElementById("Music").style.color="rgb(216, 148, 148)";
	    document.getElementById("Music").style.backgroundColor="white";
	    document.getElementById("Magazine").style.color="black";
	    document.getElementById("Magazine").style.backgroundColor="rgb(248, 248, 248)";
	    document.getElementById("Video").style.color="black";
	    document.getElementById("Video").style.backgroundColor="rgb(248, 248, 248)";
	    document.getElementById("videoList").style.display="none";
	    document.getElementById("magazineList").style.display="none";
	    document.getElementById("musicList").style.display="block";
  	}
  	function Magazine() {
  		document.getElementById("Magazine2").style.color="rgb(216, 148, 148)";
	    document.getElementById("Magazine2").style.backgroundColor="white";
  		document.getElementById("Music2").style.color="black";
	    document.getElementById("Music2").style.backgroundColor="rgb(248, 248, 248)";
	    document.getElementById("Video2").style.color="black";
	    document.getElementById("Video2").style.backgroundColor="rgb(248, 248, 248)";
	    document.getElementById("videoList").style.display="none";
	    document.getElementById("magazineList").style.display="block";
	    document.getElementById("musicList").style.display="none";
  	}
  	function Video() {
  		document.getElementById("Video3").style.color="rgb(216, 148, 148)";
	    document.getElementById("Video3").style.backgroundColor="white";
  		document.getElementById("Music3").style.color="black";
	    document.getElementById("Music3").style.backgroundColor="rgb(248, 248, 248)";
	    document.getElementById("Magazine3").style.color="black";
	    document.getElementById("Magazine3").style.backgroundColor="rgb(248, 248, 248)";
	    document.getElementById("magazineList").style.display="none";
	    document.getElementById("videoList").style.display="block";
	    document.getElementById("musicList").style.display="none";
  	}
</script>
<style>
#musicList {
	width:100%;
	height:37%;
	padding:30px;
}
#magazineList {
	width:100%;
	height:37%;
	padding:30px;
}
#videoList {
	width:100%;
	height:37%;
	padding:30px;
}
#part4Title {
	font-size: 23px;
	margin:0px auto 10px 10px;
}
#select1 {
    text-align: center;
}
.Music {
    width:33%;
    height: 45px;
    background-color: white;
    color: rgb(216, 148, 148);
    border: 1px solid gainsboro;
}
.Magazine {
    width:33%;
    height: 45px;
    background-color: rgb(248, 248, 248);
    border: 1px solid gainsboro;
}
.Video {
    width:33%;
    height: 45px;
    background-color: rgb(248, 248, 248);
    border: 1px solid gainsboro;
}
</style>
<br/><br/><br/><br/>
<div class="row">
	<div class="col-lg-6">
		<h4 class="text-center">전체통계</h4><br/>
		<div id="chart_main" style="width: 100%; height: 500px;"></div>
	</div>
	<hr/> 
	<div class="col-lg-6">
		 <h4 class="text-center">노래별 재생수</h4><br/>
		 <div id="music_chart" style="width: 100%; height: 500px"></div><br/>
	</div>
</div>
<div id="musicList" class="part">
 	<div id="part4Title">노래 재생 순위</div>
 	<div id="select1">
 		<input type="button" value="Music" id="Music" class="Music" onclick="Music()"> 
 		<input type="button" value="Magazine" id="Magazine" class="Magazine" onclick="Magazine()"> 
    <input type="button" value="Video" id="Video" class="Video" onclick="Video()">
  </div>   
 	<div>
		<table class="table table-hover">
			<tbody>
				<c:forEach var="musicVO" items="${musicTopvos}" varStatus="st">
					<tr>
						<td style="width:10%;">${st.count}</td>
						<td style="width:20%;"><div style="width:16%; height:60px; float:left;"><img src="${musicVO.SJ_SONG_IMG}" style="width:100%; height:100%;"></div></td>
						<td style="width:30%;">${musicVO.SJ_SONG_TITLE}</td>
						<td style="width:30%;">${musicVO.SJ_SONG_ARTIST}</td>
						<td style="width:10%;">${musicVO.playCntSum}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<div id="magazineList" class="part"  style="display:none;">
 	<div id="part4Title">매거진 조회 순위</div>
 	<div id="select1">
 		<input type="button" value="Music" id="Music2" class="Music" onclick="Music()"> 
 		<input type="button" value="Magazine" id="Magazine2" class="Magazine" onclick="Magazine()"> 
    <input type="button" value="Video" id="Video2" class="Video" onclick="Video()">
   </div>   
 	<div>
 		<table class="table table-hover">
 			<tbody>
				<c:forEach var="magazineVO" items="${magazineTopvos}" varStatus="st">
					<tr>
						<td style="width:10%;">${st.count}</td>
						<td style="width:40%;"><div style="width:16%; height:60px; float:left;"><img src="${magazineVO.SJ_MAGAZINE_IMG}" style="width:100%; height:100%;"></div></td>
						<td style="width:40%;">${magazineVO.SJ_MAGAZINE_TITLE}</td>
						<td style="width:10%;">${magazineVO.SJ_MAGAZINE_VISIT}</td>
					</tr>
				</c:forEach>
 			</tbody>
 		</table>
 	</div>
</div>
 <div id="videoList" class="part" style="display:none;">
 <div id="part4Title">뮤직비디오 조회 순위</div>
 <div id="select1">
 		<input type="button" value="Music" id="Music3" class="Music" onclick="Music()"> 
 		<input type="button" value="Magazine" id="Magazine3" class="Magazine" onclick="Magazine()"> 
    <input type="button" value="Video" id="Video3" class="Video" onclick="Video()">
  </div>   
	<div>
		<table class="table table-hover">
			<tbody>
				<c:forEach var="videoVO" items="${videoTopvos}" varStatus="st">
					<tr>
						<td style="width:10%;">${st.count}</td>
						<td style="width:40%;"><div style="width:16%; height:60px; float:left;"><img src="${videoVO.SJ_VIDEO_IMG}" style="width:100%; height:100%;"></div></td>
						<td style="width:40%;">${videoVO.SJ_VIDEO_TITLE}</td>
						<td style="width:10%;">${videoVO.SJ_VIDEO_VISIT}</td>
					</tr>
				</c:forEach>
 		</tbody>
		</table>
	</div>
 </div>
