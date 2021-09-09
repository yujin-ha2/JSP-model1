<%@page import="project.BoardDao"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="project.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	int result = new BoardDao().DeleteBoard("community", idx);
	
	if(result == 1)
		response.sendRedirect("list.jsp");
	else{
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('게시물 삭제에 실패하였습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
	}
%>