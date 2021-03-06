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
		<script type="text/javascript" src="/develop/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
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
										<li><a href="/develop/view/news/list.jsp">IT ??????</a></li>
										<li><a href="/develop/view/event/list.jsp">IT ??????</a></li>
									</ul>
								</li>
								<li><a href="/develop/view/notice/list.jsp">Notice</a></li>
							</ul>
						</nav>
				</header>
			</div>
			<div class="container">
			<form method="post" action="reg_proc.jsp">
				<table class="table table-hover " style="text-align: center; border: 1px solid #dddddd">
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="??? ??????" name="title" id="title" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" name="content" id="content" rows="10" cols="100" maxlength="2048" style="height:412px; display: none;"></textarea></td>
							
						</tr>
					</tbody>
				</table>
				<div align="center">
					<!-- ????????? ?????? ?????? -->
					<input type="button" class="btn btn-primary pull-right" value="??????" onclick="submitContents(this);">
					<input type="button" class="btn btn-primary pull-right" value="??????">
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
		<script type="text/javascript">
		var oEditors = [];
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "content",
			sSkinURI: "/develop/editor/SmartEditor2Skin.html",	
			htParams : {
				bUseToolbar : true,				// ?????? ?????? ?????? (true:??????/ false:???????????? ??????)
				bUseVerticalResizer : true,		// ????????? ?????? ????????? ?????? ?????? (true:??????/ false:???????????? ??????)
				bUseModeChanger : true,			// ?????? ???(Editor | HTML | TEXT) ?????? ?????? (true:??????/ false:???????????? ??????)
				//bSkipXssFilter : true,		// client-side xss filter ?????? ?????? (true:???????????? ?????? / ??????:??????)
				//aAdditionalFontList : aAdditionalFontSet,		// ?????? ?????? ??????
				fOnBeforeUnload : function(){
					//alert("??????!");
				}
			}, //boolean
			fOnAppLoad : function(){
				//?????? ??????
				//oEditors.getById["ir1"].exec("PASTE_HTML", ["????????? ????????? ?????? ????????? ???????????? text?????????."]);
			},
			fCreator: "createSEditor2"
		});
		
		function submitContents(elClickedObj) {
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// ???????????? ????????? textarea??? ???????????????.
			
			var title = $("#title").val();
			if(title === '<p>&bnsp;</p>' || title === ''){ 
				alert("????????? ???????????????");
				return false;
			}else{
				elClickedObj.form.submit();
			}
		}
		</script>
	</body>
</html>