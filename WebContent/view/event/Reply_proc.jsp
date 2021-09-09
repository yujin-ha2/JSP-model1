<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="project.BoardDto"%>
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
		dto.setBoardType("event");
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
		//JsonObject 사용법1
 		JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
		int idx = data.get("idx").getAsInt();
		System.out.println("idx:" + idx); //20 
		
		
/* 		BufferedReader br = request.getReader();
		String rdata = br.readLine();
		System.out.println("rdata:" + rdata); //rdata:{"idx":"20"}
		Gson gson = new Gson();
		
		BoardDto dto = gson.fromJson(rdata, BoardDto.class);
		System.out.println("dto:" + dto.getIdx()); //dto:20
		
		//이것도 되는 방법
		JsonElement jsonElement = new JsonParser().parse(rdata);
		JsonObject jsonObject = jsonElement.getAsJsonObject();
		System.out.println("parser이용 : " + jsonObject.get("idx")); //parser이용 : "20" */
		
		/* json으로 보낼 땐 이렇게 못받음 이건 text로 보낼 때 가능한 방법
		String id = request.getParameter("idx");
		System.out.println("getparameter:" + id); */
		
		//리스트 데이터를 json으로 받아왔을 때 사용하는 법 (맞나?)
		//Map<String, Object> map = new HashMap<>();
		//List<Map<String,Object>> dataList =  gson.fromJson(String.valueOf(map), new TypeToken<List<Map<String,Object>>>() {}.getType());	
		
		
		/* int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		List<CommentDto> list = new ArrayList<CommentDto>();
		list = dao.getReplies(boardIdx);
		
		//만약 내가 리스트 말고도 보낼게 많다면 JsonObject나 Map을 사용
		  JsonObject json = new JsonObject();		  
		  //값 하나씩 넣어주기
		  String name ="관리자";
		  String role ="user";
		  json.addProperty("name", name);
		  json.addProperty("role",role);
		  
		  Map<String, Object> MemberList = new HashMap<String, Object>();
		  MemberList.put("list", list);
		  MemberList.put("resultCd", Constants.RESULT_LOGIN_OK_CD);

		 
		
		String replyGson = new Gson().toJson(list);
		//=> new Gson().toJson(userMap, response.getWriter()); 이렇게 간단하게도 사용가능
		out.write(replyGson); */
		
		List<CommentDto> list = new ArrayList<CommentDto>();
		list = dao.getReplies(idx);
		new Gson().toJson(list, response.getWriter());
		
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