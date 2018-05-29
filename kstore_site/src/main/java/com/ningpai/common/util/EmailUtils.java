package com.ningpai.common.util;

import com.ningpai.common.bean.EmailServer;
import com.ningpai.common.dao.EmailServerMapper;
import com.ningpai.customer.bean.Giftcard;
import com.ningpai.customer.util.GiftcardUtil;
import com.ningpai.info.dao.MessageSendMapper;
import com.ningpai.site.customer.vo.CustomerAllInfo;
import com.ningpai.util.MyLogger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 邮件发送工具类
 *
 * @author NINGPAI-LiHaoZe
 * @since 2014年1月13日 下午5:08:11
 * @version 1.0
 */
@Service("emailUtilsSite")
public class EmailUtils {

    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(EmailUtils.class);

    private static final String PEX_HREF = "<a href='";
    private static final String USERNAME = "-name";
    private static final String URL = "-url";

    /**
     * 消息设置DAO接口
     */
    @Resource(name = "MessageSendMapper")
    public MessageSendMapper messageSendMapper;

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
     * 账户中心 验证邮件
     *
     * @param request
     * @param user
     * @return
     */
    public int sendBindEmail(HttpServletRequest request, CustomerAllInfo user) {
        // 根据id查询Subject字段
        String subject = messageSendMapper.findSubjectMapper(13);
        try {
            // 获得客户端发送请求的完整url
            String url = request.getRequestURL().toString();
            // 截取字符串
            url = url.substring(0, url.lastIndexOf("/"));
            url = url.substring(0, url.lastIndexOf("/"));
            // 生成账户激活链接
            String str = GenerateLinkUtils.generateActivateLink(request, user);
            // 根据id查询Text字段
            String a = messageSendMapper.findTextMapper(13);
            // 定义链接标签
            String href = PEX_HREF + str + "'style='font:14px tahoma,arial,\5b8b\4f53;color:#005aa0;line-height:180%;text-decoration:none;'>邮箱验证链接</a>";
            // 替换text文本
            String f1 = a.replace(USERNAME, user.getCustomerUsername());
            String f2 = f1.replace(URL, href);
            // 发送短信
            TransportUtil.sendMessage(user.getInfoEmail(), f2, subject, request);
            return 1;
        } catch (Exception e) {
            LOGGER.info(e);
            return 0;
        }
    }

