<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>
	<head>
		<title>Verti</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="./assets/css/main.css" />
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	</head>
	<body class="is-preload homepage">
		<div id="page-wrapper">			
				<div id="login" class="container">
					<ul>
						<li><a href="./view/member/mypage.jsp">MyPage</a></li>
						<li><a href="./view/member/logout_proc.jsp">Logout</a></li>
					</ul>
				</div>
				<div id="header-wrapper">
					<header id="header" class="container">
						<!-- Logo -->
							<div id="logo">
								<h1><a href="index.html">Name</a></h1>
							</div>

						<!-- Nav -->
							<nav id="nav">
								<ul>
									<li><a href="./view/qna/list.jsp">Q&A</a></li>
									<li><a href="./view/community/list.jsp">Community</a></li>
									<li>
										<a href="#">Tech</a>
										<ul>
											<li><a href="./view/news/list.jsp">IT 뉴스</a></li>
											<li><a href="./view/event/list.jsp">IT 행사</a></li>
											<li><a href="./view/study/list.jsp">스터디</a></li>
										</ul>
									</li>
								</ul>
							</nav>
					</header>
				</div>
			</div>
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>
		</body>
</html>