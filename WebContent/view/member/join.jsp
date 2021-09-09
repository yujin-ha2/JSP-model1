<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Develop</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="../../assets/css/main.css" />
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script language="javascript" type="text/javascript" src="CheckForm.js"></script>
		<style type="text/css">
		.divider-text {
		    position: relative;
		    text-align: center;
		    margin-top: 15px;
		    margin-bottom: 15px;
		}
		.divider-text span {
		    padding: 7px;
		    font-size: 12px;
		    position: relative;   
		    z-index: 2;
		}
		.divider-text:after {
		    content: "";
		    position: absolute;
		    width: 100%;
		    border-bottom: 1px solid #ddd;
		    top: 55%;
		    left: 0;
		    z-index: 1;
		}
		
		</style>
	</head>
	<body class="is-preload homepage">
		<div id="page-wrapper">			
				<div id="login" class="container">
					<ul>
						<li><a href="login.jsp">Login</a></li>
						<li><a href="join.jsp">Join</a></li>
					</ul>
				</div>
				
				<div id="header-wrapper">
					<header id="header" class="container">
						<!-- Logo -->
							<div id="logo">
								<h1><a href="../../index.jsp">Develop</a></h1>
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
			<div class="container">
			<div class="card bg-light">
			<article class="card-body mx-auto">
			<h4 class="card-title mt-3 text-center">Create Account</h4><br>
			<form action="join_proc.jsp" name="MemberForm" id="MemberForm" method="post" onsubmit="return CheckForm();">
		    
			    <div class="input-group" style="padding-bottom: 0.5em;">
			    	<div class="input-group-prepend">
					    <span class="input-group-text"> <i class="fas fa-key"></i> </span>
					 </div>
			        <input name="uId" id="uId" class="form-control" placeholder="ID" type="text" >
			        <input type="button" style="width: 30%; font-size: 0.8em;" name="uId_Confirm" id="uId_Confirm" value="아이디확인">
			    </div> <!-- form-group// -->
				<div style="padding-bottom: 2px; font-size: 0.8em; color: red;" id="refID"></div>
			    
			    <div class="input-group" style="padding-bottom: 0.5em;">
			    	<div class="input-group-prepend">
					    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
					</div>
			        <input name="uPwd" id="uPwd" class="form-control" placeholder="Create password" type="password">
			    </div>
			    <div style="padding-bottom: 2px; font-size: 0.8em; color: red;" id="refPwd">비밀번호는  6 ~ 12자 사이이고 영문, 숫자 조합이여야 합니다.</div>
			    
			    <div class="input-group" style="padding-bottom: 0.5em;">
			    	<div class="input-group-prepend">
					    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
					</div>
			        <input name="uPwd_Confirm" id="uPwd_Confirm" class="form-control" placeholder="Repeat password" type="password">
			    </div> 
			     <div style="padding-bottom: 2px; font-size: 0.8em; color: red;" id="refPwdConfirm"></div>
			     
				<div class="input-group" style="padding-bottom: 0.5em;">
					<div class="input-group-prepend">
					    <span class="input-group-text"> <i class="fa fa-user"></i> </span>
					 </div>
			        <input name="uName" id="uName" class="form-control" placeholder="Full name" type="text" >
			    </div> <!-- form-group// -->
			    <div style="padding-bottom: 2px; font-size: 0.8em; color: red;" id="refName"></div>
	
			    <div class="input-group" style="padding-bottom: 0.5em;">
			    	<div class="input-group-prepend">
					    <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
					 </div>
			        <input name="uEmail" id="uEmail" class="form-control" placeholder="Email address" type="email">
			    </div> <!-- form-group// -->
			    <div style="padding-bottom: 2px; font-size: 0.8em; color: red;" id="refEmail"></div>
			                  			                     
			    <div class="input-group" style="padding-bottom: 0.5em;">
			    	<div class="input-group-prepend">
					    <span class="input-group-text"> <i class="fa fa-building"></i> </span>
					</div>
					<select class="form-control" name="uWork" id="uWork" style="height: 50px;">
						<option selected="" value="job_type"> Select job type</option>
						<option value="BackEnd">BackEnd</option>
						<option value="FrontEnd">FrontEnd</option>
						<option value="Mobile">Mobile</option>
						<option value="Data Scientist">Data Scientist</option>
						<option value="BlockChain">BlockChain</option>
					</select>
				</div> <!-- form-group end.// -->
			    <div style="padding-bottom: 1em; font-size: 0.8em; color: red;" id="refType"></div>
			    <div class="form-group">
			        <button type="submit" class="btn btn-primary btn-block"> Create Account  </button>
			    </div> <!-- form-group// -->      
			    <p class="text-center">Have an account? <a href="">Log In</a> </p>                                                                 
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
 	<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="crossorigin="anonymous"></script>
 	<script>
    $('#uId_Confirm').on("click", (e) => {
        const id = $('#uId').val();
        //e.preventDefault()
        console.log('btn click')

		if(id.length<3||id.length>7){
			$('#refID').text('아이디는 3자 이상 7자 이내로 입력해야 합니다.');
			$('#uId').val = "";
		}else{
			$.ajax({
	            type:'post',
	            async:false, //false가 기본값임 - 비동기
	            url:'http://localhost:8083/develop/loginCheck',
	            dataType:'text',
	            data:{id:id},
	            success: function(data, textStatus) {
	                if(data == 'usable') {
	                    $('#refID').text('사용할 수 있는 ID입니다.');      
	                    //$('#uId_Confirm').prop('disabled', true); // 사용할 수 있는 ID면 버튼을 비활성화 시킨다.
	                } else {
	                    $('#refID').text('이미 사용 중인 아이디입니다.');
	                }
	            },
	            error:function (data, textStatus) {
	                console.log('error');
	            }
	        })   
		}
		
		
         //ajax

    })
</script>
 	
</body>
</html>