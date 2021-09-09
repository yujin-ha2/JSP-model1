<%@page import="project.BoardDao"%>
<%@page import="project.BoardDto"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="project.NoticeDao"%>
<%@page import="project.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	BoardDto dto = new BoardDto();
	dto.setIdx(idx);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setBoardType("community");
	
	int result = new BoardDao().UpdateNotice(dto);
	
	if(result == 1)
		response.sendRedirect("detail.jsp?idx="+idx);
	else{
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('게시물 수정에 실패하였습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
	}
		
%>