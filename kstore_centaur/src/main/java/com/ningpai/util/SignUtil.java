package com.ningpai.util;

import net.sf.json.JSONObject;

import java.security.MessageDigest;
import java.util.HashMap;
import java.util.Map;

/**
 * 生成签名sign的方法
 */
public class SignUtil {

	public static String sign(String json, String secret){
		StringBuilder enValue = new StringBuilder();
		//前后加上secret
		enValue.append(secret);
		enValue.append(json);
		enValue.append(secret);
		// 使用MD5加密(32位大写)
		byte[] bytes = encryptMD5(enValue.toString());
		return byte2hex(bytes);
	}

	private static byte[] encryptMD5(String data) {
		byte[] bytes = null;
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			bytes = md.digest(data.getBytes("UTF-8"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bytes;
	}

	private static String byte2hex(byte[] bytes) {
		StringBuilder sign = new StringBuilder();
		for (int i = 0; i < bytes.length; i++) {
			String hex = Integer.toHexString(bytes[i] & 0xFF);
			if (hex.length() == 1) {
				sign.append("0");
			}
			sign.append(hex.toUpperCase());
		}
		return sign.toString();
	}
	// url签名
	public static void main(String[] args) {
		Map map = new HashMap();
		map.put("appkey","112194");
		map.put("sessionkey","50b24306aacf479a9a5651f0fc7cabc3");
		map.put("method","gy.erp.warehouse.get");
		map.put("page_no","1");
		map.put("page_size","10");
		JSONObject json = JSONObject.fromObject(map);
		System.out.println(json.toString());
		System.out.println(sign(json.toString(), "7d3330562019420da7f3098aa630556b"));
	}


}
