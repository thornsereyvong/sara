package com.app.utilities;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ConvertStringToLocalDateTime {

	public LocalDateTime convertStringToLocalDateTime(String date) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/MM/yyyy h:mm a");
		LocalDateTime localDateTime = LocalDateTime.parse(date, formatter);
		return localDateTime;
	}
}
