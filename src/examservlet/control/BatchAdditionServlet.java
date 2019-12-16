package examservlet.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import examService.service.QuestionExcelService;
import examService.service.StuInfoExcelService;
import exambean.model.QuestionBean;
import exambean.model.StudentInfoBean;
import examdao.model.DatabassAccessObject;


/**
 * @author JK164-39
 * 该类接受用户的读取Excel文件请求；
 * 调用ExcelService类解析Excel文件；
 * 将解析的表单信息写入数据库表中；
 * 此外，还可以接受批量上传的图片，并保存到工程目录下
 */
@WebServlet("/HandleBatchAdd")
@MultipartConfig // 支持文件上传
public class BatchAdditionServlet extends HttpServlet {
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
		String excelSorcePath = "";
		Integer mode = Integer.valueOf(request.getParameter("mode"));
		String savePath = getServletContext().getRealPath("/images");

		/**
		 * 以下部分为获取上传Excel文件并保存到发布目录
		 */
		Part part = request.getPart("excel"); // Excle文件
		String fileName = part.getSubmittedFileName(); // 获取part对象所携带的文件名称
		if (fileName.length() > 0) { // 如果文件不为空
			savePath = getServletContext().getRealPath("/images");
			part.write(savePath + "/" + fileName);// 上传文件到发布目录下
			excelSorcePath = savePath + "/" + fileName;
			// 图片的目标路径（当前项目目录）
		}

		/**
		 * 以下部分为获取批量上传的配图
		 */
		for (Part imgPath : request.getParts()) { // 遍历上传的每一个part
			if (imgPath.getName().startsWith("img")) {
				// 上传按钮也是part对象，在这里用if条件语句过滤它
				// 只接受part名称标头为"img"的正文图片数据
				String fileName1 = imgPath.getSubmittedFileName(); // 获取单张图片的文件名
				if (fileName1 == null || fileName1.length() == 0)
					break;
				try {
					imgPath.write(savePath + "/" + fileName1); // 写入图片到tomcat的发布目录下
					
				} catch (Exception e) {
					System.out.println(e);
				}

				/**
				 * 接下来要把图片从【tomcat发布目录】拷贝到【当前项目目录】 原因：发布目录在tomcat重启会重新发布，上传的图片需要迁移到永久保留的位置
				 * 目的：把图片拷贝到项目目录，上传的图片得以保留，可以任意次数发布
				 */
				try {// try能保证流被正确关闭
					Path sorcePath = Paths.get(savePath + "/" + fileName1); // 图片的原始路径（tomcat的发布目录下）
					// 图片的的目标路径（当前项目目录）
					Path targetPath = Paths.get("E:\\WorkSpace_All\\cli_workspace\\" + request.getContextPath()
							+ "/WebRoot/images/" + fileName1);
					Files.copy(sorcePath, targetPath, StandardCopyOption.REPLACE_EXISTING); // 复制文件，并替换已存在的文件
				} catch (Exception e) {
				}

			}
		}

		try {
			DatabassAccessObject db;
			switch (mode) {
			case 1:
				List<QuestionBean> listExcel = QuestionExcelService.getAllByExcel(excelSorcePath);
				db = new DatabassAccessObject();
				for (QuestionBean queBean : listExcel) {
					if (!QuestionExcelService.isExist(queBean.getQ_id())) {
						db.insert("insert into question values (?,?,?,?,?,?,?) ; ", queBean.getQ_id(),
								queBean.getQ_type(), queBean.getQ_title(), queBean.getQ_select(), queBean.getQ_score(),
								queBean.getQ_key(), queBean.getQ_img());
					} else {
						db.modify(
								"update question set type = ? , title  = ? , `select` = ? , score = ? , `key` = ? , img = ? where number = ? ;",
								queBean.getQ_type(), queBean.getQ_title(), queBean.getQ_select(), queBean.getQ_score(),
								queBean.getQ_key(), queBean.getQ_img(), queBean.getQ_id());
					}
				}

				System.out.println("数据导入成功");
				PrintWriter out = response.getWriter();
				out.println("<script language=javascript>alert('数据导入成功');window.location='" + request.getContextPath()
						+ "/ShowQuePage';</script>");
				break;
			case 2:
				List<StudentInfoBean> stuListExcel = StuInfoExcelService.getAllByExcel(excelSorcePath);

				db = new DatabassAccessObject();
				for (StudentInfoBean stuBean : stuListExcel) {
					if (!StuInfoExcelService.isExist(stuBean.getID())) {
						db.insert("INSERT INTO student (ID,password,name,class,score) VALUES (?,?,?,?,?) ; ",
								stuBean.getID(), stuBean.getPassword(), stuBean.getName(), stuBean.getCLASS(),
								stuBean.getScore());
					} else {
						db.modify("UPDATE student SET  password = ? , name = ? , class = ? , score = ? WHERE ID = ? ;",
								stuBean.getPassword(), stuBean.getName(), stuBean.getCLASS(), stuBean.getScore(),
								stuBean.getID());
					}
				}

				System.out.println("数据导入成功");
				PrintWriter out2 = response.getWriter();
				out2.println("<script language=javascript>alert('数据导入成功');window.location='" + request.getContextPath()
						+ "/ShowStuPage';</script>");
			default:
				break;
			}

		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

	}

}
