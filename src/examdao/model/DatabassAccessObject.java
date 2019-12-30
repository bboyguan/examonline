package examdao.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 * @author JK164-39
 *该类是数据库连接对象，实现功能：
 *连接数据库，增加、删除、修改、查询数据。
 */
public class DatabassAccessObject {
	private Connection con;
 
	/**
	 * 构造函数，连接数据库
	 * @throws Exception
	 */
	public DatabassAccessObject() throws Exception {
		String dburl = "jdbc:mysql://localhost:3306/examination?serverTimezone=UTC&characterEncoding=utf8&useSSL=false";
		String dbusername = "root";
		String dbpassword = "0000";
		Class.forName("com.mysql.cj.jdbc.Driver");
		this.con = DriverManager.getConnection(dburl, dbusername, dbpassword);
	}
 
	/**
	 * 数据库查询
	 * @param sql  任意的SQL查询语句
	 * @param args 任意个用于替换占位符的形参
	 * @return		返回RestultSet类型的结果集
	 * @throws Exception
	 */
	public ResultSet query(String sql, Object... args) throws Exception {
		PreparedStatement ps = con.prepareStatement(sql);
		for (int i = 0; i < args.length; i++) {
			ps.setObject(i + 1, args[i]);
		}
		return ps.executeQuery();
	}
 
	/**
	 * 向数据库插入一条数据
	 * @param sql	任意的SQL插入语句
	 * @param args	任意个用于替换占位符的形参
	 * @return		返回值是布尔类型
	 * @throws Exception
	 */
	public boolean insert(String sql, Object... args) throws Exception {
		PreparedStatement ps = con.prepareStatement(sql);
		for (int i = 0; i < args.length; i++) {
			ps.setObject(i + 1, args[i]);
		}
		if (ps.executeUpdate() != 1) {
			return false;
		}
		return true;
	}
 
	/**
	 * 修改数据库中的数据
	 * @param sql	任意的SQL更新语句
	 * @param args	任意个用于替换占位符的形参
	 * @return		返回值是布尔类型
	 * @throws Exception
	 */
	public boolean modify(String sql, Object... args) throws Exception {
		PreparedStatement ps = con.prepareStatement(sql);
		for (int i = 0; i < args.length; i++) {
			ps.setObject(i + 1, args[i]);
		}
		if (ps.executeUpdate() != 1) {
			return false;
		}
		return true;
	}
 
	// 析构函数，中断数据库的连接
	protected void finalize() throws Exception {
		if (!con.isClosed() || con != null) {
			con.close();
		}
	}
}
