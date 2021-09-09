<%@page import="java.io.PrintWriter"%>
<%@page import="project.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int id = Integer.parseInt(request.getParameter("id"));
	int result = new NoticeDao().DeleteNotice(id);
	
	if(result == 1)
		response.sendRedirect("list.jsp");
	else{
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('공지사항 삭제에 실패하였습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
	}
%>