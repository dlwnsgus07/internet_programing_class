<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
     import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" 
     import="java.util.*, java.io.*"
     import="myBean.*"
    %>
<%
request.setCharacterEncoding("utf-8");
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload"); //upload 폴더의 경로를 가져옴
int maxSize = 5*1024*1024; // 파일 크기 제한
int idx;
	try{
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, "utf-8", new DefaultFileRenamePolicy());
	
	String title = multi.getParameter("title");
	String thumbnail = multi.getFilesystemName("thumbnail");
	String video = multi.getFilesystemName("video");
	String info = multi.getParameter("info");
	String author = multi.getParameter("author");
	MovieInfo movie = new MovieInfo();
	//사용자가 form을 통해 입력한 정보를 토대로 MovieInfo 객체를 만듬
	
	movie.setTitle(title);
	movie.setAuthor(author);
	movie.setInfo(info);
	movie.setThumbnail(thumbnail);
	movie.setVideo(video);
	CRUD crud = new CRUD();
	idx = crud.insertRecord(movie);
	crud.close();
	response.sendRedirect("video.jsp?idx="+idx);
	// movieInfo 객체 정보를 토대로 table에 정보를 등록 한 후 등록된 영상으로 이동
	}
	catch(Exception e){
		out.println(realFolder);
		out.println("파일 전송 오류 : " + e);
	}
%>