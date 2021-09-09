function CheckForm() {
	var uID = $("input[name='uId']");
	var uPwd = $("input[name='uPwd']");
	var uPwd_Confirm = $("input[name='uPwd_Confirm']"); 
	var uName = $("input[name='uName']");
	var uEmail = $("input[name='uEmail']");
	var uWork = $("input[name='uWork']");    

	if(uID.val() == ""){
		$("div[id='refID']").text("아이디를 입력하세요.");
		uID.focus();
		return false;
	}else{
		$("#refID").text("");
	}
	
	if(uPwd.val().length == 0){
		//alert("비밀번호를 입력하세요.");
		$("div[id='refPwd']").text("비밀번호를 입력하세요.");
		uPwd.focus();
		return false;
	}else{
		var regExp = /^[A-Za-z0-9]{6,12}$/;
		if(regExp.test(uPwd.val()) == false){
			//alert("비밀번호는  8 ~ 10자 사이이고 영문, 숫자 조합이여야 합니다.")
			$("#refPwd").text("비밀번호는  6 ~ 12자 사이이고 영문, 숫자 조합이여야 합니다.");
			return false;
		}else{
			$("#refPwd").text("");
		}
	}
	
	if(uPwd_Confirm.val() == ""){
		//alert("비밀번호 확인을 입력하세요.");
		$("#refPwdConfirm").text("비밀번호 확인을 입력하세요.");
		uPwd_Confirm.focus();
		return false;
	}
	
	if(uPwd.val() != uPwd_Confirm.val()){
		//alert("두 비밀번호가 일치하지 않습니다.");
		$("#refPwdConfirm").text("두 비밀번호가 일치하지 않습니다 다시 입력해주세요.");
		uPwd_Confirm.val = uPwd_Confirm.val("");
		return false;
	}else{
		$("#refPwdConfirm").text("");
	}
	
	if(uName.val() == ""){
		/*alert("이름을 입력하세요.");*/
		$("#refName").text("이름을 입력하세요.");
		uName.focus();
		return false;
	}else if(uName.val().length<2 || uName.val().length>5){
		//alert("이름은 2~5자 이내로 작성하시오.");
		$("#refName").text("이름은 2-5자 이내로 작성하세요.");
		uName.select();
		return false;
	}else{
		$("#refName").text("");
		
	}
	
	if(uEmail.val() == ""){
		//alert("이메일을 입력하세요.");
		$("#refEmail").text("이메일을 입력하세요.");
		uEmail.focus();
		return false;
	}else{
		$("#refEmail").text("");
	}
	
	if($("#uWork option:selected").val() == "job_type"){
		//alert("직종을 선택하세요.");
		$("#refType").text("직종을 선택하세요.");
		return false;
	}else{
		$("#refType").text("");
	}
	
}

/*function CheckID() {
	window.open("CheckId.html", "아이디 유효성 확인", "width=500, height=300")
}*/
