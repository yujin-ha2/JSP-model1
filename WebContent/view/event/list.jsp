<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="project.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	BoardDao dao = new BoardDao();
	
	String keyfield = "title";
	String keyword = "";
	if(request.getParameter("keyword") != null && !request.getParameter("keyword").equals("")){
		keyfield = (String)request.getParameter("keyfield");
		keyword = (String)request.getParameter("keyword");
	}
	
	int currentPage = 1;
	if(request.getParameter("page") != null){  //파라미터명 page 맞나?
		currentPage = Integer.parseInt(request.getParameter("page"));
	}
	
	List<BoardDto> list = dao.getNoticeAll("event", keyfield, keyword, currentPage);	
	
	int totalCount = dao.getNoticeCount("event", keyfield, keyword);
	int startPage = currentPage-(currentPage-1)%5;  //pager의 시작 번호
	int lastPage = (int)Math.ceil(totalCount/5.0);    //pager의 마지막 번호 

%>
<!DOCTYPE html>
<html>
	<head>
		<title>Develop</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="../../assets/css/main.css" /> 
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> 
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
		<script type="text/javascript">
			function check() {
				if(document.search.keyword.value == ""){
					alert("검색어를 입력하세요");
					document.search.keyword.focus();
					return;
				}
				document.search.submit();
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
			<%-- 마이페이지 시작 --%>
			<div class="container">
		        <h2>IT Event</h2>
				<div class="row">
				<div class="input-group col-lg-4 ml-auto">
				<form action="list.jsp" name="search">
				<div class="input-group-prepend">
			      <select class="custom-select" name="keyfield" style="width: 6em;">
					  <option value="title">제목</option>
					  <option value="writer_id">작성자</option>
				 </select>
			      <input type="text" class="form-control" name="keyword" style="height: 38px;">
			      <button type="submit" class="btn btn-default" onclick="check();">검색</button>
			     </div>
			   	</form>
			    </div><!-- /input-group -->
		         </div>	
				
				<%-- 테이블 --%>
 		        <div class="table-responsive" style="padding-top: 3em;">
					<!-- Table -->
					<table id="mytable" class="table table-bordred table-striped">
						<thead style="background-color: white; color: #979797;">
							<th width="10%">번호</th>
							<th width="50%">글제목</th>
							<th width="15%">작성자</th>
							<th width="10%">조회수</th>
							<th width="15%">작성날짜</th>
						</thead>
						
						<tbody>
					<% if(list.isEmpty()){  %>
							<tr>
								<td colspan="6" align="center">등록된 글이 없습니다.</td>
							</tr>
					<% }else{ 
						for(int i=0; i<list.size();i++ ){ 
							BoardDto bdto = list.get(i);	
							SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); %>
							<tr>
								<td><%=bdto.getIdx() %></td>
								<td><a href="detail.jsp?idx=<%=bdto.getIdx()%>"><%=bdto.getTitle() %></a></td>
								<td><%=bdto.getWriterId() %></td>
								<td><%=bdto.getHit() %></td>
								<td><%=format.format(bdto.getRegdate())%></td>
							</tr>
					<% 		} 
						} 
					%>
						</tbody>
					</table>
					<div class="float-right">
				   	<input type="button" value="글쓰기" class="float-left" style="width: 6em; height: 3em; text-align: center; font-size: 0.9em;" onclick="window.location='reg.jsp'">
					</div>
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