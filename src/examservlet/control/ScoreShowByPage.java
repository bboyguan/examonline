package examservlet.control;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exambean.model.StudentInfoBean;
import examdao.model.DatabassAccessObject;


@WebServlet("/ShowScorePage")
public class ScoreShowByPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException {
		// 如果没有参数传递过来，初定每页显示10条记录，显示第一页。
		// 然后把这两个参数压到request容器传到前台页面。request容器是前台页面收到即销毁的容器。
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
		
		try {
			// 数据库的查询结果有多少条记录
			DatabassAccessObject db=new DatabassAccessObject();
			ResultSet rsTotal = db
					.query("select count(*) as total from student");
			if (rsTotal.next()) {
				// 求出总页数压到request容器传递给前台页面。
				request.setAttribute("totalPage", 1
						+ (rsTotal.getInt("total") - 1) / per);
			}
			// 新建一个动态数组用来存放查询结果
			ArrayList<StudentInfoBean> stuBeanAllList = new ArrayList<StudentInfoBean>();
			ResultSet rs=null;
			String s_ID=request.getParameter("s_ID");
			if (s_ID!=null) {
				rs=db.query("select score.ID,class,name,score_sing,score_muti,score_jud,score_fill,score_ess,score.score,grade from student join score on student.id=score.id where score.id LIKE '%"+s_ID+"%' ;");
			}else {
				rs = db.query("select score.ID,class,name,score_sing,score_muti,score_jud,score_fill,score_ess,score.score,grade from student join score on student.id=score.id order by ID ;");
			}
			

			int total = 0;
			while (rs.next()) {
				String ID=rs.getString(1);
				String CLASS=rs.getString(2);
				String name=rs.getString(3);
				Float score_sing=Float.valueOf(rs.getString(4));
				Float score_muti=Float.valueOf(rs.getString(5));
				Float score_jud=Float.valueOf(rs.getString(6));
				Float score_fill=Float.valueOf(rs.getString(7));
				Float score_ess=Float.valueOf(rs.getString(8));
				Float score=Float.valueOf(rs.getString(9));
				String grade=rs.getString(10);
				stuBeanAllList.add(new StudentInfoBean(ID, CLASS, name, score_sing, score_muti, score_jud, score_fill, score_ess, score,grade));
				total++;
			}
			// 再通过根据cpage与per求出要推回给前台显示的数组
			ArrayList<StudentInfoBean> stuTableList = new ArrayList<StudentInfoBean>();
			for (int i = cpage * per; i < cpage * per + per && i < total; i++) {
				stuTableList.add(stuBeanAllList.get(i));
			}
			String temp=request.getParameter("modify_id");
			System.out.println(temp);
			request.setAttribute("modify_id", temp);
			request.setAttribute("total", total);
			request.setAttribute("stuTableList", stuTableList);
			request.getRequestDispatcher("/teacher/teacher_score_manage.jsp").forward(request,
					response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
