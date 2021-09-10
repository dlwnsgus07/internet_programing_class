<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.util.*, java.io.*, java.sql.*" import="myBean.*"%>
<%
try{
CRUD crud = new CRUD();
ResultSet rs = crud.getAllRecord(); // 모든 영상들의 정보를 가져옴
int i=0;
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
<!-- 부트스트랩이 아닌, 제가 만든 CSS 파일들을 디자인을 위해 import 합니다. -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<!-- bootStrap사용과 디자인에 필요한 icon 들을 fontawesome에서 바로 가져오기 위해서 사용하였습니다. -->
</head>
<body>
<!-- 상단에 위치하는 네비게이션바 -->
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
<!-- 왼쪽 사이드에 나오는 부분 -->
	<nav class="sidebar rounded">
		<ul class="sidebar_list">
			<li class="add"><a> <i
					class="fa-2x fa-fw fas fa-plus-circle sidebar_icon"
					onClick="location.href='registerVideo.jsp'"
					></i>
			</a></li>
			<li class="modify"><a> <i
					class="fa-2x fa-fw fas fa-clipboard-list sidebar_icon" onClick="location.href='videoBoard.jsp'"></i><!-- 비디오 목록 게시판으로 이동 -->
			</a></li>
			<li class="delete"><a> <i
					class="fa-2x fa-fw fas fa-trash-alt sidebar_icon" onClick="location.href='videoBoard.jsp'"></i><!-- 비디오 목록 게시판으로 이동 -->
			</a></li>
		</ul>
	</nav>
	<!-- 비디오 갯수에 맞춰서 비디오들을 한줄에 3개의 틀에 맞춰서 출력한다. -->
	<div class="container-sm  pt-5">
		<%while(rs.next()) {%>
		<%if(i%3==0) {%>
		<div class="row border-bottom border-dark">
		<%}%>

			<div class="col-4 border video">
				<div class="Video_Preview">
					<img src="<%= "./upload/" + rs.getString("thumbnail") %>"
						class="img-thumbnail"
						style="height:200px"
						onClick="location.href='video.jsp?idx=<%=rs.getInt("idx") %>'"
						>
					
				</div>
				<div class="title_author">
					<div class="title" onClick="location.href='video.jsp?idx=<%=rs.getInt("idx") %>'" ><%=rs.getString("title")%></div>
					<!--이미지와 제목을 클릭할 시 해당하는 비디오로 redirect시킴 -->
					<div class="author"><%=rs.getString("author") %>
						<%=rs.getString("date")%></div>
				</div>
			</div>
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
