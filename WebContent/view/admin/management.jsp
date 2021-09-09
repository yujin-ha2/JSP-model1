<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="project.MemberDao"%>
<%@page import="project.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberDao dao = new MemberDao();
	
	String keyfield = "id";
	String keyword = "";
	if(request.getParameter("keyword") != null && !request.getParameter("keyword").equals("")){
		keyfield = (String)request.getParameter("keyfield");
		keyword = (String)request.getParameter("keyword");
	}
	
	int currentPage = 1;
	if(request.getParameter("page") != null){  //파라미터명 page 맞나?
		currentPage = Integer.parseInt(request.getParameter("page"));
	}
	
	List<MemberDto> list = dao.getAllMember(keyfield, keyword, currentPage);

	int totalCount = dao.getAllMemberCount(keyfield, keyword); 
	int startPage = currentPage-(currentPage-1)%5;  //pager의 시작 번호
	int lastPage = (int)Math.ceil(totalCount/3.0);    //pager의 마지막 번호  */
	
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
				<div class="container">
			        <h2>회원관리</h2>
					<div class="row">
					<div class="input-group col-lg-4 ml-auto">
					<form action="management.jsp" name="search">
					<div class="input-group-prepend">
				      <select class="custom-select" name="keyfield" style="width: 6em;">
						  <option value="id">아이디</option>
						  <option value="name">이름</option>
					 </select>
				      <input type="text" class="form-control" name="keyword" style="height: 38px;" value="<%=keyword%>">
				      <button type="submit" class="btn btn-outline-danger">검색</button>
				     </div>
				   	</form>
				    </div><!-- /input-group -->
			         </div>	
			         <div>
					<form action="manage_proc.jsp">
					<%-- 테이블 --%>
	 		        <div class="table-responsive" style="padding-top: 3em;overflow-x:hidden;">
						<!-- Table -->
						<table id="mytable" class="table table-bordred table-striped"> 
							<thead style="background-color: white; color: #979797;">
								<th width="10%">아이디</th>
								<th width="10%">이름</th>
								<th width="10%">이메일</th>
								<th width="10%">가입날짜</th>
								<th width="10%">상태</th>
								<th width="10%">설정</th>
							</thead>
							
							<tbody>
						<% if(list.isEmpty()){  %>
								<tr>
									<td colspan="6" align="center">등록된 회원이 없습니다.</td>
								</tr>
						<% }else{ 
							for(int i=0; i<list.size();i++ ){ 
								MemberDto mdto = list.get(i);	
								SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
								String check="";   %>
								<tr>
									<td><%=mdto.getId() %></td>
									<td><a href="#"><%=mdto.getName() %></a></td><!-- 회원 게시글 페이지  -->
									<td><%=mdto.getEmail() %></td>
									<td><%=format.format(mdto.getRegDate()) %></td>
									<td>
										<%if(mdto.getIsSuspend()==true){ check="checked"; %>								
										계정 정지
										<%}else{ %>
										사용중
										<%} %>
									</td>
									<td>
									<div class="custom-control custom-checkbox">
										<input type="checkbox" class="custom-control-input" id="customCheck<%=i %>" name="memberStatus" value="<%=mdto.getId()%>" <%=check %>>
									  <label class="custom-control-label" for="customCheck<%=i %>">변경</label>
									</div>
									</td>
								</tr>
						<% 		} 
							} 
						%>
							</tbody>
						</table>
						<div class="float-right" style="margin-left: 1em;">
						<input type="hidden" value="">
					   	<input type="submit" value="계정 정지" name="cmd" class="float-left" style="padding: 0; margin-right:1em; width: 7em; height: 3em; font-size: 0.9em;">
					   	<input type="submit" value="계정 정지 해제" name="cmd" class="float-left" style="padding: 0;width: 7em; height: 3em; font-size: 0.9em;">
						</div>
						</div>
						</form>
						<div class="clearfix" style="padding-top: 2em;"></div>
						
						<%-- 페이징 버튼 --%>
					 <nav class="navbar ">
					 <%--mx-auto:중간, ml-auto:우측,  ms-auto:좌측 --%>
				      <ul class="pagination mx-auto" >
				      	<%if(startPage>5){ %>
						<li class="page-item "><a class="page-link " href="?page=<%=lastPage-9%>&keyfield=<%=keyfield%>&keyword=<%=keyword%>">이전</a></li>
						<%}else{ %>
						<li class="page-item "><a class="page-link " onclick="alert('이전 페이지가 없습니다.');">이전</a></li>
						<%} %>
						
						<%for(int i=1; i<=lastPage; i++){
							String active = (i==currentPage)?"active":" ";					
						%> 
						<li class="page-item <%=active%>" style="padding: 0;">
							<a class="page-link" href="?page=<%=i%>&keyfield=<%=keyfield%>&keyword=<%=keyword%>"><%=i %></a>
						</li>
						<%} %>
						
						<%if(startPage+4<lastPage){ %>
						<li class="page-item" style="padding: 0;"><a class="page-link" href="?page=<%=startPage+5%>&keyfield=<%=keyfield%>&keyword=<%=keyword%>">다음</a></li>
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