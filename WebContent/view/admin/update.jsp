<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.NoticeDto"%>
<%@page import="project.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int id = Integer.parseInt(request.getParameter("id"));
	NoticeDao dao = new NoticeDao();
	NoticeDto dto = new NoticeDto();
	dto = dao.getNotice(id); 
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	//dto.getFiles()에서 파일이 2개이면 나눠서 변수에 저장하기
	String[] files = dto.getFiles().split(",");
	String file1 = files[0];
	String file2 = files[1];
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
									<li><a href="/develop/view/admin/notice_management.jsp">공지사항 관리</a></li>
								</ul>
							</nav>
					</header>
				</div>
			</div>
			<div class="container">
			<div class="">
			<form method="post" action="update_proc.jsp">
				<table class="table table-hover " style="text-align: center; border: 1px solid #dddddd">
					<tbody>
						<tr>
							<td><input type="text" class="form-control" name="title" maxlength="50" value="<%=dto.getTitle()%>"></td>
						</tr>
						<tr>
							<td><input type="file" class="form-control" name="files1" value="<%=file1%>"></td>
						</tr>
						<tr>
							<td><input type="file" class="form-control" name="files2" value="<%=file2%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" name="content" maxlength="2048" style="height: 350px;"><%=dto.getContent()%></textarea></td>
						</tr>
						<input type="hidden" name="id" value="<%=dto.getId()%>">
					</tbody>
				</table>
				<div align="center">
					<!-- 글쓰기 버튼 생성 -->
					<input type="submit" class="btn btn-primary pull-right" value="수정">
					<input type="button" class="btn btn-primary pull-right" value="취소" onclick="history.back()">
				</div>
			</form>
		</div>
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