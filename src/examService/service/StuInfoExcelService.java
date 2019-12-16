package examService.service;

import java.io.File;
import java.io.FileInputStream;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import exambean.model.StudentInfoBean;
import examdao.model.DatabassAccessObject;

/**
 * @author JK164-39 该类用来解析EXCEL文件 并将单元格的列值存入Bean中 再将Bean存入List中
 */
public class StuInfoExcelService {
	public static List<StudentInfoBean> getAllByExcel(String filePath) {
		List<StudentInfoBean> list = new ArrayList<StudentInfoBean>();

		try {
			FileInputStream inp = new FileInputStream(filePath);

			Workbook wb = WorkbookFactory.create(inp);
			Sheet sheet = wb.getSheetAt(0);
			int rowStart = sheet.getFirstRowNum();
			int rowEnd = sheet.getLastRowNum() + 1;

			for (int rowNum = rowStart + 1; rowNum < rowEnd; rowNum++) {
				Row row = sheet.getRow(rowNum);

				String ID = getCellFormatValue(row.getCell(0));
				String password = getCellFormatValue(row.getCell(1));
				String name = getCellFormatValue(row.getCell(2));
				String cLASS = getCellFormatValue(row.getCell(3));
				Float score = Float.valueOf(getCellFormatValue(row.getCell(4)));

				list.add(new StudentInfoBean(ID, password, name, cLASS, score));

			}
			inp.close();
			delFile(filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 获取单元格的值
	 * 
	 * @param cell 单元格
	 * @return 字符串类型的单元格值
	 */
	public static String getCellFormatValue(Cell cell) {
		String cellValue = null;
		if (cell != null) {
			// 判断cell类型
			switch (cell.getCellType()) {
			case NUMERIC: {
				cellValue = String.valueOf(cell.getNumericCellValue());
				break;
			}
			case STRING: {
				cellValue = cell.getRichStringCellValue().getString();
				break;
			}
			default:
				cellValue = "";
			}
		} else {
			cellValue = "";
		}
		return cellValue;
	}

	/**
	 * 通过题目号判断是否存在
	 * 
	 * @param id
	 * @return
	 */
	public static boolean isExist(String ID) {

		DatabassAccessObject db;
		try {
			db = new DatabassAccessObject();
			ResultSet rs;
			rs = db.query("select * from student where ID=?", ID);
			if (rs.next()) {
				return true;
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		return false;
	}

	public static void delFile(String filePath) {
		File file = new File(filePath);
		if (file.exists() && file.isFile())
			file.delete();
	}

	public static Workbook getAllByDatabase() {
		Workbook wb = null;
		try {

			wb = new HSSFWorkbook();
			
			Sheet sheet = wb.createSheet("student");
			Row row = sheet.createRow(0);
			Cell cell = null;
			DatabassAccessObject db = new DatabassAccessObject();
			/**
			 * 设置列名
			 */
			ResultSet rs = db.query("select column_name from information_schema.columns where table_name='student' order by case \r\n" + 
					"when column_name = \"ID\" THEN 1 \r\n" + 
					"when column_name = \"password\" THEN 2 \r\n" + 
					"when column_name = \"name\" THEN 3\r\n" + 
					"when column_name = \"class\" THEN 4 \r\n" + 
					"when column_name = \"score\" THEN 5 \r\n" + 
					"end;");
			int i = 0;
			while (rs.next()) {
				
				cell = row.createCell(i);
				i++;
				String q = rs.getString(1);
				cell.setCellValue(q);
			}
			/**
			 * 设置列值
			 */
			rs = db.query("select * from student;");
			i=0;
			int j = 1;
			while (rs.next()) {
				
				row = sheet.createRow(j);
				j++;
				int rowNum = rs.getMetaData().getColumnCount();
				for (i = 0; i < rowNum; i++) {
					cell = row.createCell(i);
					String s=rs.getString(i+1);
					cell.setCellValue(s);
				}
								

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return wb;

	}
}
