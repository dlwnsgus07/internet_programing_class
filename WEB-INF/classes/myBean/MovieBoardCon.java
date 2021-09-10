package myBean;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.*;
import javax.sql.DataSource;


public class MovieBoardCon {

	public static Connection getConnection() throws SQLException, NamingException{ // 커넥션 풀을 이용하여 디비를 연동 한번만 실행되도록 static 사용
		Context InitContext = new InitialContext();
		DataSource ds = (DataSource)InitContext.lookup("java:/comp/env/jdbc/movieboard");
		
		return ds.getConnection();
	}
	
}