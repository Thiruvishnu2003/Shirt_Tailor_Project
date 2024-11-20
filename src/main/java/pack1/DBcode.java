package pack1;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class DBcode {
	Connection con = null;
	PreparedStatement ps;
	public DBcode(){
		try {
			String url = "jdbc:mysql://localhost:3306/project";
			String user = "root";
			String pass = "Vishnu@123";
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,user,pass);
			System.out.print("Connected");
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	public int addOrder(String cname,long phone,String or_date,String del_date,float neck_size,float length,float chest_size,float stomach_size,float hip_size,float sleeve_size,String pocket,String order_status) throws SQLException {
		int res = 0;
		String query = "insert into shirts(name, phone, or_date, del_date, neck_size, length, chest_size, stomach_size, hip_size, sleeve_size, pocket, order_status) values(?,?,?,?,?,?,?,?,?,?,?,?);";
		ps = con.prepareStatement(query);
		ps.setString(1, cname);
		ps.setLong(2, phone); 
		ps.setString(3, or_date);
		ps.setString(4, del_date);
		ps.setFloat(5,neck_size);
		ps.setFloat(6,length);
		ps.setFloat(7, chest_size);
		ps.setFloat(8, stomach_size);
		ps.setFloat(9, hip_size);
		ps.setFloat(10, sleeve_size);
		ps.setString(11, pocket);
		ps.setString(12, order_status);
		res = ps.executeUpdate();
		return res;
	}
	public ResultSet activeOrders() throws SQLException {
		String query = "select * from shirts where order_status = 'Active'";
		ps = con.prepareStatement(query);
		ResultSet rs = ps.executeQuery();
		return rs;
	}
	public int finishOrder(int id) throws SQLException {
		int res = 0;
		String query = "update shirts set order_status = 'finished' where id = ?";
		ps = con.prepareStatement(query);
		ps.setInt(1, id);
		res = ps.executeUpdate();
		return res;
	}
	public ResultSet finishedOrders() throws SQLException {
		String query = "select * from shirts where order_status = 'finished'";
		ps = con.prepareStatement(query);
		ResultSet rs = ps.executeQuery();
		return rs;
	}
	public int cancelOrder(int id) throws SQLException {
		int res = 0;
		String query = "delete from shirts where id = ?";
		ps = con.prepareStatement(query);
		ps.setInt(1, id);
		res = ps.executeUpdate();
		return res;
	}
	public int collectOrder(int id) throws SQLException {
		int res = 0;
		String query = "update shirts set order_status = 'collected' where id = ?";
		ps = con.prepareStatement(query);
		ps.setInt(1, id);
		res = ps.executeUpdate();
		return res;
	}
	public int editOrder(int id,String name,long phone,String or_date,String del_date,float neck_size,float length,float chest_size,float stomach_size,float hip_size,float sleeve_size,String pocket) throws SQLException {
		int res = 0;
		String query = "update shirts set name=?,phone=?,or_date=?,del_date=?,neck_size=?,length=?,chest_size=?,stomach_size=?,hip_size=?,sleeve_size=?,pocket=? where id=?";
		ps = con.prepareStatement(query);
		ps.setString(1, name);
		ps.setLong(2,phone);
		ps.setString(3, or_date);
		ps.setString(4, del_date);
		ps.setFloat(5, neck_size);
		ps.setFloat(6, length);
		ps.setFloat(7, chest_size);
		ps.setFloat(8, stomach_size);
		ps.setFloat(9, hip_size);
		ps.setFloat(10,sleeve_size);
		ps.setString(11,pocket);
		ps.setInt(12, id);
		res = ps.executeUpdate();
		return res;
	}
	public ResultSet searchOrder(Long phone) throws SQLException {
		String query = "select * from shirts where phone = ?";
		ps = con.prepareStatement(query);
		ps.setLong(1, phone);
		ResultSet rs = ps.executeQuery();
		return rs;
	}
}
