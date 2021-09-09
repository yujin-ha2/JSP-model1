<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String errMsg = (String)session.getAttribute("errMsg");
	if(errMsg == null)
		errMsg = "";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Verti</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<link rel="stylesheet" href="../../assets/css/main.css" />
		<style type="text/css">
		.panel h2{ color:#444444; font-size:18px; margin:0 0 8px 0;}
		.panel p { color:#777777; font-size:14px; margin-bottom:30px; line-height:24px;}
		.login-form .form-control {
		  background: #f7f7f7 none repeat scroll 0 0;
		  border: 1px solid #d4d4d4;
		  border-radius: 4px;
		  font-size: 14px;
		  height: 50px;
		  line-height: 50px;
		}
		.main-div {
		  background: #ffffff none repeat scroll 0 0;
		  border-radius: 2px;
		  margin: 10px auto 30px;
		  max-width: 38%;
		  padding: 50px 70px 70px 71px;
		}
		
		.login-form .form-group {
		  margin-bottom:10px;
		}
		.login-form{ text-align:center;}
		.forgot a {
		  color: #777777;
		  font-size: 14px;
		  text-decoration: underline;
		}
		.login-form  .btn.btn-primary {
		  background: #f0ad4e none repeat scroll 0 0;
		  border-color: #f0ad4e;
		  color: #ffffff;
		  font-size: 14px;
		  width: 100%;
		  height: 50px;
		  line-height: 50px;
		  padding: 0;
		}
		.forgot {
		  text-align: left; margin-bottom:30px;
		}
		</style>
		<script type="text/javascript">
			function loginCheckForm() {
				var Id = $("input[name='inputId']");
				var Pwd = $("input[name='inputPwd']");
				
				if(Id.val() == ""){
					$("#refId").text("아이디를 입력해주세요.");
					return false;					
				}else{
					$("#refId").text("");
				}
				
				if(Pwd.val() == ""){
					$("#refPwd").text("비밀번호를 입력해주세요.");
					return false;	
				}else{
					$("#refPwd").text("");
				}
			}
		</script>
	</head>
	<body class="is-preload homepage">
		<div id="page-wrapper">			
				<div id="login" class="container">
					<ul>
						<li><a href="#">Login</a></li>
						<li><a href="join.jsp">Join</a></li>
					</ul>
				</div>
				
				<div id="header-wrapper">
					<header id="header" class="container">
						<!-- Logo -->
							<div id="logo">
								<h1><a href="../../index.jsp">Name</a></h1>
							</div>

						<!-- Nav -->
							<nav id="nav">
								<ul>
									<li><a href="index.html">Q&A</a></li>
									<li><a href="index.html">Community</a></li>
									<li>
										<a href="#">Tech</a>
										<ul>
											<li><a href="#">IT News</a></li>
											<li><a href="#">강좌추천</a></li>
											<li><a href="#">IT 행사</a></li>
										</ul>
									</li>
								</ul>
							</nav>
					</header>
				</div>
				
			<div class="main-div">
		    <div class="panel">
		   <h2>Login</h2>
		   <p>아이디와 비밀번호를 입력해주세요</p>
		   </div>
		    <form action="/develop/view/member/login_proc.jsp" method="post" name="Loginform" onsubmit="return loginCheckForm();">
		        <div class="form-group">
		            <input type="text" class="form-control" name="inputId"  placeholder="Id">
		        </div>
		        <div style="padding-bottom: 2px; font-size: 0.8em; color: red;" id="refId"></div>
		        
		        <div class="form-group">
		            <input type="password" class="form-control" name="inputPwd" placeholder="Password">
		        </div>
		        <div style="padding-bottom: 2px; font-size: 0.8em; color: red;" id="refPwd"></div>
		        <div class="forgot">
		        <a href="join.jsp">아직 회원이 아니라면?</a>
		        <div id="errMsg"  style="color: red; padding: 0;">
		        	<%=errMsg %>
		        </div>
				</div>
		        <button type="submit" class="btn btn-primary">Login</button>
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