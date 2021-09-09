<%@page import="project.MemberDao"%>
<%@page import="project.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String userId = (String)session.getAttribute("session_id");
	MemberDto dto = new MemberDto();
	dto = new MemberDao().getMyInfo(userId);
	
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
									<!-- <li class="current"><a href="index.html">Q&A</a></li> -->
									<li><a href="/develop/view/member/mypage.jsp">나의 게시물</a></li>
									<li><a href="/develop/view/member/update_myinfo.jsp">내 정보 수정</a></li>
									<li><a href="/develop/view/member/update_pwd.jsp">비밀번호 변경</a></li>
									<li><a href="/develop/view/member/delete_account.jsp">회원 탈퇴</a></li>
								</ul>
							</nav>
					</header>
				</div>
				
			<!-- update password -->
			<div class="container">
			<div class="card bg-light">
			<article class="card-body mx-auto">
			<h4 class="card-title mt-3 text-center">내 정보</h4>
			<p class="text-center"><b>회원정보는 개인정보처리방침에 따라 안전하게 보호되며, 회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다.</b></p>
			
			<form action="update_myinfo.jsp" name="infoForm" id="infoForm" method="post" onsubmit="return CheckForm();">
				<div style="margin-top: 3em;">
		    	<table id="mytable" class="table ">
		    		<tbody>
		    			<tr>
		    				<th>ID</th>
		    				<td><%=dto.getId() %></td>
		    			</tr>
		    			<tr>
		    				<th>비밀번호</th>
		    				<td>
		    					<%for(int i=0; i<dto.getPwd().length(); i++){ %>
		    					*
		    					<%} %>
		    				</td>
		    			</tr>
		    			<tr>
		    				<th>사용자 이름</th>
		    				<td><%=dto.getName() %></td>
		    			</tr>
		    			<tr>
		    				<th>사용자 이메일</th>
		    				<td><%=dto.getEmail() %></td>
		    			</tr>
		    			<tr>
		    				<th>사용자 직업 종류</th>
		    				<td><%=dto.getWork() %></td>
		    			</tr>
		    		</tbody>
		    	</table>
		    	<div class="form-group" style="text-align: center;">
		        	<button type="submit" name="confirmBtn" id="confirmBtn" class="btn btn-primary">내 정보 수정</button>
		    	</div>
		    	</div>
			</form>
		</article>
		</div> <!-- card.// -->
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