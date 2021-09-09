<%@page import="project.MemberDto"%>
<%@page import="project.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("uId");
	String pwd = request.getParameter("uPwd");
	String name = request.getParameter("uName");
	String email = request.getParameter("uEmail");
	String work = request.getParameter("uWork");
	
	MemberDto dto = new MemberDto(id, pwd, name, email, work);
	
	MemberDao dao = new MemberDao();
	int result = dao.addMember(dto);
	
	if(result != 0)
		response.sendRedirect("login.jsp");
	else{
		request.setAttribute("err", "회원가입에 실패하였습니다.");
		request.getRequestDispatcher("join.jsp").forward(request, response);
	}


%>

