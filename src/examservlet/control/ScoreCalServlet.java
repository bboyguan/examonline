package examservlet.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exambean.model.LoginBean;
import exambean.model.QuestionBean;
import examdao.model.DatabassAccessObject;

/**
 * @author JK164-39
 * 该类负责统计考生作答的分数；
 * 每种题型分别记分，成绩存入数据库。
 */
@WebServlet("/CalScoreServlet")
public class ScoreCalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(true);

		if (session == null) {
			response.sendRedirect("login.jsp");
		}
		//获取先前存储到Session对象中的试卷题目
		@SuppressWarnings("unchecked")
		ArrayList<QuestionBean> ques = (ArrayList<QuestionBean>) session.getAttribute("ques");
		String stuAnsArr[] = null;
		//每种题型分值，初值均为0
		float score = 0;
		float score_muti = 0;
		float score_sing = 0;
		float score_jud = 0;
		float score_fill = 0;
		float score_ess = 0;
		for (int i = 0; i < ques.size(); ++i) {
			QuestionBean que = ques.get(i);
			stuAnsArr = request.getParameterValues(que.getQ_id());//获取每道题的答案
			//如果是多选题，存在多个选项值，因此需要getParameterValues方法获取多个值

			if (!que.getQ_type().equals("简答题")) {//非简答题的记分方式相同，简答题独立计算
				if (stuAnsArr != null) {
					String stuAns = ""; //每道题的答案
					for (int j = 0; j < stuAnsArr.length; j++) {//多选题拥有多个答案
						stuAns += stuAnsArr[j];//组装学生答案
					}
					System.out.println(stuAns);
					if (stuAns.equalsIgnoreCase(que.getQ_key())) {	//匹配学生答案和正确答案
						switch (que.getQ_type()) { //每道题分别记分
						case "单选题":
							score_sing += Float.parseFloat(que.getQ_score());
							break;
						case "多选题":
							score_muti += Float.parseFloat(que.getQ_score());
							break;
						case "判断题":
							score_jud += Float.parseFloat(que.getQ_score());
							break;
						case "填空题":
							score_fill += Float.parseFloat(que.getQ_score());
							break;
						default:
							break;
						}
					}
				}
			} else { //简答题的判断方法
				String[] KEY_WORD = que.getQ_key().split("\\@");	//拆分正确答案中的关键词
				Float totalScore = Float.parseFloat(que.getQ_score());	//获取简答题分值
				Float singleScore = 0.0f;	//每个的分点的细分
				String stuAns = "";
				if (stuAnsArr != null) {
					for (int j = 0; j < stuAnsArr.length; j++) {
						stuAns += stuAnsArr[j];	//组装学生答案
					}
				}
				// 使用contains方法
				if (KEY_WORD != null) {	//如果关键词存在
					singleScore = totalScore / KEY_WORD.length; //按照关键词数量细分分值
					for (int j = 0; j < KEY_WORD.length; j++) {
						if (stuAns.contains(KEY_WORD[j])) { //判断考生答案中是否出现关键词
							System.out.println(stuAns + "包含关键词:" + KEY_WORD[j]);
							score_ess += singleScore;
						} else {
							System.out.println("不包含关键词:" + KEY_WORD[j]);
						}
					}
				}

			}
		}
		
		score = score_sing + score_muti + score_jud + score_fill + score_ess;
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
			//实例化数据库连接对象，把上面计算到的分值分别存入数据库中
			DatabassAccessObject db = new DatabassAccessObject();
			LoginBean loginBean = (LoginBean) session.getAttribute("loginBean");
			String ID = loginBean.getID();
			db.insert("update student set score = ? where ID = ? ", score, ID);
			
			ResultSet rs = db.query("select * from score where id = ?", ID);
			if (!rs.next()) {
				db.insert("insert into score values(?,?,?,?,?,?,?,?)", ID, score, score_sing, score_muti, score_jud,
						score_fill, score_ess,grade);
			} else {
				db.modify(
						"update score set score = ? , score_sing = ? , score_muti= ? , score_jud = ? , score_fill = ? , score_ess = ?,grade = ? where ID = ?  ;",
						score, score_sing, score_muti, score_jud, score_fill, score_ess,grade, ID);
			}
			rs = db.query("select * from student where id = ?", ID);
			rs.first();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(score);
		response.setContentType("text/html;charset=utf-8");
		
		//如果考生交了白卷，且作答时间有剩余5分钟以上，则建议考生继续作答，重定向回试卷页面；
		//否则，视为交卷成功，重定向回学生信息页。
		PrintWriter out = response.getWriter();
		long curTime = System.currentTimeMillis() / 1000;
		long endTime = (long) session.getAttribute("endTime");
		if (score == 0 && endTime - curTime >= 300) {
			out.println("<script language=javascript>if(confirm('时间尚有剩余，请认真作答')){window.location='" + request.getContextPath()
					+ "/student/student_exam_paper.jsp';}</script>");
			out.println("<script language=javascript>window.location='" + request.getContextPath()
					+ "/student/student.jsp';alert('试卷已经提交，可以查阅成绩单');</script>");
			LoginBean loginBean = (LoginBean) session.getAttribute("loginBean");
			loginBean.setScore(score);

		} else {
			LoginBean loginBean = (LoginBean) session.getAttribute("loginBean");
			loginBean.setScore(score);
			session.removeAttribute("examTime");
			session.removeAttribute("endTime");
			out.println("<script language=javascript>window.location='" + request.getContextPath()
					+ "/student/student.jsp';alert('试卷已经提交，可以查阅成绩单');</script>");
		}
	}
}
