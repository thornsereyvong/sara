package com.app.entities;

import org.springframework.web.multipart.MultipartFile;

public class FileUpload {
	private MultipartFile fileUplaod;

	/**
	 * @return the fileUplaod
	 */
	public MultipartFile getFileUplaod() {
		return fileUplaod;
	}

	/**
	 * @param fileUplaod the fileUplaod to set
	 */
	public void setFileUplaod(MultipartFile fileUplaod) {
		this.fileUplaod = fileUplaod;
	}
}
