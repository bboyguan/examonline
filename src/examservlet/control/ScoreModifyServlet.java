package examservlet.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import examdao.model.DatabassAccessObject;

@WebServlet("/ScoreModify")
public class ScoreModifyServlet extends HttpServlet {
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
		String ID = request.getParameter("ID");
		String name = request.getParameter("name");
		String CLASS = request.getParameter("class");
		Float score_sing = Float.valueOf(request.getParameter("score_sing"));
		Float score_muti = Float.valueOf(request.getParameter("score_muti"));
		Float score_jud = Float.valueOf(request.getParameter("score_jud"));
		Float score_fill = Float.valueOf(request.getParameter("score_fill"));
		Float score_ess = Float.valueOf(request.getParameter("score_ess"));
		// Float score=Float.valueOf(request.getParameter("score"));
		Float score = score_sing + score_muti + score_jud + score_fill + score_ess;
		String grade = "";
		int f = Math.round(score);
		int g = ((f < 0) == true ? 1 : 0) + ((f < 60) == true ? 1 : 0) + ((f < 75) == true ? 1 : 0)
				+ ((f < 85) == true ? 1 : 0) + ((f < 95) == true ? 1 : 0);
		switch (g) {
		case 0:
			grade = "优秀";
			break;
		case 1:
			grade = "良好";
			break;
		case 2:
			grade = "中等";
			break;
		case 3:
			grade = "及格";
			break;
		case 4:
			grade = "不及格";
			break;
		case 5:
			grade = "缺考";
			break;
		default:
			break;
		}

		try {

			DatabassAccessObject db = new DatabassAccessObject();
//			ResultSet rs=db.query("select * from student where id = ?", ID);
//			if (rs.next()) {
//				db.modify(sql, args)
//			}
			Boolean boolean1 = db.modify("UPDATE student SET  name = ? , class = ? , score = ? WHERE ID = ? ", name,
					CLASS, score, ID);
			if (boolean1) {
				db.modify(
						"UPDATE score set score=?, score_sing=?, score_muti=?, score_jud=?, score_fill=?, score_ess=?, grade=? where ID=? ",
						score, score_sing, score_muti, score_jud, score_fill, score_ess, grade, ID);
			}
			PrintWriter out = response.getWriter();
			out.println("<script language=javascript>alert('已成功处理该条学生记录');window.location='" + request.getContextPath()
					+ "/ShowScorePage?cpage=" + cpage + "&per=" + per + "'</script>");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
