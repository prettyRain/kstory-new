package com.ningpai.util;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

/**
 * Created by guoguangnan on 2015/9/15.
 */
public class MSMSendUtil {

    /**
     * 日志
     * */
    public static final MyLogger LOGGER = new MyLogger(MSMSendUtil.class);

    /**
     * 无参构造
     * */
    private MSMSendUtil() {
    }

    /**
     * zyer send
     * 
     * @return
     * @throws IOException
     */
    public static boolean sendMsm(String userId, String loginName, String password, String[] mobiles, String content, String expSmsId, String httpUrl) throws IOException {
        StringBuilder sub = new StringBuilder();
        BufferedReader br;
        URL url;
        HttpURLConnection con;
        String line;
        try {
            String bBstring = "";
            String bQstring = "";
            if (expSmsId != null) {
                String[] baob = expSmsId.split("\\|");

                if (baob.length == 2) {
                    bBstring = baob[0];
                    bQstring = baob[1];
                }
            }

            // 设置发送内容的编码方式
            String sendContent = URLEncoder.encode((bBstring + content + bQstring).replaceAll("<br/>", " "), "UTF-8");// 发送内容
            String mobile = "";
            for (int j = 0; j < mobiles.length; j++) {
                mobile += mobiles[j];
                if (j < mobiles.length - 1) {
                    mobile += ",";
                }
            }

            url = new URL(httpUrl + "?action=send&userid=&account=" + loginName + "&password=" + password + "&mobile=" + mobile + "&content=" + sendContent + "&sendTime=");
            con = (HttpURLConnection) url.openConnection();

            br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
            // br=new BufferedReader(new InputStreamReader(url.openStream()));

            while ((line = br.readLine()) != null) {
                // 追加字符串获得XML形式的字符串
                sub.append(line + "");
                // System.out.println("提取数据 :  "+line);
            }
            br.close();
            //打印日志
            LOGGER.info("------------------------------没错，发送成功了------------------------------");

        } catch (IOException e) {
            LOGGER.error("",e);
        }
        return readStringXml(sub.toString());
    }

    /**
     * ge960短信验证发送
     * zyer send
     *
     * @return
     * @throws IOException
     */
    public static boolean newSendSms(String mobile, int num) throws IOException {
        StringBuilder sub = new StringBuilder();
        BufferedReader br;
        URL url;
        HttpURLConnection con;
        String line;
        try {

            // 设置发送内容的编码方式
            String sendContent = URLEncoder.encode("尊敬的客户您好，您本次的验证码是："+num+"，打死也不要告诉别人", "UTF-8");// 发送内容
            url = new URL("http://sdk4rptws.eucp.b2m.cn:8080/sdkproxy/sendsms.action?cdkey=6SDK-EMY-6688-KFZQO&password=037355&phone=" + mobile + "&message=" + sendContent );
            con = (HttpURLConnection) url.openConnection();

            br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
            // br=new BufferedReader(new InputStreamReader(url.openStream()));

            while ((line = br.readLine()) != null) {
                // 追加字符串获得XML形式的字符串
                sub.append(line + "");
                // System.out.println("提取数据 :  "+line);
            }
            br.close();
            //打印日志
            LOGGER.info("------------------------------没错，发送成功了------------------------------");

        } catch (IOException e) {
            LOGGER.error("",e);
        }
        return geReadStringXml(sub.toString());
    }

    /**
     * ge960 短信验证发送 返回值验证
     * @param xml
     * @return
     */
    public static boolean geReadStringXml(String xml){
        Document doc;
        try{
            //document 节点
            doc = DocumentHelper.parseText(xml);
            //获取根节点
            Element rootElement = doc.getRootElement();
            String rootname = rootElement.getName();
            //获取根节点的子节点内容
            List list=rootElement.elements();
            String result=rootElement.elementText("error").trim();
            if("0".equals(result)){
                return true;
            }else{
                return  false;
            }
        }catch(Exception e){
            LOGGER.error(""+e);
            return false;
        }
    }

    /**
     *  解析xml字符串
     * */
    public static boolean readStringXml(String xml) {
        Document doc;

        try {
            // 将字符转化为XML
            doc = DocumentHelper.parseText(xml);
            // 获取根节点
            Element rootElt = doc.getRootElement();

            // 拿到根节点的名称
            // System.out.println("根节点名称："+rootElt.getName());

            // 获取根节点下的子节点的值
            String returnstatus = rootElt.elementText("returnstatus").trim();
            String message = rootElt.elementText("message").trim();

            System.out.println("返回状态为：" + returnstatus);
            System.out.println("返回信息提示：" + message);
            if ("Success".equals(returnstatus)) {
                return true;
            } else {
                return false;
            }
        } catch (DocumentException e) {
            LOGGER.error("",e);
            return false;
        }

    }

    public static void main(String[] args) {
        try {
            newSendSms("18910750246",123456);
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
