<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.util.*, java.io.*, java.sql.*" import="myBean.*"%>
<%

request.setCharacterEncoding("utf-8");
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload"); //업로드 폴더의 진짜 경로를 가져옴
int maxSize = 5 * 1024 * 1024; // 파일 사이즈를 5메가바이트 이하로 지정

try {
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, "utf-8", new DefaultFileRenamePolicy());
	CRUD crud = new CRUD();
	String idx = request.getParameter("idx");
	String title = multi.getParameter("title");
	String thumbnail = multi.getFilesystemName("thumbnail");
	String video = multi.getFilesystemName("video");
	String info = multi.getParameter("info");
	String author = multi.getParameter("author");
	//form을 통해 받은 정보들을 변수들로 저장
	MovieInfo movie = new MovieInfo(); // 해당변수들로 만들 movie 객체들을 만듬
	
	movie.setIdx(Integer.parseInt(idx));
	movie.setTitle(title);
	movie.setAuthor(author);
	movie.setInfo(info);
	movie.setThumbnail(thumbnail);
	movie.setVideo(video);
	ResultSet rs = crud.deleteFile(Integer.parseInt(idx));
	String thumbnailName = rs.getString("thumbnail");
	String videoName = rs.getString("video");
	//여기까지가 정보를 토대로 가져오는 부분
	
	if(thumbnail==null&&video==null){// 썸네일, 비디오 둘다 수정안했을떄
		crud.modifyRecord_NO_ITEM(movie);
	}
	else if(thumbnail == null){ // 비디오 파일은 수정안했을때	
		
		File videoFile = new File(realFolder + "//" + videoName);
		videoFile.delete();
		crud.modifyRecord_NO_THUMBNAIL(movie);
	}
	else if(video==null){//비디오 파일은 수정안했을때
		File thumbnailFile = new File(realFolder + "//" + thumbnailName);
		thumbnailFile.delete();
		crud.modifyRecord_NO_VIDEO(movie);
	}
	else{ //비디오와 썸네일 둘다 수정했을때
		File thumbnailFile = new File(realFolder + "//" + thumbnailName);
		File videoFile = new File(realFolder + "//" + videoName);
		thumbnailFile.delete();
		videoFile.delete();
		crud.modifyRecord(movie);
	}
	
	crud.close();
	rs.close();
	response.sendRedirect("video.jsp?idx=" + idx); // 수정한 영상으로 다시 이동
} catch (Exception e) {
	out.println(realFolder);
	out.println("파일 전송 오류 : " + e);
}
%>