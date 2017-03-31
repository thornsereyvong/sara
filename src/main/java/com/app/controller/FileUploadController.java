package com.app.controller;

import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.app.utilities.MultipartFileResource;

@RestController
public class FileUploadController {
	
	@Autowired	
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/upload/{srcFolder}",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> upload(@RequestParam(value = "file", required = false) MultipartFile file,@PathVariable("srcFolder") String srcFolder){
		System.out.println("CALL");
		LinkedMultiValueMap<String, Object> multipartMap = new LinkedMultiValueMap<String, Object>();
		multipartMap.add("file", new MultipartFileResource(file, FilenameUtils.removeExtension(file.getOriginalFilename())));
		header.setContentType(MediaType.MULTIPART_FORM_DATA);
		HttpEntity<Object> request = new HttpEntity<Object>(multipartMap,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/upload/"+srcFolder, HttpMethod.POST, request, Map.class);
		header.remove(HttpHeaders.CONTENT_TYPE);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	/*@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/upload/{srcFolder}",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> uploadAttachment(@RequestParam(value = "file", required = false) MultipartFile file, @PathVariable("srcFolder") String srcFolder){
		LinkedMultiValueMap<String, Object> multipartMap = new LinkedMultiValueMap<String, Object>();
		multipartMap.add("file", new MultipartFileResource(file, file.getOriginalFilename()));
		header.setContentType(MediaType.MULTIPART_FORM_DATA);
		HttpEntity<Object> request = new HttpEntity<Object>(multipartMap,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/upload/attachment/"+srcFolder, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}*/
}
