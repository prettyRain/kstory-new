/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.other.util;



import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * 获取Ip地址
 * 
 * @author NINGPAI-zhangqiang
 * @since 2013年12月26日 上午11:49:37
 * @version 1.0
 */
public final class IPAddress {

    private IPAddress() {

    }

    /**
     * 获取IP地址
     * 
     * @param request
     * @return ip
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Real-IP");
        if (ip == null || ip.length() == 0 || CustomerConstantStr.UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("x-forwarded-for");
        }
        if (ip == null || ip.length() == 0 || CustomerConstantStr.UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || CustomerConstantStr.UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || CustomerConstantStr.UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
            if(ip.equals("127.0.0.1") || ip.equals("0:0:0:0:0:0:0:1")){
                //根据网卡取本机配置的IP
                InetAddress inet=null;
                try {
                    inet = InetAddress.getLocalHost();
                } catch (UnknownHostException e) {
                    e.printStackTrace();
                }
                ip= inet.getHostAddress();
            }
        }
        if (ip == null || ip.length() == 0 || CustomerConstantStr.UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("http_client_ip");
        }
        if (ip == null || ip.length() == 0 || CustomerConstantStr.UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        // 如果是多级代理，那么取第一个ip为客户ip
        if (ip != null && ip.indexOf(",") != -1) {
            ip = ip.substring(ip.lastIndexOf(",") + 1, ip.length()).trim();
        }
        return ip;
    }
    public  static String getIpAddrTwo(HttpServletRequest request) {
                   String ip = request.getHeader("X-Forwarded-For");
                   if(StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)){
                           //多次反向代理后会有多个ip值，第一个ip才是真实ip
                       int index = ip.indexOf(",");
                       if(index != -1){
                                   return ip.substring(0,index);
                               }else{
                           return ip;
                                }
                        }
                    ip = request.getHeader("X-Real-IP");
                    if(StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)){
                            return ip;
                        }
                    return request.getRemoteAddr();
                }
}
