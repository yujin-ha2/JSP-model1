<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="project.BoardDao"%>
<%@page import="project.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userId = (String)session.getAttribute("session_id");

	int currentPage = 1;
	if(request.getParameter("page") != null){  //파라미터명 page 맞나?
		currentPage = Integer.parseInt(request.getParameter("page"));
	}
	
	List<BoardDto> list = new BoardDao().getUserAllBoard(userId, currentPage);
	
	int totalCount = list.size();
	System.out.println(totalCount);
	int startPage = currentPage-(currentPage-1)%5;    //pager의 시작 번호
	int lastPage = 1;
	if(totalCount != 0){
		lastPage = (int)Math.ceil(totalCount/3.0);    //pager의 마지막 번호
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
									<li><a href="/develop/view/member/confirm_myInfo.jsp">내 정보 수정</a></li>
									<li><a href="/develop/view/member/update_pwd.jsp">비밀번호 변경</a></li>
									<li><a href="/develop/view/member/delete_account.jsp">회원 탈퇴</a></li>
								</ul>
							</nav>
					</header>
				</div>
				<!-- mypage -->
				<div class="container">
		        <h4><%=userId %>님이 작성한 게시물</h4>
				<%-- 테이블 --%>
 		        <div class="table-responsive" style="padding-top: 3em;">
					<!-- Table -->
					<table id="mytable" class="table table-bordred table-striped">
						<thead style="background-color: white; color: #979797;">
							<th width="15%">게시판</th>
							<th width="15%">글번호</th>
							<th width="40%">글제목</th>
							<th width="10%">Hit</th>
							<th width="20%">작성날짜</th>
						</thead>
						
						<tbody>
						<% if(list.isEmpty()){  %>
								<tr>
									<td colspan="5" align="center">등록된 글이 없습니다.</td>
								</tr>
						<% }else{ 
							for(int i=0; i<list.size();i++ ){ 
								BoardDto dto = list.get(i);	
								SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); %>
								<tr>
									<td><%=dto.getBoardType() %></td>
									<td>#&nbsp;<%=dto.getIdx()%></td>
									<td><a href="/develop/view/<%=dto.getBoardType() %>/detail.jsp?idx=<%=dto.getIdx()%>"><%=dto.getTitle() %></a></td>
									<td><%=dto.getHit() %></td>
									<td><%=format.format(dto.getRegdate())%></td>
								</tr>
						<% 		} 
							} 
						%>
						</tbody>
					</table>
					<div class="clearfix" style="padding-top: 2em;"></div>
					<nav class="navbar ">
				      <ul class="pagination mx-auto" >
				      	<%if(startPage>5){ %>
						<li class="page-item "><a class="page-link " href="?page=<%=lastPage-9%>">이전</a></li>
						<%}else{ %>
						<li class="page-item "><a class="page-link " onclick="alert('이전 페이지가 없습니다.');">이전</a></li>
						<%} %>
						
						<%for(int i=1; i<=lastPage; i++){
							String active = (i==currentPage)?"active":" ";					
						%> 
						<li class="page-item <%=active%>" style="padding: 0;">
							<a class="page-link" href="?page=<%=i%>"><%=i %></a>
						</li>
						<%} %>
						
						<%if(startPage+4<lastPage){ %>
						<li class="page-item" style="padding: 0;"><a class="page-link" href="?page=<%=startPage+5%>">다음</a></li>
						<%}else{ %>	
						<li class="page-item" style="padding: 0;"><a class="page-link" onclick="alert('다음 페이지가 없습니다.');">다음</a></li>
						<%} %>
					</ul>
				   	</nav>
	            </div>
	        
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