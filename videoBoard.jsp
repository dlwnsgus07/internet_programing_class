<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.util.*, java.io.*, java.sql.*" import="myBean.*"%>


<%
try {
	CRUD crud = new CRUD(); // DB에 접속해서 보를 가져올수있도록 myBean패키지에서 선언한 CRUD를 사용
	ResultSet rs = crud.getAllRecord(); // 게시판이기 때문에 모든 영상정보를 가져와야 하기때문에 crud에서 선언한 getAllRecord 함수 사용
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>videoBoard</title>
<link rel="stylesheet" href="./resource/css/bootstrap.css">
<link rel="stylesheet" href="./resource/css/navbar.css">
<link rel="stylesheet" href="./resource/css/sidebar.css">
<link rel="stylesheet" href="./resource/css/videoBoard.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script>
	function delete_selected_video() { // 일괄삭제를 위해 함수 선언
		var arr = document.getElementsByName("selected_idx");
		var form = document.createElement("form");
		var url = "delete_video_slected_do.jsp";
		form.setAttribute("method", "post");
		form.setAttribute("action", url);

		for (var i = 0; i < arr.length; i++) {
			if (arr[i].checked) {
				var input = document.createElement("input");
				input.setAttribute("type", "hidden");
				input.setAttribute("name", "selected_idx");
				input.setAttribute("value", arr[i].value);
				form.appendChild(input);
			}
		}
		document.body.appendChild(form);
		form.submit();
	}
</script>

</head>
<body>
	<nav class="navbar navbar-dark fixed-top"> <!-- 가장 위에 로고, 검색 로그인 부분 -->
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
				<button type="submit" class="btn login">Login</button>
			</form>
		</div>
	</nav>
	<div class="board"><!-- 등록한 비디오들을 게시판 형태로 보여주는 페이지 -->
		<div class="new_delete"> <!-- 게시판 내에서 비디오를 등록하거나 일괄적으로 삭제할 수 있도록 해주는 버튼 -->

			<i class="fa-2x fa-fw fas fa-plus-circle sidebar_icon"
				onClick="location.href='registerVideo.jsp'"></i> <i
				class="fa-2x fa-fw fas fa-trash-alt sidebar_icon"
				onClick="delete_selected_video()"></i>

		</div>
		<table class="board_table" style="border: 3px;"><!-- 테이블의기본틀을 잡아줌 -->
			<tr>
				<th class="tb_selct">선택</th>
				<th class="tb_idx">번호</th>
				<th class="tb_modify">수정</th>

				<th class="tb_title">제목</th>
				<th class="tb_author">제작자</th>
				<th class="tb_register_date">등록날짜</th>
			</tr>
			<%
			while (rs.next()) { // DB에 등록되어 있는 모든 영상정보를 가져오고 이를 게시판형태로 나타잼
			%>
			<tr>
				<td><input type="checkbox" name="selected_idx"
					value=<%=rs.getInt("idx")%>></td>
				<td><%=rs.getString("idx")%></td>
				<td><input type="button" value="수정" class="btn_modify"
					onClick="location.href='modify_video.jsp?idx=<%=rs.getString("idx")%>'">
				</td>
				<td><a href="video.jsp?idx=<%=rs.getInt("idx")%>"> <%=rs.getString("title")%>
				</a></td>
				<td><%=rs.getString("author")%></td>
				<td><%=rs.getString("date")%></td>
			</tr>
			<%
			}
			rs.close();
			crud.close();
			} catch (SQLException e) {
			out.println("오류:" + e);
			}
			%>
		</table>
	</div>
</body>
</html>

