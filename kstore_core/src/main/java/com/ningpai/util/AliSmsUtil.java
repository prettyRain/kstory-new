package com.ningpai.util;

import com.taobao.api.DefaultTaobaoClient;

import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
import net.sf.json.JSONObject;

/**
 * 阿里大于发送短信
 * 官方api文档
 * https://api.alidayu.com/doc2/apiDetail?spm=a3142.7629140.1999205496.20.V99ag7&apiId=25450
 * @author dl
 * 2017/4/27.
 */
public class AliSmsUtil {

    public static String EXTEND="123456";//公共回传参数
    public static String SMS_TYPE="normal";//短信类型
    public static String APP_KEY = "23741135";//App Key
    public static String APP_SECRET = "cd1e3b6602b26135b20354a6fc2f2349";  //app安全码
    public static String SERVER_URL = " http://gw.api.taobao.com/router/rest"; //正式环境

    //短信模板名称
    public enum smsTemplate{
        //验证码模板
        //弃用 现使用通用模板
        /**LOGIN_CONFIRM("SMS_15480126"),//登录确认验证码
        REGISTRY("SMS_15480124"),//用户注册验证码
        CHANGE_PASSWORD("SMS_15480122"),//修改密码验证码
        ACCOUNT_AUTH("SMS_15480128"),//身份验证验证码
        INFO_CHANGE("SMS_15480121"),//信息变更验证码
        ACTIVITY_CONFIRM("SMS_15480123"),//活动确认验证码
        LOGIN_ABNORMAL("SMS_15480125"),//登录异常验证码
        REFUND_PASSWORD("SMS_63900753"),//找回密码
        CHANGE_PHONE("SMS_63935762");//更改手机号*/
        COMMON_TEMP("SMS_66790179"),//通用验证码模板
        //通知模板
        TO_GOODS("SMS_67150264"),//商品到货通知
        DROP_PRICE("SMS_67180300");//商品降价通知
        private String content;
        smsTemplate(String content){
            this.content = content;
        }
        public String getContent(){
            return this.content;
        }
    }

    //短信签名
    /**public enum smsSign{
        LOGIN_CONFIRM("登录验证"),
        REGISTRY("注册验证"),
        CHANGE_PHONE("身份验证"),
        INFO_CHANGE("变更验证"),
        ACTIVITY_CONFIRM("活动验证"),
        private String content;
        smsSign(String content){this.content = content;}
        public String getContent(){return this.content;}
    }*/


    /**
     * 发送短信
     * @param code 验证码
     * @param phone 手机号
     * @return
     */
    public static boolean send(int code, String phone,String template, String content){
        //获得第三方阿里云短信通知接口
        TaobaoClient client = new DefaultTaobaoClient(SERVER_URL, APP_KEY, APP_SECRET);
        //获得短信通知请求头
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend(EXTEND);
        //短信通知类型
        req.setSmsType(SMS_TYPE);
        //短信通知签名
        req.setSmsFreeSignName("960官方商城");
        //短信模板变量
        if(content == null){
            req.setSmsParamString("{\"code\":\""+ code +"\",\"product\":\"\"}");
        }else{
            req.setSmsParamString("{\"product\":\""+ content +"\"}");
        }
        //短信接收号码:传入号码为11位手机号码不能加0或+86,最多传入200个号码,多个号码以逗号分隔
        //示例：18600000000,13911111111,13322222222
        req.setRecNum(phone);
        //短信模板ID
        req.setSmsTemplateCode(template);
        try {
            //发送短信
            AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
            //接受返回的json数据判断短信是否发送成功
            JSONObject json = JSONObject.fromObject(rsp.getBody());
            String jsonStr = json.getString("alibaba_aliqin_fc_sms_num_send_response");
            if (jsonStr!=null&&!jsonStr.isEmpty() ) {
                json = JSONObject.fromObject(jsonStr);
                String result = json.getString("result");
                if (result!=null && !result.isEmpty()) {
                    json = JSONObject.fromObject(result);
                    System.out.println("json:"+json);
                    String errorCode = json.getString("err_code");
                    if ("0".equals(errorCode)) {
                        //发送成功
                        System.out.println("------------ 短信发送成功，验证码为："+ code +" ---------------");
                        return true;
                    } else {
                        //发送失败
                        return false;
                    }
                }
            }
            //发送失败
            return false;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        System.out.println(send(123,"18519518406",smsTemplate.COMMON_TEMP.getContent(),null));
    }
}