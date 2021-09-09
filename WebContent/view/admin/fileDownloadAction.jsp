<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//2. fileDownloadList.jsp페이지에서 다운로드 할 파일명 링크를 클릭했을 때 다운로드시킬 파일명 얻기
	String fileName = request.getParameter("file");
	System.out.println(fileName);
	
	//다우로드(업로드)할 파일이 존재하는 실제경로 얻기
	String directory = application.getRealPath(request.getParameter("directory")); // /upload
	
	//3. 물리적으로 존재하는 다운로드(업로드)할 파일에 접근 하기 위해 File객체 생성
	File file = new File(directory + "/" + fileName);
	
	//4. 클라이언트의 웹 브라우저에 응답할 데이터를 파일데이터로 설정 하기 위해 작성
	String mimeType = getServletContext().getMimeType(file.toString());
	
	if(mimeType == null){
		//이진 데이터 형식의 파일 관련 데이터를 웨 브라우저에 전달(응답)하기 위해 octet-stream 유형으로 설정
		response.setContentType("application/octet-stream");
	}
	
	//5. 한글 파일 다운로드 시에 한글 깨짐 현상을 피하기 위해 웹 브라우저별로 다른 대응이 필요하다
	//   브라우저 별로 분류하기 위해서 다음과 같은 로직이 필요로 한다.
	
	//웹 브라우저 종류 별로 다운로드시킬 파일명에 대한 인코딩 설정 후 다시 저장
	String downloadName = null;
	
	//사용자가 어떤 웹 브라우저를 사용해서 다운로드 요청하는지 웹 브라우저 정보 얻기
	String header = request.getHeader("User-Agent");
	
	//인터넷 익스플로러(MSIE, Trident)를 사용하는 사용자라면?
	if(header.contains("MSIE") || header.contains("Trident")){
		//다운로드시킬 파일명을 UTF-8로 변경하여 웹 브라우저로 전달 하게 되면 파일명이 깨지지 않고 웹브라우저로 전달된다.
		//웹 브라우저가 IE일 경우 다운로드 될 파일 이름에 공백이 '+'로 인코딩된 것을 다시 공백 "%20"으로 바꿔준다.
		downloadName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
	
	}else{ //인터넷 익스플로러(MSIE, Trident 11버전 이상)을 제외한 다른 웹 브라우저를 사용하는 사용자라면?
		//IE가 아닐 경우 다운로드 될 파일명 설정
		//fileName.getBytes("UTF-8")  
		//-> 문자열 이름을 전세계 거의 모든 문자를 포함한 체계(UTF-8)의 데이터로 사용하기 위해 문자열들을 바이트 크기의 데이터들로 모두 변환해 새로운 byte[]배열에  저장해 이 배열 자체를 반환한다.
		
		//new String(fileName.getBytes("UTF-8"), "8859_1")
		// -> 다운로드할 파일명 문자열은 바이트 데이터들로 변환되어 byte[]배열에 저장되어 있기 때문에 byte[]에 저장된 파일명을 다시 웹브라우저로 전달하여 다운로드 시킬 때
		//    웹 브라우저가 인식할 수 있도록 다시 8859_1체계로 변형 후 다운로드 할 파일명을 변수에 저장 시킨다.
		downloadName = new String(fileName.getBytes("UTF-8"), "8859_1");
		//참고
		//컴퓨터는 문자를 사람이 보듯이 저장하는게 아니라 이진수로 변환 후 비트단위로 저장한다.
		//이것을 사람이 읽을 수 있도록 문자로 표현 및 저장하는 규칙을 케릭터 셋이라고 한다. 한국인끼리 쓰는 시스템은 EUC-kR 캐릭터 셋으로 문자를 사용하면 되지만 
		//외국인에게도 서비스 하려면 더 밚은 문자를 지원해야 해서 UTF-8 캐릭터셋을 사용한다.
	}
	
	//6. 웹 브라우저로 응답할 데이터(다운로드 시킬 파일)을 설정하는 response 객체의 헤더 영역에 
	//	 1. 다운로드 시킬 파일명 설정
	//	 2. content-disposition을 명시하여 브라우저로 전송된 파일을 디스크에 직접 다운로드 받을것인지 혹은 브라우저로 바로 보여줄 것인지 설정할 수 있다.
	//      content-disposition : inline -> 브라우저에서 응답을 받으면 브라우저에세 바로 보여준다.
	//      content-disposition : attachment -> 다운로드 창이 뜨게 된다.
	response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
	response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + "\";");
	
	//7. 다운로드할 파일에서 데이터를 읽어와 버퍼공간에 저장하고 버퍼공간에 저장된 데이터를 브라우저로 출력할 슽츠림 통로 객체들 생성
	//다운로드할 파일을 바이트 단위로 읽어들일 new FileInputStream(file) 버퍼공간 스트림 통로 생성
	FileInputStream fileInputStream = new FileInputStream(file);
	
	//읽어 들인 다운로드할 파일의 데이터들을 new FileInputStream(file) 버퍼 공간에서 꺼내와서 바이트 단위로 웹 브라우저에 출력할 출력 버퍼공간 생성
	ServletOutputStream servletOutputStream = response.getOutputStream();
	
	
	/* 
		일반적으로 화면은 JSP에 구현하고 기능은 JAVA파일을 구현한다. 하지만 종종 JSP에 자바코드를 입력하여 구현하는 경우가 있다.
		만약 이때 다운로드 로직을 구현한다면 주의할 점
		
		out.clear();
		out = pageContent.pushBody();
		
		클라이언트의 웹 브라우저에 write전에 로직을 추가 해줘야 하는데 만약 위와 같은 로직이 추가 되지 않으면 다운로드에 영향을 미칠 수 있다.
		그리고 Servlet.service() for servlet JSP threw exception java.lang.IllegalStateException: getOutputStream() has already been called for those response
		위와 같은 에러메시지를 받게된다.
		
		이유는 jsp페이지에서 다른 jsp페이지를 호출해서 다운로드 로직을 실행하는 경우
		이미 스트림 통로가 열려 있는 상태이다. 따라서 추가적으로 스트림을 열려고 하면 위와 같은 형태의 에러 메세지를 생성한다. 
		그렇다면 사용하기 전에 스트림을 한번 비우고 깔끔하게 웹 브라우저로 전송해야한다.
	*/
	out.clear(); //스트림 통로에 데이터를 비움
	out = pageContext.pushBody(); //jsp페이지에 대한 정보를 저장하는 기능을 한다.(여기서 말하는 정보는 다운로드할 파일의 정보)
	
	//8. 파일 입출력 부분
	//다운로드할 파일에서 데이터를 1048576Byte (= 1MB) 단위로 읽어와 저장할 byte 배열 생성
	byte[] b = new byte[1048576];
	
	while(true){
		//다운로드할 파일의 내용을 약 1MB단위로 읽어와 변수에 저장
		int count = fileInputStream.read(b);
		
		//다운로드할 파일에서 더이상 읽어들일 데이터가 없으면(-1인 경우)
		if(count == -1) break;
		
		//다운로드할 파일에서 읽어들인 데이터가 있으면 한번씩 읽어들인 1MB 전체를 출력스트림 통로를 통해 웹 브라우저로 응답
		servletOutputStream.write(b, 0, count);
	}
	
	//출력 스트림 통로에 다운로드 시킬 파일에서 읽어들인 데이터가 남아 있다면 완전히 웹 브라우저로 내보내기
	servletOutputStream.flush();
	
	//자원해제
	servletOutputStream.close();
	fileInputStream.close();
%>