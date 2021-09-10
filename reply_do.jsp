<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="myBean.*"
    %>
    
<%
Reply reply = new Reply(); // 답글 정보를 담기위해 Reply 객체를 선언
CRUD crud = new CRUD(); // CRUD 내장함수들을 사용하기 위해 선언
request.setCharacterEncoding("utf-8");
int idx = Integer.parseInt(request.getParameter("idx"));
String writer = request.getParameter("writer");
String replyContent = request.getParameter("reply");
//사용자가 입력한 답글내용과 등록자 정보를 가져옴

reply.setIdx(idx); // forien_key를 사용하기 위해 해당 비디오의 idx 정보를 가져옴
if(writer==""&&replyContent==""){ // 만약 클라이언트가 아무것도 입력하지 않고 등록버튼을 눌럿을 시 "익명:재미있어요" 라고 출력하게 함 
	reply.setReplyContent("재미있어요.");
	reply.setWriter("익명");
}
else if(writer==""){ // 클라이언트가 등록자 정보를 입력하지 않았을 시 자동으로 "익명"으로 입력이 되도록 함
	reply.setReplyContent(replyContent);
	reply.setWriter("익명");
}
else if(replyContent==""){ // 클라이언트가 등록자 정보는 입력하였지만 답글정보를 입력하지 않았을때를 위해 "재미있어요"를 디폴트로함
	reply.setReplyContent("재미있어요.");
	reply.setWriter(writer);
}
else{ // 사용자가 답글내용과 등록자를 둘다 입력했을 시 해당정보에 맞춰서 업데이트 후 테이블에 등록을하는 insertReply를 선언
	reply.setReplyContent(replyContent);
	reply.setWriter(writer);
}
crud.insertReply(reply);

crud.close();
response.sendRedirect("video.jsp?idx=" + idx);
%>