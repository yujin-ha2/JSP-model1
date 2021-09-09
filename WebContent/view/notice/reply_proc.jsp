<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="project.NoticeDao"%>
<%@page import="project.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//D:\workspace_jsp1\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\FileUploadDownload\ upload\
	String directory = application.getRealPath("/upload/");

	File targetDir = new File(directory);
	if(!targetDir.exists()){
		targetDir.mkdirs();
	}
	
	//업로드 할 수 있는 파일의 최대 사이즈 지정 1G = 1024MB
	int maxSize = 1024*1024*1024;
	
	MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	int parent_id = Integer.parseInt(multipartRequest.getParameter("parent_id"));
	NoticeDao dao = new NoticeDao();
	NoticeDto parent_dto = dao.getNoticeInfo(parent_id);
	
	dao.replyUpPos(parent_dto.getPos());

	NoticeDto dto = new NoticeDto();
	
	dto.setPos(parent_dto.getPos());
	dto.setDepth(parent_dto.getDepth());
	dto.setWriterId(multipartRequest.getParameter("writerId"));
	dto.setTitle(multipartRequest.getParameter("title"));
	dto.setContent(multipartRequest.getParameter("content"));
	
	StringBuilder builder = new StringBuilder();
	Enumeration fileNames = multipartRequest.getFileNames();
	
	while(fileNames.hasMoreElements()){
		String parameter = (String) fileNames.nextElement();
		String fileName  = multipartRequest.getOriginalFileName(parameter);  //서버 경로에 업로드할 파일의 업로드 전 원본 파일명 얻기
		String fileRealName = multipartRequest.getFilesystemName(parameter); //서버 경로에 업로드되어서 올라가 있는 실제 파일명 얻기
		
		if(fileName == null) continue;
		if(!fileName.endsWith(".doc") && !fileName.endsWith(".hwp") &&
				!fileName.endsWith(".pdf") && !fileName.endsWith(".xls")
				&& !fileName.endsWith(".jpg") && !fileName.endsWith(".jpeg") && !fileName.endsWith(".png")){
			File file = new File(directory + fileRealName);
			file.delete();
			out.write("업로드할 수 없는 확장자입니다.");
		}else{
			/* new FileDAO().upload(fileName, fileRealName); */
			builder.append(fileRealName);
			builder.append(",");
			//out.write("파일명: " + fileName + "<br>");
			//out.write("실제 파일명: " + fileRealName +"<br>");
		}
	}
		
	if(builder.length() > 0){
		builder.delete(builder.length()-1, builder.length());
		//System.out.println(builder.toString());
		dto.setFiles(builder.toString());
	}
		
	int result = dao.RegisterReply(dto);
		
	if(result == 1)
		response.sendRedirect("list.jsp");
	else{
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('공지사항 답변 등록에 실패하였습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
	}
		
%>