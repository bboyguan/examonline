package examservlet.control;

import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exambean.model.StudentInfoBean;
import examdao.model.DatabassAccessObject;

/**
 * @author JK164-39
 * 分页显示学生信息表的学生信息
 * 默认每页10条
 */
@WebServlet("/ShowStuPage")
public class StudentShowByPageServlet extends HttpServlet {
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
				rs=db.query("select * from student where ID LIKE '%"+s_ID+"%' ;");
			}else {
				rs = db.query("select * from student order by ID ;");
			}
			

			int total = 0;
			while (rs.next()) {
				StudentInfoBean stuBean = new StudentInfoBean();
				stuBean.setID(rs.getString("Id"));
				stuBean.setPassword(rs.getString("password"));
				stuBean.setName(rs.getString("Name"));
				stuBean.setCLASS(rs.getString("class"));
				stuBean.setScore(rs.getFloat("score"));
				stuBeanAllList.add(stuBean);
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
			request.getRequestDispatcher("/teacher/teacher_stu_manage.jsp").forward(request,
					response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
