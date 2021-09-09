<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("session_id") == null ){
		RequestDispatcher dispatcher = request.getRequestDispatcher("../member/login.jsp");
		 dispatcher.forward(request, response);
	}
%>
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
		<style type="text/css">
		.pagination {
  			 justify-content: center;
		}
		</style>
		<script type="text/javascript">
		function check() {
			var title = $("input[name='title']");
			var content = $("input[name='content']");

			if(title.val().length == 0){
				alert("제목을 입력해주세요");
				return false;
			}
			if(content.text() == ""){
				alert("내용을 입력해주세요");
				return false;
			}		
		}
		</script>
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
						<li><a href="/develop/index.jsp">메인페이지</a></li>
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
									<!-- <li class="current"><a href="index.html">Q&A</a></li> -->
									<li><a href="/develop/view/admin/management.jsp">회원관리</a></li>
									<li><a href="/develop/view/admin/list.jsp">공지사항 관리</a></li>
								</ul>
							</nav>
					</header>
				</div>
			</div>
			<div class="container">
			<form method="post" action="reg_proc.jsp" enctype="multipart/form-data" onsubmit="return check();">
				<table class="table table-hover " style="text-align: center; border: 1px solid #dddddd">
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="title" id="title" maxlength="50"></td>
						</tr>
						<tr>
							<td><input type="file" class="form-control" name="files1" id="files1"></td>
						</tr>
						<tr>
							<td><input type="file" class="form-control" name="files2" id="files2"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="content" id="content" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<div align="center">	
					<!-- 글쓰기 버튼 생성 -->
					<input type="submit" class="btn btn-primary pull-right" value="등록">
					<input type="button" class="btn btn-primary pull-right" value="취소" onclick="history.back();">
				</div>
			</form>
		</div>
		 <!-- Scripts -->
			<script src="/develop/assets/js/jquery.min.js"></script>
			<script src="/develop/assets/js/jquery.dropotron.min.js"></script>
			<script src="/develop/assets/js/browser.min.js"></script>
			<script src="/develop/assets/js/breakpoints.min.js"></script>
			<script src="/develop/assets/js/util.js"></script>
			<script src="/develop/assets/js/main.js"></script>
	</body>
</html>
	