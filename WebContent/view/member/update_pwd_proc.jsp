<%@page import="project.MemberDao"%>
<%@page import="project.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uId = (String)session.getAttribute("session_id");
	String currentPWD = request.getParameter("currentPWD");
	String newPWD = request.getParameter("newPWD");
	
	MemberDto dto = new MemberDto();
	dto.setId(uId);
	dto.setPwd(currentPWD);
	
	MemberDao dao = new MemberDao();
	int result = dao.updatePwd(uId, newPWD);
	
	if(result==1){
%>
		<script>
			alert("비밀번호가 정상적으로 변경되었습니다.");
			location.href="update_pwd.jsp";
		</script>
<%		
	}else {
%>
		<script>
			alert("비밀번호 변경에 실패했습니다.");
			history.back();
		</script>
<%		
	}
%>