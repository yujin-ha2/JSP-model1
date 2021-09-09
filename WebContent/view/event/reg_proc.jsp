<%@page import="java.io.PrintWriter"%>
<%@page import="project.BoardDto"%>
<%@page import="project.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	
	String userID = null;
	if(session.getAttribute("session_id") != null){	
		userID = (String)session.getAttribute("session_id");
	}
	String title = (String)request.getParameter("title");
	String content = (String)request.getParameter("content");
	
 	BoardDao dao = new BoardDao();
	BoardDto dto = new BoardDto();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setWriterId(userID);
	dto.setBoardType("event");
	int result = dao.RegisterBoard(dto);
	
	if(result == 1)
		response.sendRedirect("list.jsp");
	else{
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('게시물 등록에 실패하였습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
	}  
%>
