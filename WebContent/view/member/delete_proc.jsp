<%@page import="project.MemberDto"%>
<%@page import="project.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String sid = (String)session.getAttribute("session_id");
	String id = request.getParameter("uId");
	String pwd = request.getParameter("uPwd");
	
	if(!sid.equals(id)){
%>
		<script type="text/javascript">
			history.back();				
			alert("회원님의 계정이 아닙니다. 다시 입력해주세요.");
		</script>	
<%		
	}else{
	
		int result = new MemberDao().DeleteMember(id, pwd);
	
		if(result == 0) {
%>
			<script type="text/javascript">
				history.back();				
				alert("회원탈퇴에 실패하였습니다 회원 정보를 다시 입력해주세요.");
			</script>
<%
		}else{
			session.invalidate();
			response.sendRedirect("/develop/index.jsp");
		}
	}


%>

