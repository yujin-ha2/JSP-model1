<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<% request.setCharacterEncoding("UTF-8");
		   if(request.getAttribute("err") != null){
				String err = (String)request.getAttribute("err");
		%> 
		<script type="text/javascript">
			alert(<%=err%>);
		</script>
		<%		
			}
		%>
		<title>Develop</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="../../assets/css/main.css" />
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script src="https://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function check() {
				var uId = $("#uId").val();
				var uPwd = $("#uPwd").val();
				if(uId == ""){
					alert("아이디를 입력하세요");
					return false;
				}else if(uPwd == ""){
					alert("비밀번호를 입력하세요");
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
				<h4>회원 탈퇴</h4><br>
				<span>
					<p>회원탈퇴에 관하여 아래의 사항을 꼭 확인하시기 바랍니다.</p>
					<ul style="list-style-type: circle; list-style-position: inside;">
						<li>본 커뮤니티에서 회원탈퇴를 하시면 관련 모든 서비스를 받으실 수 없습니다.</li>
						<li>탈퇴 후 같은 아이디로 재가입하실 수 없습니다.</li>
						<li>삭제시 이전에 등록한 게시글들은 삭제되지 않고 회원님의 정보는 모두 삭제됩니다. </li>
					</ul>
					<br>
				</span>
				<div class="card bg-light" style="padding-top: 2em;">
				<article class="card-body mx-auto" style="max-width: 400px;width: 30em;">
					<form action="delete_proc.jsp" name="MemberForm" id="MemberForm" method="post" onsubmit="return check();">
					<div class="form-group input-group">
			    	<div class="input-group-prepend">
					    <span class="input-group-text"> <i class="fas fa-key"></i> </span>
					 </div>
			        <input name="uId" id="uId" class="form-control" placeholder="ID" type="text" >
			    	</div>	
			   		<div class="form-group input-group">
				    	<div class="input-group-prepend">
						    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
						</div>
				        <input name="uPwd" id="uPwd" class="form-control" placeholder="Create password" type="password">
			    	</div>
			    	<div class="form-group">
			        	<button type="submit" class="btn btn-primary btn-block"> 회원 탈퇴하기 </button>
			    	</div>
			    	</form>
		    	</article>
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