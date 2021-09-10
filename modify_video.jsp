<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.util.*, java.io.*, java.sql.*" import="myBean.*"%>
    
<%
String idx = request.getParameter("idx");
CRUD crud = new CRUD();
MovieInfo movie = crud.getRecord(Integer.parseInt(idx));  // 수정에 해당하는 객체의 정보를 담고있는 movie 객체를 가져옴
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
<link rel="stylesheet" href="./resource/css/register.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>
	<nav class="navbar navbar-dark fixed-top">
		<div class="logo" onClick="location.href='home.jsp'"><i class="fa-2x fa-fw fas fa-video" style="color:white"></i></div>
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
				<button type="submit" class="btn login_1">Login</button>
			</form>
		</div>
	</nav>

	<nav class="sidebar rounded">
		<ul class="sidebar_list">
			<li class="modify"><a> <i
					class="fa-2x fa-fw fas fa-clipboard-list sidebar_icon" onClick="location.href='videoBoard.jsp'"></i>
			</a></li>
		</ul>
	</nav>
	<!-- 앞에 가져온 movie 객체를 통해서 해당정보를 토대로 수정페이지를 제작 -->
	<div
		class="container-sm register_videoform pt-5 border border-white rounded">
		<form action="modify_video_do.jsp?idx=<%=idx%>" enctype="multipart/form-data" method="POST">
			<div class="register_title row">
				<label for="V_title" class="col-3 r_label">제목</label>
				 <input type="text" name="title" class="video_title col-9" value=<%=movie.getTitle()%>
					placeholder="영상 제목을 입력하세요">
			</div>
			<div class="register_thumbnail row">
			<label for="Pre_title" class="col-3 r_label">이전 이미지</label>
			
			<img src="./upload/<%=movie.getThumbnail()%>" width="100px" height="200px">
				<label for="V_title" class="col-3 r_label">썸네일
					등록</label> <input type="file" name="thumbnail" value=<%=movie.getThumbnail()%>
					class="video_thumbnail col-9">
			</div>
			<div class="register_video row">
				<label for="Pre_title" class="col-3 r_label">이전 동영상</label>
			
			<video src="./upload/<%=movie.getVideo()%>" width ="100" height="100"></video>
			
				<label for="video" class="col-3 r_label">영상파일 등록</label>

				<input type="file" name="video" class="video col-9" value=<%=movie.getVideo()%>>
			</div>
			<div class="register_info row">
				<label for="info"  class="col-3 r_label">영상 설명</label>
				<textarea name="info" class="info col-9" ><%=movie.getInfo()%></textarea>
			</div>
			<div class="register_author row">
			<label for="author" class="col-3 r_label">작성자</label>
				<input type = "text" name="author" value=<%=movie.getAuthor()%>>
			</div>
			<div class="register_btn row">
				<button type="submit" class="register_submit btn col-3">등록</button>
				<button type="button" class="register_cancellation col-3 btn" onClick="location.href='javascript:history.back();'">취소</button>
					
			</div>
	</form>
	</div>
	<%crud.close(); %>
</body>
</html>