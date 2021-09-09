<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="project.CommentDao"%>
<%@page import="project.CommentDto"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("application/json;charset=utf-8");
	String cmd = request.getParameter("cmd");
	CommentDao dao = new CommentDao();
	
	if(cmd.equals("save")){
		BufferedReader br = request.getReader();
		String replyData = br.readLine();
		Gson gson = new Gson();
		CommentDto dto = gson.fromJson(replyData, CommentDto.class);
		dto.setBoardType("qna");
		int result = dao.RegReply(dto);
		String val = new Gson().toJson(result);
		if(result == 1){
			response.getWriter().write(val);
		}
	}else if(cmd.equals("delete")){
		int idx = Integer.parseInt(request.getParameter("replyIdx"));
		int result = dao.DeleteReply(idx);
		if(result == 1){
			out.print("success");
		}else{
			out.print("fail");
		}
	}else if(cmd.equals("list")){
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		List<CommentDto> list = new ArrayList<CommentDto>();
		list = dao.getReplies(boardIdx);
		String replyGson = new Gson().toJson(list);
		out.write(replyGson);
	}else if(cmd.equals("update")){
		int idx = Integer.parseInt(request.getParameter("idx"));
		String content = request.getParameter("content");
 		int result = dao.UpdateReply(idx, content);
		String val = new Gson().toJson(result);
		if(result == 1){
			response.getWriter().write(val);
		}
 	}
	
%>