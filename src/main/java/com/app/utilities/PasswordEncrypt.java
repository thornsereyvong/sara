package com.app.utilities;

import org.apache.commons.codec.binary.Base64;
public class PasswordEncrypt {
	
	private String key1 = "Bal123_!@#ancika";
	private String key2 = "akicna#@!_321laB";	
	public String BalEncrypt(String str){
		Base64 b = new Base64(); 
		str = iSubStr(byteToString(b.encode(key1.getBytes())))+""+byteToString(b.encode(str.getBytes()))+""+iSubStr(byteToString(b.encode(key2.getBytes())));		
		str = byteToString(b.encode(str.getBytes()));		
		return str;
	}	
	public String BalDecrypt(String str){
		Base64 b = new Base64(); 
		str = byteToString(b.decode(str.getBytes()));		
		str = str.replace(iSubStr(byteToString(b.encode(key1.getBytes()))), "");				
		str = str.replace(iSubStr(byteToString(b.encode(key2.getBytes()))), "");
		str = byteToString(b.decode(str.getBytes()));
		return str;
	}		
	public String byteToString(byte[] b){
		return new String(b);
	}
	public String iSubStr(String str){		
		return str.substring(5, 10);
	}
}
