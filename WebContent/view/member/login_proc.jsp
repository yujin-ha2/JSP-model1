<%@page import="project.MemberDao"%>
<%@page import="project.MemberDto"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("inputId");
	String pwd = request.getParameter("inputPwd");
	MemberDto dto = new MemberDto();
	dto.setId(id);
	dto.setPwd(pwd);
	
	int result = new MemberDao().login(dto); 
	
	//3. 화면 네비게이션
	if(result == 1){
		session.setAttribute("session_id", id);
		session.setAttribute("errMsg", "");
		if(id.equals("admin")){
			response.sendRedirect("/develop/view/admin/management.jsp");
		}else{
			response.sendRedirect("/develop/index.jsp");
		}
	}else if(result == 2){
		session.setAttribute("errMsg", "잘못된 비밀번호입니다. 비밀번호를 다시 입력해주세요");
		response.sendRedirect("/develop/view/member/login.jsp");
	}else if(result == 0){
		session.setAttribute("errMsg", "사용자가 존재하지 않습니다. 아이디를 다시 입력해주세요");
		response.sendRedirect("/develop/view/member/login.jsp");
	}else if(result == 3){
		session.setAttribute("errMsg", "정지 상태인 계정입니다. 사용자에게 문의하세요");
		response.sendRedirect("/develop/view/member/login.jsp");
	}
%>

