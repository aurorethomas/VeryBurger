package application;
import java.sql.*;

public class Database {
	protected Connection conn;
	
	public Database(String login, String password, String server) throws SQLException{
		String url = "jdbc:oracle:thin:";
		// "@oracle.iut-orsay.fr:1521:etudom"
		url+= login +"/" + password + server;
		try{
			this.conn = DriverManager.getConnection(url);
		}
		catch (SQLException e){
			System.out.println("err connection au serveur : "+ server);
			System.exit(1);
		}
	}

	public Connection getConn() {
		return conn;
	}
}
