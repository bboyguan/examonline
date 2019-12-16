package examservlet.control;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exambean.model.QuestionBean;
import examdao.model.DatabassAccessObject;

/**
 * @author JK164-39
 * 分页显示题库表的题目信息
 * 默认每页10条
 */
@WebServlet("/ShowQuePage")
public class QuestionShowByPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
		// 之后进行数据库的查询
		try {
			// 先数据库的查询结果有多少条记录
			DatabassAccessObject db = new DatabassAccessObject();
			ResultSet rsTotal = db.query("select count(*) as total from question");
			if (rsTotal.next()) {
				// 求出总页数压到request容器传递给前台页面。
				request.setAttribute("totalPage", 1 + (rsTotal.getInt("total") - 1) / per);
			}
			// 新建一个动态数组用来存放查询结果
			ArrayList<QuestionBean> queBeanAllList = new ArrayList<QuestionBean>();
			
			ResultSet rs=null;
			String q_title=request.getParameter("q_title");
			String q_type="";
			q_type=request.getParameter("q_type");
			if (q_title!=null) {
				rs=db.query("select * from question where title LIKE '%"+q_title+"%' ;");
			}else if(q_type!=null&&q_type.length()>0){
				
				rs=db.query("select * from question where type='"+q_type+"' ;");
			}
			else {
				rs = db.query("select\r\n" + 
						"    *\r\n" + 
						"from\r\n" + 
						"    question\r\n" + 
						"order by\r\n" + 
						"    case \r\n" + 
						"      when type='单选题' then 1\r\n" + 
						"      when type='多选题' then 2\r\n" + 
						"			when type='判断题' then 3\r\n" + 
						"			when type='填空题' then 4\r\n" + 
						"			when type='简答题' then 5\r\n" + 
						"    end");
			}
			// 所有查询结果存入数组
			int total = 0;
			while (rs.next()) {
				QuestionBean queBean = new QuestionBean();
				queBean.setQ_id(rs.getString("number"));
				queBean.setQ_type(rs.getString("type"));
				queBean.setQ_title(rs.getString("title"));
				String selectString = rs.getString("select");
				if (selectString != null) {
					queBean.setQ_select(selectString);
					String[] temp = selectString.split("\\@");
					queBean.setOptions(temp);
				}
				queBean.setQ_score(rs.getString("score"));
				queBean.setQ_key(rs.getString("key"));
				queBean.setQ_img(rs.getString("img"));
				queBeanAllList.add(queBean);
				total++;
			}
			ArrayList<QuestionBean> queTableList = new ArrayList<QuestionBean>();
			for (int i = cpage * per; i < cpage * per + per && i < total; i++) {
				queTableList.add(queBeanAllList.get(i));
			}
			String temp=request.getParameter("modify_id");
			request.setAttribute("modify_id", temp);
			request.setAttribute("total", total);
			request.setAttribute("queTableList", queTableList);
			request.getRequestDispatcher("/teacher/teacher_que_manage.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
