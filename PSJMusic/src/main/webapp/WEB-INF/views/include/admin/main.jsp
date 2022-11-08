<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        ['${musicTopvos[0].SJ_SONG_TITLE}'/'${musicTopvos[0].SJ_SONG_ARTIST}',${musicTopvos[0].playCntSum}],
        ['${musicTopvos[1].SJ_SONG_TITLE}'/'${musicTopvos[1].SJ_SONG_ARTIST}',${musicTopvos[1].playCntSum}],
        ['${musicTopvos[2].SJ_SONG_TITLE}'/'${musicTopvos[2].SJ_SONG_ARTIST}',${musicTopvos[2].playCntSum}],
        ['${musicTopvos[3].SJ_SONG_TITLE}'/'${musicTopvos[3].SJ_SONG_ARTIST}',${musicTopvos[3].playCntSum}],
        ['${musicTopvos[4].SJ_SONG_TITLE}'/'${musicTopvos[4].SJ_SONG_ARTIST}',${musicTopvos[4].playCntSum}],
        ['${musicTopvos[5].SJ_SONG_TITLE}'/'${musicTopvos[5].SJ_SONG_ARTIST}',${musicTopvos[5].playCntSum}],
        ['${musicTopvos[6].SJ_SONG_TITLE}'/'${musicTopvos[6].SJ_SONG_ARTIST}',${musicTopvos[6].playCntSum}],
        ['${musicTopvos[7].SJ_SONG_TITLE}'/'${musicTopvos[7].SJ_SONG_ARTIST}',${musicTopvos[7].playCntSum}],
        ['${musicTopvos[8].SJ_SONG_TITLE}'/'${musicTopvos[8].SJ_SONG_ARTIST}',${musicTopvos[8].playCntSum}],
        ['${musicTopvos[9].SJ_SONG_TITLE}'/'${musicTopvos[9].SJ_SONG_ARTIST}',${musicTopvos[9].playCntSum}]
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
</script>
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