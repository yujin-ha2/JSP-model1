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
		<script src="https://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			 function CheckForm() {
				var currentPWD = $("#currentPWD").val();
				var newPWD = $("input[name='newPWD']");
				var newPWD_Confirm = $("input[name='newPWD_Confirm']");
			
				if(currentPWD == ""){
					$("#refCurrentPwd").text("현재 비밀번호를 입력하세요.");
					uName.focus();
					return false;
				}else{
					$("#refCurrentPwd").text("");
					
				}
				
				if(newPWD.val() == ""){
					$("#refNewPwd").text("새 비밀번호를 입력하세요.");
					uName.focus();
					return false;
				}else{
					var regExp = /^[A-Za-z0-9]{6,12}$/;
					if(regExp.test(newPWD.val()) == false){
						//alert("비밀번호는  8 ~ 10자 사이이고 영문, 숫자 조합이여야 합니다.")
						$("#refNewPwd").text("비밀번호는  6 ~ 12자 사이이고 영문, 숫자 조합이여야 합니다.");
						return false;
					}
					else{
						$("#refNewPwd").text("");
					}
				}
				
				if(newPWD_Confirm.val() == ""){
					$("#refNewPwdConfirm").text("확인용 새 비밀번호를 입력하세요.");
					uName.focus();
					return false;
				}else{
					if(newPWD.val() != newPWD_Confirm.val()){
						$("#refNewPwdConfirm").text("두 비밀번호가 일치하지 않습니다 다시 입력해주세요.");
						newPWD_Confirm.val = newPWD_Confirm.val("");
						return false;
					}
				}
				
				document.updatePwdForm.submit();
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
				
			<!-- update password -->
			<div class="container">
			<div class="card bg-light">
			<article class="card-body mx-auto" style="max-width: 400px; width: 30em;">
			<h4 class="card-title mt-3 text-center">비밀번호 변경</h4>
			<p class="text-center"><b>안전한 비밀번호로 내정보를 보호하세요</b></p>
			<span style="font-size: 0.8em;">
				<ul style="text-align: center;">
					<li style="display: inline-block;">다른 아이디/사이트에서 사용한 적 없는 비밀번호</li>
					<li style="display: inline-block;">이전에 사용한 적 없는 비밀번호가 안전합니다.</li>
				</ul>
			</span>
			<form action="update_pwd_proc.jsp" name="updatePwdForm" id="updatePwdForm" method="post">
		   		    
		    <div class="input-group" style="padding-bottom: 0.5em;">
		    	<div class="input-group-prepend">
				    <span class="input-group-text"> <i class="fas fa-key"></i> </span>
				 </div>
		        <input name="currentPWD" id="currentPWD" class="form-control" placeholder="현재 비밀번호" type="password" >
		    </div> <!-- form-group// -->
		    <div style="padding-bottom: 0.7em; font-size: 0.8em; color: red;" id="refCurrentPwd"></div>
		    
		    <div class="input-group" style="padding-bottom: 0.5em;">
		    	<div class="input-group-prepend">
				    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
				</div>
		        <input name="newPWD" id="newPWD" class="form-control" placeholder="새 비밀번호" type="password">
		    </div> <!-- form-group// -->
		    <div style="padding-bottom: 0.7em; font-size: 0.8em; color: red;" id="refNewPwd"></div>
		    
		    <div class="input-group" style="padding-bottom: 0.5em;">
		    	<div class="input-group-prepend">
				    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
				</div>
		        <input name="newPWD_Confirm" id="newPWD_Confirm" class="form-control" placeholder="새 비밀번호 확인" type="password">	
		    </div> <!-- form-group// -->    
		    <div style="padding-bottom: 0.7em; font-size: 0.8em; color: red;" id="refNewPwdConfirm"></div>
		    
		                 			                     
		    <div class="form-group">
		        <button type="button" name="confirmBtn" id="confirmBtn" class="btn btn-primary btn-block" onclick="CheckForm();">확인</button> 
		    </div> <!-- form-group// -->      
		    <div style="padding-bottom: 0.7em; font-size: 0.8em; color: red;" id="refResult"></div>
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