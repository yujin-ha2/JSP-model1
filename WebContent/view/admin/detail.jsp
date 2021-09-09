<%@page import="java.net.URLEncoder"%>
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
	String files = dto.getFiles();
	String[] files_array = null;
	if(files != null){
		files_array = files.split(",");
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
		<script type="text/javascript">
			function notice_delete() {
				var result = confirm("이 공지사항을 삭제하시겠어요?");
				if(result){
					location.href="delete.jsp?id=<%=dto.getId()%>";
				}
			}
			
			function notice_update() {
				location.href="update.jsp?id=<%=dto.getId()%>";
			}
			
			function notice_reply() {
				location.href="reply.jsp?id=<%=dto.getId()%>";
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
								<li><a href="/develop/view/qna/list.jsp">Q&A</a></li>
								<li><a href="/develop/view/community/list.jsp">Community</a></li>
								<li>
									<a>Tech</a>
									<ul>
										<li><a href="/develop/view/news/list.jsp">IT 뉴스</a></li>
										<li><a href="/develop/view/event/list.jsp">IT 행사</a></li>
									</ul>
								</li>
							</ul>
						</nav>
				</header>
			</div>
			<div class="container">
			<div class="" style="margin-left: 6em; margin-right: 6em;">	
			<h2 style="margin-bottom: 1em;">공지사항 </h2>
				<table class="table " style="text-align: left;">
                       <tbody>
                           <tr>
                               <th>제목</th>
                               <td colspan="2" align="left"><%=dto.getTitle()%></td>
                           </tr>
                           <tr>
                               <th>작성일</th>
                               <td colspan="2"><%=format.format(dto.getRegdate())%></td>
                           </tr>
                           <tr>
                               <th>작성자</th>
                               <td><%=dto.getWriterId() %></td>
                           </tr>
                           <tr>
                           		<th>조회수</th>
                               <td><%=dto.getHit() %></td>
                           </tr>
                           <tr>
                           <%if(files != null){ %>
                               <th>첨부파일</th>
                               <td colspan="2">
                               	<% if(files_array != null){
                               		for(int i=0; i<files_array.length; i++){ 
                               			String fileName = files_array[i];
                               			System.out.println("인코더: " + URLEncoder.encode(fileName,"utf-8"));
                               		%>
                               			<%-- <a href='fileDownloadAction.jsp?directory=upload&file= + <%=URLEncoder.encode(fileName,"utf-8")%>'><%=fileName%></a> &nbsp; --%>
                               			<a href='fileDownloadAction.jsp?directory=upload&file=<%=URLEncoder.encode(fileName,"utf-8")%>'><%=fileName%></a> &nbsp;	
                           <% 		}
                               	}
                           %>
                               </td>
                           <%}else{ %>
                           	   <th>첨부파일</th>
                               <td colspan="2"></td>
                           <%} %>
                           </tr>
                           <tr>
                              <td style="white-space:pre;" colspan="2"><%=dto.getContent() %></td>
                           </tr>
                       </tbody>
				</table>
				<div>
					<br><br>				
				</div>
				<div align="center">
					<!-- 글쓰기 버튼 생성 -->
					<% if(session.getAttribute("session_id") != null && session.getAttribute("session_id").equals("admin")){ %>
					<input type="button" class="btn btn-primary pull-right" value="목록" onclick="window.location='list.jsp'">
					<input type="button" class="btn btn-primary pull-right" value="답글" onclick="notice_reply();">
					<input type="button" class="btn btn-primary pull-right" value="수정" onclick="notice_update();">
					<input type="button" class="btn btn-primary pull-right" value="삭제" onclick="notice_delete();">
					<%}else{ %>
					<input type="button" class="btn btn-primary pull-right" value="목록" onclick="window.location='list.jsp'">
					<%} %>
				</div>
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