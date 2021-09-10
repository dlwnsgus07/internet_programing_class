<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.util.*, java.io.*, java.sql.*" import="myBean.*"%>

<%
try {
	String idx = request.getParameter("idx"); //idx 주소 값을 가져옴
	CRUD crud = new CRUD();

	ResultSet rs = crud.deleteFile(Integer.parseInt(idx)); // 해당 idx 값을 이용해 삭제할 영상의 정보값을 가져옴

	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");
	
	
		String thumbnailName = rs.getString("thumbnail");
		String videoName = rs.getString("video");
		File thumbnailFile = new File(realFolder + "//" + thumbnailName);
		File videoFile = new File(realFolder + "//" + videoName);
		thumbnailFile.delete();
		videoFile.delete();
		//해당 idx에 해당하는 영상의 파일들을 서버에서 지운 후, table에서 해당하는 정보들을삭제한다.
	crud.deleteRecord(Integer.parseInt(idx)); // table삭제 메소드
	rs.close();
	crud.close();
	response.sendRedirect("home.jsp");  // home으로 redirect
	
} catch (SQLException e) {
	out.println("삭제오류: " + e);
}
%>