package examservlet.control;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exambean.model.QuestionBean;
import examdao.model.DatabassAccessObject;

/**
 * @author JK164-39
 * 该类是自动抽提组卷类，实现功能：
 * 1.每种题型随机抽取指定条数，例：选择题抽5条；
 * 2.被抽中的题目信息传入QuestionBean储存；
 * 3.把Bean存入动态数组ArrayList组成试卷数组；
 * 4.把试卷数组存入Session对象，供考生作答。
 */
@WebServlet("/HandlePaper")
public class QuestionExtractServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	int tihao = 0;
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ArrayList<QuestionBean> listALL = new ArrayList<QuestionBean>();
		
		//抽题数量
		//单选题抽5道，多选题抽4道，判断题抽5道，填空题抽5道，简答题抽3道
		int num1=5,num2=4,num3=5,num4=5,num5=3;
		int examTime=30;
		try {
			DatabassAccessObject db = new DatabassAccessObject();
			ResultSet rs=db.query("select * from paper");
			num1=Integer.valueOf(rs.getString("qty_sing"));
			num2=Integer.valueOf(rs.getString("qty_muti"));
			num3=Integer.valueOf(rs.getString("qty_jud"));
			num4=Integer.valueOf(rs.getString("qty_fill"));
			num5=Integer.valueOf(rs.getString("qty_ess"));
			examTime=Integer.valueOf(rs.getString("time"));
		} catch (Exception e) {
			
		}
		
		try {
			DatabassAccessObject db = new DatabassAccessObject();
			ResultSet rs = db.query("SELECT * FROM question");
			//区分每种题型，将所有相同题型的行号存入双向循环链表，用于随机取题目
			LinkedList<Integer> list1 = new LinkedList<Integer>();
			LinkedList<Integer> list2 = new LinkedList<Integer>();
			LinkedList<Integer> list3 = new LinkedList<Integer>();
			LinkedList<Integer> list4 = new LinkedList<Integer>();
			LinkedList<Integer> list5 = new LinkedList<Integer>();
			while (rs.next()) {	//遍历整个题库表
				switch (rs.getString(2)) {	//多分支语句区分题型
				case "单选题":
					list1.add(rs.getRow());//获取所有选择题的行号
					break;
				case "多选题":
					list2.add(rs.getRow());
					break;
				case "判断题":
					list3.add(rs.getRow());
					break;
				case "填空题":
					list4.add(rs.getRow());
					break;
				case "简答题":
					list5.add(rs.getRow());
					break;
				default:
					break;
				}
			}

					
			listALL.addAll(randomQue(list1, rs,num1));	
			listALL.addAll(randomQue(list2, rs,num2));	
			listALL.addAll(randomQue(list3, rs,num3));	
			listALL.addAll(randomQue(list4, rs,num4));	
			listALL.addAll(randomQue(list5, rs,num5));	

			tihao=0;	//题号从0开始
			HttpSession session = request.getSession();
			session.setAttribute("examTime", examTime);
			session.setAttribute("ques", listALL);	//把试卷数组保存到Session对象
			//重定向到试卷页面，供考生作答
			response.sendRedirect(request.getContextPath()+"/student/student_exam_paper.jsp");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	/**
	 * 负责每种题型、指定数量的随机抽题
	 * @param list	题目链表（存储了一类题型的行号）
	 * @param rs	数据表结果集
	 * @param count 抽取指定的题目数量
	 * @return		返回一个（存储了count条指定类型的题目）数组
	 */
	public ArrayList<QuestionBean> randomQue(LinkedList<Integer> list,ResultSet rs,int count) {
		int m = -1;
		int index = -1;
		ArrayList<QuestionBean> listA = new ArrayList<QuestionBean>();
		while (list.size() > 0&&count>0) {
			count--;
			m = (int) (Math.random() * list.size());
			index = list.get(m);
			System.out.println(index);
			list.remove(m);
			tihao++;
			try {
				rs.absolute(index);
				QuestionBean queBean = new QuestionBean();
				queBean.setQ_id(String.valueOf(tihao));
				queBean.setQ_type(rs.getString(2));
				queBean.setQ_title(rs.getString(3));
				String selectString = rs.getString(4);
				System.out.println(rs.getString(2));
				queBean.setQ_score(rs.getString(5));
				queBean.setQ_key(rs.getString(6));
				queBean.setQ_img(rs.getString(7));
				if (selectString != null) {
					queBean.setQ_select(selectString);
					String[] temp = selectString.split("\\@");
					queBean.setOptions(temp);
				}
				listA.add(queBean);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return listA;
	}
}
