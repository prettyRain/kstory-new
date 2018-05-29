package com.ningpai.site.order.util;

/**
 * 微信扫码支付配置
 * Created by dll on 2017/6/20.
 */
public class WeixinPayConfigUtil {

    //微信开发应用id
    public static String APP_ID = "wxc3d05e27929ba2a5";
    //对应凭证
    public static String APP_SECRET = "9243c2791f41dea84a40b69232d26ee3";
    //商户号
    public static String MCH_ID = "1311744701";
    //api密钥
    public static String API_KEY = "RMYmfYWuw26dNYyFhnuHGcKJOvjjKpfY";
    //接口链接
    public static String UFDODER_URL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
    //回调通知地址
    public static String NOTIFY_URL = "http://testsite.ge960.com/weixin_notify.htm";
}
