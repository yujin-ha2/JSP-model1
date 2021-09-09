<%@page import="project.MemberDao"%>
<%@page import="project.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("uId");
	String email = request.getParameter("uEmail");
	String work = request.getParameter("uWork");
	
	MemberDto dto = new MemberDto();
	dto.setId(id);
	dto.setEmail(email);
	dto.setWork(work);
	
	int result = new MemberDao().updateMyInfo(dto);
	if(result == 1){
		response.sendRedirect("confirm_myInfo.jsp");
	}else{
%>	
		<script type="text/javascript">
		history.back();
		alert( id + "님의 정보 수정에 실패하였습니다.");
		</script>
<%		
	}
%>