<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	<!-- 푸터 -->
	<div class="footer">
		<div class="inner-footer">
			<div class="footer-items">
				<h1 class="footerH1">PeachMusic</h1>
				<p>피치뮤직(유)｜대표이사: 박성재<br/>
					청주시 자택｜사업자등록번호: 00-0000-00000 <br/>
					<a href="http://www.ftc.go.kr/info/bizinfo/communicationList.jsp" target="_blank"><font color="black">[사업자정보확인]</font></a><br/>
					통신판매신고번호: 2015-청주-01689<br/>
					고객센터:010-0000-0000｜Email:qkrtjdwo337@naver.com
				</p>
			</div>
			<div class="footer-items">
				<h2 class="footerH2">고객 문의</h2>
				<div class="border"></div>
				<ul class="footerUi">
					<li class="footerLi"><a href="${ctp}/support/notice" class="footerA">공지사항</a></li>
					<li class="footerLi"><a href="${ctp}/support/question" class="footerA">/문의하기</a></li>
				</ul>
			</div>
			<div class="footer-items">
				<h2 class="footerH2">포폴</h2>
				<div class="border"></div>
				<ul class="footerUi">
					<li class="footerLi"><a href="http://49.142.157.251:9090/cjs2108_psj/" class="footerA">쇼핑몰 보러가기</a></li>
				</ul>
			</div>
			<div class="footer-items">
				<h2 class="footerH2">만든이</h2>
				<div class="border"></div>
				<ul class="footerUi">
					<li class="footerLi">박성재</li>
					<li class="footerLi">👇인스타 보러가기</li>
				</ul>
				<div class="social-media">
					<a href="https://www.instagram.com/sj__619/"><i class="fa fa-instagram" aria-hidden="true">sj__619</i></a>
				</div>
			</div>
		</div>
	</div>