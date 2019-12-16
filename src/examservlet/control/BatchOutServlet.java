package examservlet.control;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import examService.service.QuestionExcelService;
import examService.service.ScoreExcleService;
import examService.service.StuInfoExcelService;

@WebServlet("/BatchOutServlet")
public class BatchOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		
		Integer mode = Integer.valueOf(request.getParameter("mode"));
		HSSFWorkbook workbook=null;
		String createExcelname = "";
		switch (mode) {
		case 1:
			workbook=(HSSFWorkbook) StuInfoExcelService.getAllByDatabase();
			createExcelname = "tb_student.xls";
			break;
		case 2:
			workbook=(HSSFWorkbook) QuestionExcelService.getAllByDatabase();
			createExcelname = "tb_question.xls";
			break;
		case 3:
			workbook=(HSSFWorkbook) ScoreExcleService.getAllByDatabase();
			createExcelname = "tb_student_score.xls";
			break;
		default:
			break;
		}
		
		
		String dir = request.getSession().getServletContext().getRealPath("/images");
		File fileLocation = new File(dir);
		if (!fileLocation.exists()) {
			boolean isCreated = fileLocation.mkdir();
		}
		String webUrl = request.getSession().getServletContext().getRealPath("/images");
		String outputFile = webUrl + File.separator + createExcelname;
		FileOutputStream fop = new FileOutputStream(outputFile);
		workbook.write(fop);
		fop.flush();
		fop.close();
		File f = new File(outputFile);
		if (f.exists() && f.isFile()) {
			try {
				FileInputStream fis = new FileInputStream(f);
				URLEncoder.encode(f.getName(), "utf-8");
				byte[] b = new byte[fis.available()];
				fis.read(b);
				response.setCharacterEncoding("utf-8");
				response.setHeader("Content-Disposition", "attachment; filename=" + createExcelname + "");
				ServletOutputStream out = response.getOutputStream();
				out.write(b);
				out.flush();
				out.close();
				if (fis != null) {
					fis.close();
				}
				f.delete();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
