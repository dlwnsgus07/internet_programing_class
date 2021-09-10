package myBean;

import java.sql.*;
import javax.naming.NamingException;

public class CRUD {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public CRUD() throws SQLException, NamingException{
		con = MovieBoardCon.getConnection();
	}
	 //데이터 베이스를 연결함
	
	public int insertRecord(MovieInfo video) throws SQLException, NamingException { // insert 쿼리문을 사용하여 테이블에 내용 삽입
		String sql = "INSERT INTO videoBoard(title,thumbnail,video,info,author) VALUES(?,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, video.getTitle());
		pstmt.setString(2, video.getThumbnail());
		pstmt.setString(3, video.getVideo());
		pstmt.setString(4, video.getInfo());
		pstmt.setString(5, video.getAuthor());
		pstmt.executeUpdate();
		sql = "select idx from videoBoard where video=?";  // 바로 해당 비디오에 redirect 시켜주기 위해 해당 영상의 인덱스를 반환하기 위해 쿼리를 한번 더 실행
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,video.getVideo());
		rs = pstmt.executeQuery();
		rs.next();
		int idx =Integer.parseInt(rs.getString("idx")); 
		return idx;
	}
	
	public void modifyRecord(MovieInfo video) throws SQLException, NamingException { // 영상을 수정하는 역활을 함, UPDATE사용
		String sql = "UPDATE videoBoard set title=?, thumbnail=? ,video=? ,info=? ,author=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, video.getTitle());
		pstmt.setString(2, video.getThumbnail());
		pstmt.setString(3, video.getVideo());
		pstmt.setString(4, video.getInfo());
		pstmt.setString(5, video.getAuthor());
		pstmt.setInt(6, video.getIdx());	
		pstmt.executeUpdate();
	}
	public void modifyRecord_NO_VIDEO(MovieInfo video) throws SQLException, NamingException { // video를 사용자가 수정하지 않았을때 비디오를 뺀 다른 부분만 수정할 수 있도록 한다.
		String sql = "UPDATE videoBoard set title=?, thumbnail=? ,info=? ,author=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, video.getTitle());
		pstmt.setString(2, video.getThumbnail());
		pstmt.setString(3, video.getInfo());
		pstmt.setString(4, video.getAuthor());
		pstmt.setInt(5, video.getIdx());	
		pstmt.executeUpdate();
	}
	public void modifyRecord_NO_THUMBNAIL(MovieInfo video) throws SQLException, NamingException { // 썸네일을 제외하고 수정했을때 사용
		String sql = "UPDATE videoBoard set title=?,video=? ,info=? ,author=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, video.getTitle());
		pstmt.setString(2, video.getVideo());
		pstmt.setString(3, video.getInfo());
		pstmt.setString(4, video.getAuthor());
		pstmt.setInt(5, video.getIdx());	
		pstmt.executeUpdate();
	}
	public void modifyRecord_NO_ITEM(MovieInfo video) throws SQLException, NamingException { // 사용자가 비디오와 썸네일을 둘다 그대로 사용할 때 사용
		String sql = "UPDATE videoBoard set title=?,info=? ,author=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, video.getTitle());
		
		pstmt.setString(2, video.getInfo());
		pstmt.setString(3, video.getAuthor());
		pstmt.setInt(4, video.getIdx());	
		pstmt.executeUpdate();
	}
	public void deleteRecord(int idx) throws SQLException, NamingException{ // 해당 비디오가 videoBoard테이블에서 갖고있는 idx를 사용하여 삭제
		String sql = "DELETE FROM videoBoard where idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		pstmt.executeUpdate();
	}
	public MovieInfo getRecord(int idx) throws SQLException, NamingException{ // 특정 index를 사용하여 영상의 정보를 가져옴
		String sql = "SELECT title, thumbnail, video, info, author, date from videoBoard where idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		rs = pstmt.executeQuery(); //idx를 이용해서 해당 정보를 resultSet에 가져옴
		rs.next();
		MovieInfo movieInfo  = new MovieInfo();
		movieInfo.setTitle(rs.getString("title"));
		movieInfo.setThumbnail(rs.getString("thumbnail"));
		movieInfo.setVideo(rs.getString("video"));
		movieInfo.setInfo(rs.getString("info"));
		movieInfo.setAuthor(rs.getString("author"));
		movieInfo.setDate(rs.getDate(6));
		return movieInfo; // resultSet에서 가저온 정보를 토대로 movieInfo 객체를 만든 뒤 사용자가 사용할 수 있도록 return
	}
	public ResultSet getAllRecord() throws SQLException, NamingException{ // 모든 정보를 return함
		String sql = "SELECT idx, title, thumbnail, video, info, author, date from videoBoard";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		return rs;
	}
	public ResultSet deleteFile(int idx) throws SQLException, NamingException{ //파일을 삭제할떄 용이하도록 비디오와 썸네일 파일의 경로를 갖고있는 video, thumbnail 정보를 반환
		String sql = "SELECT thumbnail, video FROM videoBoard WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		rs = pstmt.executeQuery();
		rs.next();
		return rs;
	}
	public void deleteSelectFile(String[] selected_idx) throws SQLException{ // selectbox로 선택한 부분들을 일괄적으로 삭제할 수 있도록 하는 함수
			   
				con.setAutoCommit(false);
				String sql = "delete from videoBoard where idx=?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				try{
				for(int i=0;i<selected_idx.length;i++){
					pstmt.setInt(1, Integer.parseInt(selected_idx[i]));
					pstmt.addBatch();
				}
				pstmt.executeBatch();
				con.commit();
				}catch(SQLException e){
					con.rollback();
					throw e;
				}
				con.setAutoCommit(true);
	}
	public ResultSet searchVideo(String word) throws SQLException, NamingException{ // 클라이언트가 특정 단어를 입력했을때 해당단어를 포함하는 모든 결과를 가져옴 , 따라서 %+word+%를 사용
		String sql = "SELECT idx, title, thumbnail, video, info, author, date from videoBoard where title like ?";
		pstmt = con.prepareStatement(sql);
		word = "%"+word+"%";
		pstmt.setString(1, word);
		rs = pstmt.executeQuery();
		return rs;
	}
	public void insertReply(Reply reply) throws SQLException, NamingException{ // reply 테이블에 답글내용을 삽입하는 함수
		String sql = "INSERT INTO reply(videoIdx,writer,replyContent) VALUES(?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, reply.getIdx());
		pstmt.setString(2, reply.getWriter());
		pstmt.setString(3, reply.getReplyContent());
		pstmt.executeUpdate();
	}
	public ResultSet getAllReply(int idx) throws SQLException, NamingException{ // 모든 reply 테이블에 있는 정보를 가져와서 resultSet을 return 함.
		String sql = "SELECT writer, replyContent, date from reply where videoIdx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		rs = pstmt.executeQuery();
		return rs;
	}
	public void close() throws SQLException { // 사용을 마친 커넥션과 resultSet PreparedStatement를 해지해줌
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
}
