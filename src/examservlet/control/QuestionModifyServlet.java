package examservlet.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import examdao.model.DatabassAccessObject;

/**
 * @author JK164-39
 * 负责处理题库表中题目的增删改查
 */
@WebServlet("/HandleQue")
@MultipartConfig //支持文件上传
public class QuestionModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

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
		
		String number=request.getParameter("number");
		String type="";
		String title="";
		String score="";
		String key="";
		String select = "";
		String fileName ="";
		if (mode!=2) {	//如果不用执行删除，就执行
			type=request.getParameter("type");
			title=request.getParameter("title");
			score=request.getParameter("score");
			key=request.getParameter("key");
			if (type.equals("单选题")||type.equals("多选题")) {
				String[] temp=request.getParameterValues("select");
				for (int i = 0; i < temp.length; i++) {
					select+=temp[i];
					if (i!=temp.length-1) {
						select+="@";
					}
				}
			}else {
				select=request.getParameter("select");
			}
			System.out.print(select);
			Part part = request.getPart("img"); //题目配图
			fileName = part.getSubmittedFileName(); // 获取part对象所携带的文件名称
			if (fileName.length() > 0) { //如果用户上传了题目配图
				String savePath = getServletContext().getRealPath("/images");
				part.write(savePath + "/" + fileName);//上传图片到发布目录下

				try {//try能保证文件流被正确关闭
					//图片的原始路径（tomcat的发布目录下）
					Path sorcePath = Paths.get(savePath + "/" + fileName); 
					//图片的目标路径（当前项目目录）
					Path targetPath = Paths.get("E:\\WorkSpace_All\\cli_workspace\\"+
							request.getContextPath()+"/WebRoot/images/" + fileName);
					//复制文件并替换已存在的文件
					Files.copy(sorcePath, targetPath, StandardCopyOption.REPLACE_EXISTING);
				} catch (Exception e) {}
				
			}
		}

		try {
			DatabassAccessObject db = new DatabassAccessObject();
			switch (mode) {
			case 0://增
				db.insert("insert into question values (?,?,?,?,?,?,?) ; ",number,type,title,select,score,key,fileName);
				break;
			case 1://改
				if (fileName!="") {
				db.modify("update question set type = ? , title  = ? , `select` = ? , score = ? , `key` = ? , img = ? where number = ? ;",type,title,select,score,key,fileName,number);
				}else {
					db.modify("update question set type = ? , title  = ? , `select` = ? , score = ? , `key` = ?  where number = ? ;",type,title,select,score,key,number);
				}
				break;
			case 2://删
				db.modify("delete from question where number = ? ; ", number);
				break;
			default:
				break;
			}		
		} catch (Exception e) {
		}
		
		if (mode==0) {
			PrintWriter out = response.getWriter();
			out.println ("<script language=javascript>window.location='"+request.getContextPath()+"/teacher/teacher_que_add.jsp';alert('已成功添加题目');</script>");
		}else
		response.sendRedirect("ShowQuePage");

	}

}
