package com.app.viewresolver;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

public class CampaignExcelView extends AbstractXlsxView{

	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
			List<Map<String, Object>> campaigns = (List<Map<String, Object>>)model.get("TOP_CAMPAIGN");
			
			Sheet sheet = workbook.createSheet("Top Campaign Report");
			CellStyle style = workbook.createCellStyle();
	        style.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.index);
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setAlignment(CellStyle.ALIGN_CENTER);
			Row header = sheet.createRow(0);
			header.createCell(0).setCellValue("ID");
			header.createCell(1).setCellValue("Campaign Name");
			header.createCell(2).setCellValue("Campaign Type");
			header.createCell(3).setCellValue("Campaign Status");
			header.createCell(4).setCellValue("Start Date");
			header.createCell(5).setCellValue("End Date");
			header.createCell(6).setCellValue("Num Sent");
	        
	        int counter = 1;
	        for(Map<String, Object> map :campaigns){
	        	Row row  = sheet.createRow(counter++);
	        	row.createCell(0).setCellValue(map.get("campId").toString());
	        	row.createCell(1).setCellValue(map.get("campName").toString());
	        	row.createCell(2).setCellValue(map.get("typeName").toString());
	        	row.createCell(3).setCellValue(map.get("statusName").toString());
	        	row.createCell(4).setCellValue(map.get("startDate").toString());
	        	row.createCell(5).setCellValue(map.get("endDate").toString());
	        	row.createCell(6).setCellValue(map.get("numSent").toString());
	        }
	}

}
