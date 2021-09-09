<%@page import="project.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 	request.setCharacterEncoding("UTF-8");
	String cmd = request.getParameter("cmd");
	String[] susIds = request.getParameterValues("memberStatus");
	System.out.println("cmd:" + cmd);
	
	if(susIds.length != 0){
		int result = new MemberDao().SuspendedOrUsing(susIds, cmd);
		response.sendRedirect("management.jsp");
		
		if(result == 0){
%>
			<script type="text/javascript">
				alert("계정 상태 변경에 실패하였습니다.");
			</script>
<%
		}
	}
%>