package examservlet.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exambean.model.LoginBean;
import examdao.model.DatabassAccessObject;

/**
 * @author JK164-39
 * 该类实现数据表密码修改功能
 *
 */
@WebServlet("/HandlePassword")
public class PasswordModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session=request.getSession();
		LoginBean loginBean=(LoginBean) session.getAttribute("loginBean");
		String ID = loginBean.getID();
		String role = loginBean.getRole();
		String newPassword = request.getParameter("newPassword");
		String newPasswordAgain = request.getParameter("newPasswordAgain");
		try {
			if (newPassword.equals(newPasswordAgain)) {	//判断两次输入的密码是否一致
				DatabassAccessObject db = new DatabassAccessObject();
				db.modify("update "+role+" set password=? where ID=?", newPassword, ID);
				String msg="密码修改成功！请重新登录";
				PrintWriter out = response.getWriter();
				out.println("<script language=javascript>top.location='" + request.getContextPath()
						+ "/login.jsp';alert('" + msg + "')</script>");
			} else {
				String msg="两次输入的密码不一致！请重新确认。";
				PrintWriter out = response.getWriter();
				out.println("<script language=javascript>window.history.go(-1);alert('" + msg + "')</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}


}
