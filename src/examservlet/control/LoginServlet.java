package examservlet.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exambean.model.LoginBean;

/**
 * @author JK164-39 
 * 该类负责处理登录操作
 * 匹配账号密码是否对应
 * 将登录信息存储到loginBean
 */
@WebServlet("/HandleLogin")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception e) {
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		Connection con;
		Statement sql;
		String ID = request.getParameter("ID").trim();
		String password = request.getParameter("password").trim();
		String userRole = request.getParameter("role").trim();
		String uri = "jdbc:mysql://127.0.0.1/examination?user=root&password=0000&serverTimezone=UTC&characterEncoding=UTF-8";

		boolean boo = (ID.length() > 0) && (password.length() > 0);
		try {
			con = DriverManager.getConnection(uri);
			String condition = "select * from " + userRole + " where ID = '" + ID + "' and password ='" + password
					+ "'";
			sql = con.createStatement();
			if (boo) {
				ResultSet rs = sql.executeQuery(condition);
				boolean isExist = rs.next();
				if (isExist == true) {
					success(request, response, rs, userRole);
					response.sendRedirect(userRole + "/" + userRole + ".jsp");
				} else {
					String backNews = "您输入的学号不存在/密码不匹配";
					fail(request, response, ID, backNews);
				}
			} else {
				String backNews = "请输入用户名和密码";
				fail(request, response, ID, backNews);
			}
			con.close();
		} catch (SQLException exp) {
			String backNews = "" + exp;
			fail(request, response, ID, backNews);
		}

	}

	/**
	 * 如果账号密码匹配成功，就把登录信息存储到Bean，
	 * 然后重定向进入与角色相相应的管理页面
	 * @param request	请求对象
	 * @param response	响应对象
	 * @param rs	查询结果数据集
	 * @param role	用户角色
	 */
	private void success(HttpServletRequest request, HttpServletResponse response, ResultSet rs, String role) {
		HttpSession session = request.getSession(true);
		LoginBean loginBean = new LoginBean();
		try {
			rs.first();
			loginBean.setID(rs.getString("ID"));
			loginBean.setPassword(rs.getString("password"));
			loginBean.setName(rs.getString("name"));
			loginBean.setCLASS(rs.getString("class"));
			loginBean.setRole(role);
			if (role.equals("student")) {
				loginBean.setScore(rs.getFloat("score"));
			} else {
				loginBean.setJob(rs.getString("job"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		session.setAttribute("loginBean", loginBean);
	}
	/**
	 * 如果账号密码匹配失败，就重定向回登录页面
	 * @param request	请求对象
	 * @param response	响应对象
	 * @param ID		用户ID
	 * @param backNews	登录失败的原因
	 */
	private void fail(HttpServletRequest request, HttpServletResponse response, String ID, String backNews) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			PrintWriter out = response.getWriter();
			out.println("<script language=javascript>alert('" + backNews + "');window.location='"
					+ request.getContextPath() + "/login.jsp';</script>");
		} catch (IOException exp) {
		}

	}

}
