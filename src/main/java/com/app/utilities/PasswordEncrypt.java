package com.app.utilities;

import java.math.BigInteger;
import java.security.SecureRandom;


public class PasswordEncrypt {
	
	private String key1 = "Bal123_!@#ancika";
	private String key2 = "akicna#@!_321laB";	
	private SecureRandom random = new SecureRandom();
	public String BalEncrypt(String str){
		org.apache.commons.codec.binary.Base64 b = new org.apache.commons.codec.binary.Base64(); 
		str = iSubStr(byteToString(b.encode(key1.getBytes())))+""+byteToString(b.encode(str.getBytes()))+""+iSubStr(byteToString(b.encode(key2.getBytes())));		
		str = byteToString(b.encode(str.getBytes()));		
		return str;
	}	
	public String BalDecrypt(String str){
		org.apache.commons.codec.binary.Base64 b = new org.apache.commons.codec.binary.Base64(); 
		str = byteToString(b.decode(str.getBytes()));		
		str = str.replace(str.substring(0, 5), "");				
		str = str.replace(str.substring(str.length()-5), "");
		str = byteToString(b.decode(str.getBytes()));
		return str;
	}		
	public String byteToString(byte[] b){
		return new String(b);
	}
	public String iSubStr(String str){	
		str = nextSessionId();
		return str.substring(5, 10);
	}
	public String nextSessionId() {
		return (new BigInteger(130, random).toString(32));
	}
}
