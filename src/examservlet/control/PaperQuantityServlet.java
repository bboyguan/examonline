package examservlet.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import examdao.model.DatabassAccessObject;

/**
 * @author JK164-39
 *	该类负责修改考题数量和考试时间
 */
@WebServlet("/PaperQuantity")
public class PaperQuantityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // 编码处理
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		int id=Integer.valueOf(request.getParameter("id"));
		int time=Integer.valueOf(request.getParameter("time"));
		int qty_sing=Integer.valueOf(request.getParameter("qty_sing"));
		int qty_muti=Integer.valueOf(request.getParameter("qty_muti"));
		int qty_jud=Integer.valueOf(request.getParameter("qty_jud"));
		int qty_fill=Integer.valueOf(request.getParameter("qty_fill"));
		int qty_ess=Integer.valueOf(request.getParameter("qty_ess"));
		
		int quantity=qty_sing+qty_muti+qty_jud+qty_fill+qty_ess;

		try {

			DatabassAccessObject db = new DatabassAccessObject();

			db.modify("UPDATE paper SET time=?,  qty_sing = ? , qty_muti = ? , qty_jud = ? , qty_fill=?, qty_ess=? , quantity = ? WHERE id = ? ;", time,
				qty_sing, qty_muti, qty_jud,qty_fill,qty_ess,quantity,id);
			PrintWriter out = response.getWriter();
			out.println("<script language=javascript>alert('已成功修改');window.location='" + request.getContextPath()
					+ "/teacher/teacher_paper_manage.jsp '</script>");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
