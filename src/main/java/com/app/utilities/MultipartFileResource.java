package com.app.utilities;

import java.io.IOException; 
import java.io.InputStream; 
 


import org.apache.commons.io.FilenameUtils;
import org.springframework.core.io.AbstractResource;
import org.springframework.web.multipart.MultipartFile; 
 

public class MultipartFileResource extends AbstractResource { 
	 
	  private final MultipartFile file;
	  private String fileName;
	 
	  public MultipartFileResource(final MultipartFile file, String fileName) { 
	    this.file = file;
	    this.fileName = fileName;
	  } 
	 
	  @Override 
	  public long contentLength() throws IOException { 
	    return this.file.getSize(); 
	  } 
	 
	  @Override 
	  public String getDescription() { 
	    return this.fileName; 
	  } 
	  
	  @Override
	  public String getFilename(){
		  String Temp = this.fileName + "." + FilenameUtils.getExtension(file.getOriginalFilename());
		return Temp ;
	  }

	 
	  @Override 
	  public InputStream getInputStream() { 
	    try { 
	      return this.file.getInputStream(); 
	    } catch (final IOException e) { 
	    }
		return null; 
	  } 
	}