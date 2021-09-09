<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Develop</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="../../assets/css/main.css" /> 
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
	</head>
	<body class="is-preload homepage">
		<div id="page-wrapper">			
			<div id="login" class="container">
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
							<h1><a href="/develop/index.jsp">Develop</a></h1>
						</div>
	
					<!-- Nav -->
						<nav id="nav">
							<ul>
								<li><a href="/develop/view/qna/list.jsp">Q&A</a></li>
								<li><a href="/develop/view/community/list.jsp">Community</a></li>
								<li>
									<a>Tech</a>
									<ul>
										<li><a href="/develop/view/news/list.jsp">IT 뉴스</a></li>
										<li><a href="/develop/view/event/list.jsp">IT 행사</a></li>
									</ul>
								</li>
								<li><a href="/develop/view/notice/list.jsp">notice</a></li>
							</ul>
						</nav>
				</header>
			</div>
			<div class="container">
				<form action="mail_proc.jsp" method="post">
				<table>
					<tr><td>보내는 사람 메일 : </td><td><input type="text" name="sender"></td></tr>
					<tr><td>받는 사람 메일 : </td><td><input type="text" name="receiver"></td></tr>
					<tr><td>제목 : </td><td><input type="text" name="subject"></td></tr>
					<tr>
						<td>내용 : </td>
						<td><textarea name="content" cols=40 rows=20></textarea></td>
					</tr>
					<tr><td align=center colspan=2><input type="submit" value="보내기"></td></tr>
				</table>
				</form>
			</div>
		</div>
	
</body>
</html>