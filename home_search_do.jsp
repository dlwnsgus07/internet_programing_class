<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.util.*, java.io.*, java.sql.*" import="myBean.*"%>
<%
try{
request.setCharacterEncoding("utf-8");
String word = request.getParameter("search_word"); // 사람들이 검색한 단어를 가져옴
CRUD crud = new CRUD();
ResultSet rs = crud.searchVideo(word); // 단어를 토대로 검색한 영상들의 정보를 ResultSet형태로 가져옴
int i=0; // 반복문을 실행하여 비디오 모양 틀을 잡기 위해 i 선언
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
<link rel="stylesheet" href="./resource/css/main.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>
	<nav class="navbar navbar-dark fixed-top">
		<div class="logo" onClick="location.href='home.jsp'"><i class="fa-2x fa-fw fas fa-video" style="color:white"></i></div>
		<div class="wrap">
			<form class="search" method="post" action="home_search_do.jsp">
				<input type="text" class="searchTerm" placeholder="찾으시는 영상을 검색하세요" name="search_word">
				<button type="submit" class="searchButton">
					<i class="fa fa-search"></i>
				</button>
			</form>
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
			<li class="add"><a> <i
					class="fa-2x fa-fw fas fa-plus-circle sidebar_icon"
					onClick="location.href='registerVideo.jsp'"
					></i>
			</a></li>
			<li class="modify"><a> <i
					class="fa-2x fa-fw fas fa-clipboard-list sidebar_icon" onClick="location.href='videoBoard.jsp'"></i>
			</a></li>
			<li class="delete"><a> <i
					class="fa-2x fa-fw fas fa-trash-alt sidebar_icon"></i>
			</a></li>
		</ul>
	</nav>
	<div class="container-sm  pt-5">
		<%while(rs.next()) {%>
		<%if(i%3==0) { /* 영상을 3개 가져왔다면 다음 줄로 넘김*/%> 
		<div class="row border-bottom border-dark">
		<%}%>

			<div class="col-4 border video">
				<div class="Video_Preview">
					<img src="<%= "./upload/" + rs.getString("thumbnail") %>"
						style="height:200px"
						class="img-thumbnail"
						onClick="location.href='video.jsp?idx=<%=rs.getInt("idx") %>'"
						>
					<!-- 썸네일 출력 하는 부분 -->
				</div>
				<div class="title_author">
					<div class="title" onClick="location.href='video.jsp?idx=<%=rs.getInt("idx") %>'"><%=rs.getString("title")%></div>
					<div class="author"><%=rs.getString("author") %>
						<%=rs.getString("date")%></div>
				</div>
			</div>
			<!-- 영상에 관한 정보들을 대략적으로 선언 -->
			<%
			i++;
			if(i%3==0&&i!=0){ %>
		</div>
		<%} %>
		<% 
}
	crud.close();
	rs.close();
}
catch(SQLException e){
	out.println(e);
}
	%>

	</div>

</body>
</html>
