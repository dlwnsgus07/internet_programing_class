<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.util.*, java.io.*, java.sql.*" import="myBean.*"%>

<%
request.setCharacterEncoding("utf-8");
String[] selected_idx = request.getParameterValues("selected_idx"); // 선택상자로 선택한 요소들을 목록을 배열형태로 가져옴
try {

	CRUD crud = new CRUD();
	for (int i = 0; i < selected_idx.length; i++) { // 배열이기때문에 for문으로 반복적으로 각각의 요소에 삭제연산 사용
		String idx = selected_idx[i];
		ResultSet rs = crud.deleteFile(Integer.parseInt(idx));
		ServletContext context = getServletContext();
		String realFolder = context.getRealPath("upload");
		String thumbnailName = rs.getString("thumbnail");
		String videoName = rs.getString("video");
		File thumbnailFile = new File(realFolder + "//" + thumbnailName);
		File videoFile = new File(realFolder + "//" + videoName);
		thumbnailFile.delete();
		videoFile.delete();
		rs.close();
	}

	crud.deleteSelectFile(selected_idx);
	crud.close();
} catch (SQLException e) {

	out.println(e);

}
out.println(selected_idx);
%>

<script>
	alert("선택한 레코드가 삭제되었습니다.");
	location.href = "videoBoard.jsp";
</script>
