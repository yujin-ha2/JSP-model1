<%@page import="project.BoardDao"%>
<%@page import="project.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	BoardDao dao = new BoardDao();
	BoardDto qdto = dao.getMainNotice("qna");
	BoardDto cdto = dao.getMainNotice("community");
	BoardDto edto = dao.getMainNotice("event");

%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Develop</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="./assets/css/main.css" />
	</head>
	<body class="is-preload homepage">
		<div id="page-wrapper">			
				<div id="login" class="container ">
				<% if(session.getAttribute("session_id") == null){ %>
					<ul>
						<li><a href="/develop/view/member/login.jsp">Login</a></li>
						<li><a href="/develop/view/member/join.jsp">Join</a></li>
					</ul>
				<%} else{ %>
					<ul>
						<li><a href="/develop/view/member/mypage.jsp">MyPage</a></li>
						<li><a href="/develop/view/member/logout_proc.jsp">Logout</a></li>
					</ul>
				<%} %>
				</div>
				<div id="header-wrapper">
					<header id="header" class="container">
						<!-- Logo -->
							<div id="logo">
								<h1><a href="#">Develop</a></h1>
							</div>

						<!-- Nav -->
							<nav id="nav">
								<ul>
									<li><a href="/develop/view/qna/list.jsp">Q&A</a></li>
									<li><a href="/develop/view/community/list.jsp">Community</a></li>
									<li>
										<a href="#">Tech</a>
										<ul>
											<li><a href="/develop/view/news/list.jsp">IT 뉴스</a></li>
											<li><a href="/develop/view/event/list.jsp">IT 행사</a></li>
										</ul>
									</li>
									<li><a href="/develop/view/notice/list.jsp">Notice</a></li>
								</ul>
							</nav>
					</header>
				</div>

			<!-- Banner -->
				<div id="banner-wrapper">
					<div id="banner" class="box container">
						<div class="row">
							<div class="col-8 col-12-medium">
								<h2>개발자 커뮤니티 Develop</h2>
								<p>궁금한게 많다면? Develop으로!</p>
							</div>
							<div class="col-4 col-12-medium">
								<ul>
									<li><a href="/develop/view/member/login.jsp" class="button large icon solid fa-arrow-circle-right">Login</a></li>
									<li><a href="/develop/view/notice/list.jsp" class="button alt large icon solid fa-question-circle">More info</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>

			<!-- Features -->
				<div id="features-wrapper">
					<div class="container">
						<div class="row">
							<div class="col-4 col-12-medium">

								<!-- Box -->
									<section class="box feature">
										<a href="#" class="image featured"><img src="images/question.jpg" alt="" /></a>
										<div class="inner" style="height: 270px;">
											<header>
												<h2>오늘의 QnA</h2>
											</header>
											<p><a href="/develop/view/qna/detail.jsp?idx=<%=qdto.getIdx()%>"><%=qdto.getTitle()%></a></p>
										</div>
									</section>

							</div>
							<div class="col-4 col-12-medium">

								<!-- Box -->
									<section class="box feature">
										<a href="#" class="image featured"><img src="images/new.jpg" alt="" /></a>
										<div class="inner" style="height: 270px;">
											<header>
												<h2>오늘의 인기글</h2>
											</header>
											<p><a href="/develop/view/community/detail.jsp?idx=<%=cdto.getIdx()%>"><%=cdto.getTitle()%></a></p>
										</div>
									</section>

							</div>
							<div class="col-4 col-12-medium">

								<!-- Box -->
									<section class="box feature">
										<a href="#" class="image featured"><img src="images/tech.jpg" alt="" /></a>
										<div class="inner" style="height: 270px;">
											<header>
												<h2>다가오는 IT 행사</h2>
											</header>
											<p><a href="/develop/view/event/detail.jsp?idx=<%=edto.getIdx()%>"><%=edto.getTitle()%></a></p>
										</div>
									</section>

							</div>
						</div>
					</div>
				</div>

			<!-- Footer -->
			<%@ include file="bottom.jsp" %>  

			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>