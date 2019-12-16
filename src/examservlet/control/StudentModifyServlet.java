package examservlet.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * @author JK164-39
 * 该类实现修改学生信息表功能
 */
@WebServlet("/HandleStuInfo")
public class StudentModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		try {
			Class.forName("com.mysql.jdbc.Driver"); // 数据库驱动
		} catch (Exception e) {
		}
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // 编码处理
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String executeMode = request.getParameter("executeMode");
		int mode = Integer.parseInt(executeMode); // 转化整形
		System.out.println(mode);
		

		
		int cpage = 0;
		int per = 10;
		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		request.setAttribute("cpage", cpage);
		if (request.getParameter("per") != null) {
			per = Integer.parseInt(request.getParameter("per"));
		}
		request.setAttribute("per", per);
		String ID=request.getParameter("ID");
		Connection con;
		PreparedStatement sql = null;
		float score=0.0f;
		String name=request.getParameter("name");
		String Class=request.getParameter("class");
		String temp=request.getParameter("score");
		if(temp!=null)
			score = Float.parseFloat(temp);
		String password=request.getParameter("password");
		try {
			String uri = "jdbc:mysql://127.0.0.1/examination?user=root&password=&characterEncoding=utf-8&useSSL=false";
			con = DriverManager.getConnection(uri);
			String condition = "";
			
			switch (mode) {
			case 0: //模式0，增加一条数据
				condition = "INSERT INTO student (ID,password,name,class,score) VALUES (?,?,?,?,?);";
				sql = con.prepareStatement(condition);
				sql.setString(1, ID);
				sql.setString(2, password);
				sql.setString(3, name);
				sql.setString(4, Class);
				sql.setFloat(5, score);
				sql.executeUpdate();
				break;
			case 1: //模式1：更新一条数据
				condition = "UPDATE student SET  password = ? , name = ? , class = ? , score = ? WHERE ID = ? ;";
				sql = con.prepareStatement(condition);
				sql.setString(5, ID);
				sql.setString(1, password);
				sql.setString(2, name);
				sql.setString(3, Class);
				sql.setFloat(4, score);
				sql.executeUpdate();
				break;
			case 2: //模式2：删除一条数据
				condition = "DELETE FROM student WHERE ID = ? ;";
				sql = con.prepareStatement(condition);
				sql.setString(1, ID);
				sql.executeUpdate();
				break;
			default: //错误的模式选择
				fail(request, response, "executeMode模式错误，仅有0/1/2 3种情况");//报错
				break;
			}
			
			con.close();//关闭数据库连接
		} catch (Exception e) {}
		
		PrintWriter out = response.getWriter();
		out.println ("<script language=javascript>alert('已成功处理该条学生记录');window.location='"+request.getContextPath()+"/ShowStuPage?cpage="+cpage+"&per="+per+"'</script>");
//		request.getRequestDispatcher("ShowStuPage").forward(request,
//				response);
	}
	private void fail(HttpServletRequest request, HttpServletResponse response, String backNews) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			PrintWriter out = response.getWriter();
			out.println("<script language=javascript>alert('" + backNews + "');window.location='"
					+ request.getContextPath() + "ShowStuPage';</script>");
		} catch (IOException exp) {
		}
	}

}
