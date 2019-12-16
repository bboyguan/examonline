package examService.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import exambean.model.QuestionBean;
import examdao.model.DatabassAccessObject;

/**
 * @author JK164-39 
 * 该类用来解析EXCEL文件 并将单元格的列值存入Bean中 
 * 再将Bean存入List中
 */
public class QuestionExcelService {
	public static List<QuestionBean> getAllByExcel(String filePath) {
		List<QuestionBean> list = new ArrayList<QuestionBean>();

		Workbook wb;
		try {
			FileInputStream inp = new FileInputStream(filePath);
			wb = WorkbookFactory.create(inp);
			Sheet sheet = wb.getSheetAt(0);
			int rowStart = sheet.getFirstRowNum();
			int rowEnd = sheet.getLastRowNum() + 1;

			for (int rowNum = rowStart + 1; rowNum < rowEnd; rowNum++) {
				Row row = sheet.getRow(rowNum);

				String q_id = getCellFormatValue(row.getCell(0));
				String q_type = getCellFormatValue(row.getCell(1));
				String q_title = getCellFormatValue(row.getCell(2));
				String q_select = getCellFormatValue(row.getCell(3));
				String q_score = getCellFormatValue(row.getCell(4));
				String q_key = getCellFormatValue(row.getCell(5));
				String q_img = getCellFormatValue(row.getCell(6));

				list.add(new QuestionBean(q_id, q_type, q_title, q_select, q_score, q_key, q_img));
				
			}
			inp.close();
			delFile(filePath);
		} catch (EncryptedDocumentException | IOException e) {
			// TODO Auto-generated catch block
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
	public static boolean isExist(String number) {

		DatabassAccessObject db;
		try {
			db = new DatabassAccessObject();
			ResultSet rs;
			rs = db.query("select * from question where number=?", number);
			if (rs.next()) {
				return true;
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		return false;
	}
    public static void delFile(String filePath){
        File file=new File(filePath);
        if(file.exists()&&file.isFile())
            file.delete();
    }
    
	public static Workbook getAllByDatabase() {
		Workbook wb = null;
		try {
			wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet("question");
			Row row = sheet.createRow(0);
			Cell cell = null;
			DatabassAccessObject db = new DatabassAccessObject();
			/**
			 * 设置列名
			 */
			ResultSet rs = db.query("select column_name from information_schema.columns where table_name='question' order by case \r\n" + 
					"when column_name = \"number\" THEN 1 \r\n" + 
					"when column_name = \"type\" THEN 2 \r\n" + 
					"when column_name = \"title\" THEN 3\r\n" + 
					"when column_name = \"select\" THEN 4 \r\n" + 
					"when column_name = \"score\" THEN 5 \r\n" + 
					"when column_name = \"key\" THEN 6\r\n" + 
					"when column_name = \"img\" THEN 7 \r\n" + 
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
			rs = db.query("select * from question;");
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
