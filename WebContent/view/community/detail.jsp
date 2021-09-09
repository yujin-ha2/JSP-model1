<%@page import="java.util.List"%>
<%@page import="project.CommentDao"%>
<%@page import="project.CommentDto"%>
<%@page import="project.BoardDto"%>
<%@page import="project.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.NoticeDto"%>
<%@page import="project.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	BoardDao dao = new BoardDao();
	BoardDto dto = new BoardDto();
	dto = dao.getNotice("community", idx);
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String CurrentUserId = null;
	if(session.getAttribute("session_id") != null){
		CurrentUserId = (String)session.getAttribute("session_id");
	}
	CommentDao cdao = new CommentDao();
	int replyCount = cdao.getReplyCount(idx);
	List<CommentDto> replyList = null;
	if(replyCount > 0){
		replyList = cdao.getReplies(idx);	
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
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> 
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
		<script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://use.fontawesome.com/1210e2d4a3.js"></script>
		<script type="text/javascript">
			$(function(){
			});
			
			function notice_delete() {
				var result = confirm("이 공지사항을 삭제하시겠어요?");
				if(result){
					location.href="delete.jsp?idx=<%=dto.getIdx()%>";
				}
			}
			
			function notice_update() {
				location.href="update.jsp?idx=<%=dto.getIdx()%>";
			}
			
			function getReplyList() {
				$.ajax({
					type: 'post',
					url: 'Reply_proc.jsp?cmd=list',
					data: {boardIdx : $("#boardIdx").val()},
					dataType: "text",
		            success: function(data) {
            			var obj = JSON.parse(data);
            			console.log(obj);
						console.log(obj.content + ", " + obj.writerId);
		            	
					}
				});
			}
			
			function regReply(postIdx, writerId) {
				var data = {
					postIdx : postIdx,
					writerId : writerId,
					content :  $("#message").val()
				};
				
				if(message.length == 0){
					alert("답변을 입력해주세요");
				}else{
					$.ajax({
						type: 'post',
						url: 'Reply_proc.jsp?cmd=save',
						data: JSON.stringify(data),
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						success: function(data){
							if(data == 0)
								alert("답변 등록에 실패했습니다.");
							location.reload();
				        },
				        error: function() {
				        	console.log('error');
						}
					});
				}
			}
			
			function deleteReply(replyIdx) {
				var result = confirm('답변을 정말로 삭제하시겠습니까?'); 
				if(result) { 
					$.ajax({
						type: 'post',
						url: 'Reply_proc.jsp?cmd=delete',
						data: {replyIdx : replyIdx},
						dataType: "text",
					}).done(function(data) {
						if(data = 'success'){
							location.reload();
						}else{
							alert("댓글 삭제에 실패하였습니다.");
						}
					}).fail(function() {

					});
				} 
			}
			
			
			function editReplyForm(idx, writerId, content) {
				console.log("writer:" + writerId );
				console.log("content:" + content);
				content = content.replace(/&&/gi, "\n").replace(/&/gi, " ");
				
				var htmls = "";
				htmls += '<div class="card" id="card' + idx +'>';
				htmls += '<div class="card-body" style="padding:20px;" id="card-body">';
				htmls += '<h6 class="card-title" style="padding-left: 5px;">' + writerId + '</h6>';
				htmls += '<div class="form-group" id="form-group">';
				htmls += '<textarea class="form-control" id="text_message" rows="3">' + content + '</textarea>'; 
				htmls += '</div>';
				htmls += '<div class="btn-toolbar justify-content-between">';
				htmls += '<div class="btn-group">';
				htmls += '<button type="button" style="float: right;" class="btn btn-primary" id="regReplyBtn" onclick="updateReply(' + idx + ');">답변 수정</button>';
				htmls += '<button type="button" style="float: right; margin-left:4px;" class="btn btn-primary" id="regReplyBtn" onclick="location.reload();">취소</button>';
				htmls += '</div>';
				htmls += '</div>';
				htmls += '</div>';
				htmls += '</div>';
				
				$('#card' + idx).replaceWith(htmls);
				setTimeout(() => {
					$("#text_message").focus();
				}, 500);
			}
			
			
			function updateReply(idx) {
				var content = $("textarea#text_message").val();

				var data = {idx : idx, content : content};
				
				if(content.length == 0){
					alert("답변을 입력해주세요");
				}else{
					$.ajax({
						type: 'post',
						url: 'Reply_proc.jsp?cmd=update',
						data: data,
						dataType: "text",
						success: function(data){
							if(data == 0)
								alert("답변 등록에 실패했습니다.");
							location.reload();
				        },
				        error: function() {
				        	console.log('error');
						}
					});
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
			<div class="container">
				<!--- \\\\\\\Post-->
                <div class="card gedf-card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex justify-content-between align-items-center">
                               <!--  <div class="mr-2">
                                    <img class="rounded-circle" width="45" src="https://picsum.photos/50/50" alt="">
                                </div> -->
                                <div class="ml-2">
                                    <div class="h5 m-0"><%=dto.getWriterId() %></div>
                                    <div class="h7 text-muted"><i class="fa fa-clock-o"></i>&nbsp;<%=format.format(dto.getRegdate())%></div>
                                </div>
                            </div>
                            <%if(CurrentUserId!= null && CurrentUserId.equals(dto.getWriterId())){ %>
                             <div>
                                <div class="dropdown">
                                    <button class="btn btn-link dropdown-toggle" type="button" id="gedf-drop1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fa fa-ellipsis-h"></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="gedf-drop1">
                                        <div class="h6 dropdown-header">Configuration</div>
                                        <a class="dropdown-item" href="#" onclick="notice_update();">수정</a>
                                        <a class="dropdown-item" href="#" onclick="notice_delete();">삭제</a>
                                    </div>
                                </div>
                            </div>
                            <%} %>
                        </div>

                    </div>
                    <div class="card-body">
                    	<input type="hidden" value="<%=dto.getIdx() %>" id="boardIdx">
                        <div class="text-muted h7 mb-2">#<%=dto.getIdx() %> </div>
                         <h4 class="card-title" ><%=dto.getTitle()%></h4>
                         <hr>

                        <p class="card-text"><%=dto.getContent() %></p>
                    </div>
                    <div class="card-footer">
                    	<!-- 좋아요 눌렀으면 <i class="fa fa-heart" aria-hidden="true"></i> -->
                        <a href="#" class="card-link"><i class="fa fa-comment"></i> Comment <%=replyCount %></a>
                        <a href="#" class="card-link"><i class="fa fa-eye" aria-hidden="true"></i> Hit <%=dto.getHit() %></a>
                    </div>
                </div>
                <!-- Post /////-->
                
                <%if(session.getAttribute("session_id") != null){ %>
                <div class="card gedf-card">
                    <div class="card-body">
                        <div class="form-group">
                        	<textarea class="form-control" id="message" rows="3"></textarea>
                        </div>
                        <div class="btn-toolbar justify-content-between">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary" id="regReplyBtn" onclick="regReply(<%=dto.getIdx()%>,'<%=CurrentUserId%>');">답변 등록</button>
                        </div>
                        </div>
                    </div>
                </div>
				<%} %>
				<br>
				
				<!-- 답변리스트 -->
				<%if(replyList != null){
					for(CommentDto reply : replyList){ 
					String contents = reply.getContent().replace(" ", "&").replace("\n", "&&");%>
                <div class="card" id="card<%=reply.getIdx()%>">
				  <div class="card-body">
				  	<input type="hidden" id="replyIdx" value="<%=reply.getIdx()%>">
				    <h6 class="card-title"><%=reply.getWriterId()%></h6>
				    <p class="card-text"><%=reply.getContent().replace("\n", "<br>")%></p>
				    <div class="text-muted h7 mb-2"> <i class="fa fa-clock-o"></i><%=reply.getRegdate()%></div>
				    	<%if((CurrentUserId != null) && reply.getWriterId().equals(CurrentUserId)){ %>
				    	<button class="btn btn-primary" style="float: right;" onclick="deleteReply(<%=reply.getIdx()%>)">삭제</button>
				    	<button type="button" class="btn btn-primary" id="regReplyBtn" style="float: right; margin-right: 4px;" onclick="editReplyForm(<%=reply.getIdx()%>,'<%=reply.getWriterId()%>','<%=contents%>');">수정</button>
				    	<%}%>
				    </div>
				 </div>
				<%}} %>
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