    /**
     * 忘记密码： 验证邮件
     *
     * @param request
     * @param user
     * @return
     */
    public int forgetsendBindEmail(HttpServletRequest request, CustomerAllInfo user) {
        // 根据id查询Subject字段
        String subject = messageSendMapper.findSubjectMapper(3);
        try {
            // 获得客户端发送请求的完整url
            String url = request.getRequestURL().toString();
            // 截取字符串
            url = url.substring(0, url.lastIndexOf("/"));
            url = url.substring(0, url.lastIndexOf("/"));
            // 生成账户激活链接
            String str = GenerateLinkUtils.forgetgenerateActivateLink(request, user);
            // 根据id查询Text字段
            String a = messageSendMapper.findTextMapper(3);
            // 定义链接标签
            String href = PEX_HREF + str + "'style='font:14px tahoma,arial,\5b8b\4f53;color:#005aa0;line-height:180%;text-decoration:none;'>立即重设</a>";
            // 替换text文本
            String f1 = a.replace(USERNAME, user.getCustomerUsername());
            String f2 = f1.replace(URL, href);
            // 发送短信
            TransportUtil.sendMessage(user.getInfoEmail(), f2, subject, request);
            return 1;
        } catch (Exception e) {
            LOGGER.info(e);
            return 0;
        }
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
            String HTMLTAG = "<div style=\"margin:0 auto;width:590px;\">\n" +
                    "<p><img src=\"http://boss.ge960.com/upload/20170906/email_logo.png\"/></p>\n" +
                    "<p><img src=\"http://boss.ge960.com/upload/20170906/email_greyline.png\"/></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">尊敬的客户您好！</span></span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">很高兴您在中国</span>960官方商城（ge960.com）购物！</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">您订购的商品</span>—心意卡面额1000元是礼品卡电子版，现将卡号和密码发送至您个人邮箱，请确认后注意保存，以防丢失。</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">您的心意卡号和密码如下：</span></span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\">&nbsp;</span></p>";
            for(Giftcard gc:giftcard){
                //HTMLTAG+= "<p style='font:14px tahoma,arial,\5b8b\4f53;color:#555;margin:0;padding:0;line-height:180%;'>卡号："+gc.getGiftcardNo()+"，密码："+ GiftcardUtil.decodePwd(gc.getGiftcardPwd(),"Ge960") +"</p>";
                HTMLTAG+= "<p><span style=\"background-color: rgb(191, 191, 191);\"><strong><span style=\"background-color: rgb(191, 191, 191); font-size: 14px; font-family: 微软雅黑;\">卡号："+gc.getGiftcardNo()+"</span></strong></span><strong> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style=\"background-color: rgb(191, 191, 191);\"><span style=\"background-color: rgb(191, 191, 191); font-family: 微软雅黑; font-size: 14px;\">密码："+ GiftcardUtil.decodePwd(gc.getGiftcardPwd(),"Ge960") +"</span></span></strong></p>";
            }
            HTMLTAG += "<p><span style=\";font-family:Calibri;font-size:14px\">&nbsp;</span></p>\n" +
                    "<p><span style=\";font-family:Calibri;font-size:14px\"><img src=\"http://boss.ge960.com/upload/20170906/email_card.png\"/>&nbsp;</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">查看订单消息请进入中国</span>960官方商城（ge960.com）个人中心查询&gt;</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\">&nbsp;</span></p>\n" +
                    "<p><strong><span style=\"font-family: 微软雅黑;font-size: 14px\"><span style=\"font-family:微软雅黑\">如何使用您的礼品卡</span> </span></strong></p>\n" +
                    "<p><span style=\"font-family:微软雅黑;font-size:14px\">1.&nbsp;</span><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">登陆</span></span><a href=\"http://www.ge960.com\"><span style=\"text-decoration:underline;\"><span style=\"font-family: 微软雅黑;color: rgb(5, 99, 193)\">www.ge960.com</span></span></a><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">，新用户需要注册会员账号。</span></span></p>\n" +
                    "<p><span style=\"font-family:微软雅黑;font-size:14px\">2.&nbsp;</span><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">进入电脑端商城个人中心，找到</span>[我的礼品卡]完成本卡与账号的绑定。</span></p>\n" +
                    "<p><span style=\"font-family:微软雅黑;font-size:14px\">3.&nbsp;</span><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">在商城下单后，进入支付页面选择使用。</span></span></p>\n" +
                    "<p><span style=\"font-family:微软雅黑;font-size:14px\">4.&nbsp;</span><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">本卡余额不足时，可继续为绑定账号充值。</span></span></p>\n" +
                    "<p><span style=\"font-family:微软雅黑;font-size:14px\">5.&nbsp;</span><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">更多帮助请您登陆商城了解详情，具体使用规则以网站公布为准。</span></span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\">&nbsp;</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">本卡为不记名卡，不记名、不挂失、不计息、不兑换现金。</span></span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">卡在激活后使用有效期为三年，如成功绑定</span>960商城会员账号方不计有效期。</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\">&nbsp;</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">更多礼品卡使用帮助信息，请访问</span></span><a href=\"http://www.ge960.com\"><span style=\"text-decoration:underline;\"><span style=\"font-family: 微软雅黑;color: rgb(5, 99, 193)\">www.ge960.com</span></span></a><strong><span style=\"font-family: 微软雅黑;font-size: 14px\"><span style=\"font-family:微软雅黑\">帮助中心</span></span></strong><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">。</span></span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\">&nbsp;</span></p>\n" +
                    "<p><strong><span style=\"font-family: 微软雅黑;font-size: 14px\"><span style=\"font-family:微软雅黑\">重要说明：</span></span></strong></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\">960礼品卡只能用于在960官方商城（http://www.ge960.com）购买商品，不得用于其它任何网站、机构购买商品。960礼品卡不得用于购买其他礼品卡。960礼品卡可以重新充值，但不能被再次销售、转移余额，也不能用于兑换现金或应用于其它帐户。960官方商城不对礼品卡的丢失、被窃、损毁或未经授权使用负责。960礼品卡自开通之日起、有效期限为三年，可在有效期内多次使用。如果您要查看礼品卡中的余额情况，请登录中国960官方商城，查看</span><strong><span style=\"font-family: 微软雅黑;font-size: 14px\">[我的960]</span></strong><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">下</span></span><strong><span style=\"font-family: 微软雅黑;font-size: 14px\">[我的礼品卡]</span></strong><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">中的信息。欢迎登陆中国</span>960官方商城并查询其他有关礼品卡的政策和信息。</span></p>\n" +
                    "<p><strong><span style=\"font-family: 微软雅黑;font-size: 14px\"><span style=\"font-family:微软雅黑\">账户安全提醒：</span></span></strong></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">互联网账号存在被盗风险，为了保障您的账号及资金安全，中国</span>960官方商城提醒您访问个中心—账户中心—账户安全，尽快启用所有安全服务。</span></p>\n" +
                    "<p><span style=\";font-family:Calibri;font-size:14px\">&nbsp;</span></p>\n" +
                    "<p><span style=\";font-family:Calibri;font-size:14px\"><img src=\"http://boss.ge960.com/upload/20170906/email_code.jpg\"/>&nbsp;</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">如果您有任何疑问或建议，请联系我们客服电话</span>400-808-8880周一至周日 8：00-20：00。</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><span style=\"font-family:微软雅黑\">中国</span>960官方商城（ge960.com）是可溯源的安全食品、饮品类电子商务服务平台，全部商品品质有保证！</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\">&nbsp;</span></p>\n" +
                    "<p><span style=\";font-family:微软雅黑;font-size:14px\"><img src=\"http://boss.ge960.com/upload/20170906/email_alert.png\"/>&nbsp;<span style=\"font-family:微软雅黑\">重要提醒：任何交易和退款只能在中国</span>960商城官方网站或者APP中完成，谨防假借订单异常，或被设置为经销商为由的电话诈骗！</span></p>\n" +
                    "<p><span style=\";font-family:Calibri;font-size:14px\">&nbsp;</span></p>\n" +
                    "<p><img src=\"http://boss.ge960.com/upload/20170906/email_bottom.jpg\"/></p>\n" +
                    "</div>";
            // 发送短信
            TransportUtil.sendMessage(infoEmail, HTMLTAG,"尊敬的客户！订购的中国960官方商城礼品卡—心意卡电子版已发送到您的邮箱！", request);
            return 1;
        } catch (Exception e) {
            LOGGER.error(""+e);
            return 0;
        }
    }

    /**
     * 找回密码 验证邮件
     *
     * @param request
     * @param user
     * @return
     */
    public int sendFindPwdEmail(HttpServletRequest request, CustomerAllInfo user) {
        // 根据id查询Subject字段
        String subject = messageSendMapper.findSubjectMapper(3);
        try {
            // 获得客户端发送请求的完整url
            String url = request.getRequestURL().toString();
            // 截取字符串
            url = url.substring(0, url.lastIndexOf("/"));
            url = url.substring(0, url.lastIndexOf("/"));
            // 生成账户激活链接
            String str = GenerateLinkUtils.generateFindPwdLink(request, user);
            // 根据id查询Text字段
            String a = messageSendMapper.findTextMapper(3);
            // 定义链接标签
            String href = PEX_HREF + str + "'style='font:14px tahoma,arial,\5b8b\4f53;color:#005aa0;line-height:180%;text-decoration:none;'>找回密码验证链接</a>";
            // 替换text文本
            String f1 = a.replace(USERNAME, user.getCustomerUsername());
            String f2 = f1.replace(URL, href);
            // 发送短信
            TransportUtil.sendMessage(user.getInfoEmail(), f2, subject, request);
            return 1;
        } catch (Exception e) {
            LOGGER.info(e);
            return 0;
        }
    }

    /**
     * 安全中心 验证邮件
     *
     * @param request
     * @param user
     * @return
     */
    public int sendCheckIdEmail(HttpServletRequest request, CustomerAllInfo user) {
        // 根据id查询Subject字段
        String subject = messageSendMapper.findSubjectMapper(11);
        String str = null;
        try {
            // 生成找回密码链接
            str = GenerateLinkUtils.generateCheckEmailLink(request, user);
        } catch (Exception e) {
            LOGGER.error("验证邮箱出错！" + e);
            str = null;
        }
        // 返回地址
        String url = request.getRequestURL().toString();
        // 截取字符串
        url = url.substring(0, url.lastIndexOf("/"));
        url = url.substring(0, url.lastIndexOf("/"));
        // 根据id查询Text字段
        String a = messageSendMapper.findTextMapper(11);
        // 定义链接标签
        String href = PEX_HREF + str + "'style='font:14px tahoma,arial,\5b8b\4f53;color:#005aa0;line-height:180%;text-decoration:none;'>安全中心验证链接</a>";
        // 替换text文本
        String f1 = a.replace(USERNAME, user.getCustomerUsername());
        String f2 = f1.replace(URL, href);
        try {
            // 发送短信
            TransportUtil.sendMessage(user.getInfoEmail(), f2, subject, request);
        } catch (MessagingException e) {
            LOGGER.error("验证邮箱出错！" + e);
            return 0;
        }
        return 1;
    }

    /**
     * 获取session
     */
    public void getSession() {

        // 读取数据库数据
        emailServer = emailServerMapper.selectEmailServer();

    }

}
