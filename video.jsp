<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.util.*, java.io.*, java.sql.*" import="myBean.*"%>
<%
String idx = request.getParameter("idx"); //사용자가 선택한 영상의 idx를 가져옴
CRUD crud = new CRUD();
MovieInfo movie = crud.getRecord(Integer.parseInt(idx)); // 비디오와 비디오에 관한 정보를 가오기 위해 getRecord사용
ResultSet rs = crud.getAllReply(Integer.parseInt(idx)); // 해당 비디오에 등록된 답글들을 가져오는 getAllReply를 사용
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="./resource/css/bootstrap.css">
<link rel="stylesheet" href="./resource/css/navbar.css">
<link rel="stylesheet" href="./resource/css/sidebar.css">
<link rel="stylesheet" href="./resource/css/video.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<script>
	function modify_Video(){ // 사용자가 수정버튼을 눌럿을때 알람이 뜨게 되고 확인 버튼을 눌렀을때 수정하는 페이지로 이동
	if(confirm("수정 하시겠습니까?") == true)
	location.href = "modify_video.jsp?idx=<%=idx%>";
	}
	function delete_Video(){ // 사용자가 삭제 버튼을 눌렀을때 삭제할 것인지 알람을 띄우고 확인 버튼을 눌렀을때 삭제시킴
		if(confirm("삭제 하시겠습니까?") == true)
		location.href = "delete_video_do.jsp?idx=<%=idx%>";
	}
</script>

</head>
<body>
	<nav class="navbar navbar-dark fixed-top">
		<div class="logo" onClick="location.href='home.jsp'">
			<i class="fa-2x fa-fw fas fa-video" style="color: white"></i>
		</div>
		<div class="wrap">
			<div class="search">
				<input type="text" class="searchTerm" placeholder="찾으시는 영상을 검색하세요">
				<button type="submit" class="searchButton">
					<i class="fa fa-search"></i>
				</button>
			</div>
		</div>
		<div class="login_content">
			<i class="fa fa-history recent_history" style="color: white;"></i>
			<form action="" method="POST" class="login_form">
				<label for="user" class="label">ID</label> <input id="user"
					type="text" class="input"> <label for="pass" class="label">PW</label>
				<input id="pass" type="password" class="input">
				<button type="submit" class="btn login">Login</button>
			</form>
		</div>
	</nav>

	<nav class="sidebar rounded">
		<ul class="sidebar_list">
			<li class="modify"><a> <i
					class="fa-2x fa-fw fas fa-edit sidebar_icon"
					onClick="modify_Video()"></i>
			</a></li>
			<li class="delete"><a> <i
					class="fa-2x fa-fw fas fa-trash-alt sidebar_icon"
					onClick="delete_Video()"></i>
			</a></li>
		</ul>
	</nav>
	<div class="container-sm video_player pt-5">
		<video controls autoplay class="player"
			src="<%="./upload/" + movie.getVideo()%>"> <!-- 등록된 비디오파일의 경로를 연결시켜주오 비디오를 띄운 후 자동으로 재생되도록 함 -->
		</video>
		<div class="explain">
			<div class="title_info">
				<div class="title"><%=movie.getTitle()%></div> <!-- 사용자가 입력한 제목을 출력 -->
				<div class="info"><%=movie.getInfo()%></div> <!-- 사용자가 입력한 영상 내용을 출력--> 
			</div>
			<div class="author_date">
				<div class="author"><%=movie.getAuthor()%></div> <!-- 작성자의 이름을 가져옴 -->
				<div class="date"><%=movie.getDate()%></div> <!--  DB에 해당 영상의 정보가 자동으로 날짜 및 시간을 업데이트하게 되어있고 이를 가져옴 -->
			</div>
		</div>

		<div class="video_reply row">
			<form action="reply_do.jsp?idx=<%=idx%>" method="post">
				<label for="reply" class="video_label">답글</label> 
				<input type="text" name="reply"
					class="col-6" placeholder="재미있어요" /> <!-- 사용자가 답글 내용을 입력할 수 있도록 함 -->
				<label for="reply"class="video_label" >작성자</label> <!--  사용자가 등록자를 입력할 수 있도록 함 -->
				<input type="text" name="writer" class="col-3" placeholder="익명"> <input 
					type="submit" value="등록" class="col-1">
			</form>
		</div>
		<!-- 해당 비디오에 등록되어있는 모든 답글내용들을 가져와서 출력 -->
		<div class="video_reply2 row">
		<%while(rs.next()){ %>
			<p class="col-8"><%=rs.getString("writer")%>: <%=rs.getString("replyContent")%></p><p class="col-4"><%=rs.getString("date") %></p>
		<%} %>
		</div>
	</div>

	<%
	crud.close();
	rs.close();
	%>
</body>
</html>

