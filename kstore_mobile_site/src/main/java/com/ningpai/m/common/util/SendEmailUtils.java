package com.ningpai.m.common.util;

import com.ningpai.customer.bean.Giftcard;
import com.ningpai.customer.util.GiftcardUtil;
import com.ningpai.m.common.bean.EmailServer;
import com.ningpai.m.common.dao.EmailServerMapper;
import com.ningpai.util.MyLogger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

/**
 * 邮件发送工具类
 * 
 * @author NINGPAI-LiHaoZe
 * @since 2014年1月13日 下午5:08:11
 * @version 1.0
 */
@Service("sendEmailUtils")
public class SendEmailUtils {

    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(SendEmailUtils.class);

    private static EmailServer emailServer;

    /**
     * 查询邮箱服务器信息
     */
    private EmailServerMapper emailServerMapper;

    public EmailServerMapper getEmailServerMapper() {
        return emailServerMapper;
    }

    @Resource(name = "emailServerMapperSite")
    public void setEmailServerMapper(EmailServerMapper emailServerMapper) {
        this.emailServerMapper = emailServerMapper;
    }

    /**
     * 发送电子礼品卡卡号及密码
     *
     * @param request
     * @param infoEmail
     * @return
     */
    public int sendGiftCardEmails(HttpServletRequest request, String infoEmail, List<Giftcard> giftcard) {
        try {
            // 获得客户端发送请求的完整url
            String HTMLTAG = "<p>尊敬的960用户，您好:</h1><p style='font:14px tahoma,arial,\5b8b\4f53;color:#555;margin:0;padding:0;line-height:180%;'>您购买的电子礼品卡账户如下：</p>";
            if(giftcard != null){
                for(Giftcard gc:giftcard){
                    HTMLTAG+= "<p style='font:14px tahoma,arial,\5b8b\4f53;color:#555;margin:0;padding:0;line-height:180%;'>卡号："+gc.getGiftcardNo()+"，密码："+ GiftcardUtil.decodePwd(gc.getGiftcardPwd(),"Ge960") +"</p>";
                }
            }
            HTMLTAG += "<p style='font:14px tahoma,arial,\5b8b\4f53;color:#555;margin:0;padding:0;line-height:180%;'><br/>如有任何疑问，请拔打热线：400-808-8880</p>";
            sendMessage(infoEmail, HTMLTAG,"960电子礼品卡", request);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            LOGGER.error(""+e);
            return 0;
        }
    }



    /**
     * 获取session
     */
    public void getSession() {

        // 读取数据库数据
        emailServer = emailServerMapper.selectEmailServer();

    }

    /**
     * 发送短信
     *
     * @param title
     *            标题
     * @param infoEmail
     *            发送邮件地址
     * @param content
     *            邮件正文
     * @throws MessagingException
     */
    public void sendMessage(String infoEmail, String content, String title, HttpServletRequest request) throws MessagingException {
        // 创建属性
        // 读取数据库数据
        emailServer = emailServerMapper.selectEmailServer();
        Properties props = new Properties();
        props.setProperty("mail.transport.protocol", "smtp");
        props.setProperty("mail.smtp.host", emailServer.getSmtpserver());
        props.setProperty("mail.smtp.port", emailServer.getSmtpport());
        props.setProperty("mail.smtp.auth", "true");
        // 新添加的
        props.put("mail.smtp.socketFactory.fallback", "true");
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(emailServer.getSmtpaccount(), emailServer.getSmtppass());
            }

        });
        session.setDebug(true);
        MimeMessage message = new MimeMessage(session);
        // 设置发送标题
        message.setSubject(title);
        message.setSentDate(new Date());
        // 设置SMTP账号
        message.setFrom(new InternetAddress(getSenderName(emailServer.getSendname())+ "<"+emailServer.getSmtpaccount()+">"));
        // 发送对象的地址
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(infoEmail));
        // 设置发送类容
        message.setContent(content, "text/html;charset=utf-8");
        // 邮件发送
        Transport.send(message);
        // 只发送5次验证邮件给验证方
        /*if (emp < 5) {
            try {
                EmailCheck(message, content, request);
            } catch (UnknownHostException e) {
                LOGGER.error("验证邮件发送错误,邮件标题为" + infoEmail + ":" + e);
            }
            emp += 1;
        }*/
    }


    /**
     * 获得发件人 姓名
     * @param name
     * @return
     */
    private static String getSenderName(String name) {
        // 设置自定义发件人昵称
        String nick = "";
        try {
            nick = javax.mail.internet.MimeUtility.encodeText(name);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return nick;
    }

}
