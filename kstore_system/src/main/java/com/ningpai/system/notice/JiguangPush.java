package com.ningpai.system.notice;

import cn.jiguang.common.ClientConfig;
import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.device.TagListResult;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Options;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.AndroidNotification;
import cn.jpush.api.push.model.notification.IosNotification;
import cn.jpush.api.push.model.notification.Notification;
import cn.jpush.api.push.model.notification.PlatformNotification;
import com.ningpai.system.notice.bean.Notice;
import com.ningpai.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Arrays;
import java.util.List;

/**
 * 后台极光推送 使用Java SDK
 * @author dll
 * @date 2018/01/29
 */
public class JiguangPush {

    private static final Logger log = LoggerFactory.getLogger(JiguangPush.class);
    public static final String ALERT = "推送信息";
    /**
     * 正式环境：ios开发环境、ios生产环境、android生产环境
     */
//    private static String masterSecret = "e09b5ebb045bfba5c03942a6";
//    private static String appKey = "5166af561e38598af0cd5b77";
    /**
     * 测试环境
     * 目前只适用于Android手机
     */
    public static final String appKey ="22c1e98fba84870c9f122ae1";
    public static final String masterSecret = "c13c24d41d2047dfc2720628";



    /**
     * 生成极光推送对象PushPayload（采用java SDK）
     * notice 通知实体
     * @return PushPayload
     */
    public static PushPayload buildPushObject_android_ios_alias_alert(Notice notice){

        PushPayload.Builder pBuilder = PushPayload.newBuilder();
        //推送平台
        if(notice.getPlatform()  == 0){//全部
            pBuilder.setPlatform(Platform.android_ios());
        }else if(notice.getPlatform() == 1 || notice.getPlatform() == 2){//ios
            pBuilder.setPlatform(Platform.ios());
        }else if(notice.getPlatform() == 3 || notice.getPlatform() == 4){//android
            pBuilder.setPlatform(Platform.android());
        }
        //推送目标
        if(notice.getCrowdType() == 1){//广播（所有人）
            pBuilder.setAudience(Audience.all());
        }else if(notice.getCrowdType() == 2){//设置标签（Tag）
            pBuilder.setAudience(Audience.tag(notice.getTag()));
        }else if(notice.getCrowdType() == 3){//Registration ID
            String regId[] = notice.getRegistration().split(";");
            pBuilder.setAudience(Audience.registrationId(Arrays.asList(regId)));
        }
        //通知
        Notification.Builder aBuilder = Notification.newBuilder();
        if(notice.getPlatform() == 0 || notice.getPlatform() == 1 || notice.getPlatform() == 2){//ios
            IosNotification.Builder iosBuilder = IosNotification.newBuilder();
            if(StringUtils.isNotEmpty(notice.getContent())){//通知内容
                iosBuilder.setAlert(notice.getContent());
            }
            if(StringUtils.isNotEmpty(notice.getUrlType())){//跳转方式
                iosBuilder.addExtra(notice.getUrlType(),notice.getUrl().split("-")[1]);
            }
            aBuilder.addPlatformNotification(iosBuilder.build());
        }
        if(notice.getPlatform() == 0 || notice.getPlatform() == 3 || notice.getPlatform() == 4){//Android
            AndroidNotification.Builder androidBuilder = AndroidNotification.newBuilder();
            if(StringUtils.isNotEmpty(notice.getTitle())){//通知标题
                androidBuilder.setTitle(notice.getTitle());
            }
            if(StringUtils.isNotEmpty(notice.getContent())){//通知内容
                androidBuilder.setAlert(notice.getContent());
            }
            if(StringUtils.isNotEmpty(notice.getUrlType())){//跳转方式
                androidBuilder.addExtra(notice.getUrlType(),notice.getUrl().split("-")[1]);
            }
            aBuilder.addPlatformNotification(androidBuilder.build());
        }
        pBuilder.setNotification(aBuilder.build());

        //true-推送生产环境 false-推送开发环境
        Options.Builder oBuilder = Options.newBuilder();
        if(notice.getPlatform() == 1 || notice.getPlatform() == 3){
            oBuilder.setApnsProduction(false);
        }else{
            oBuilder.setApnsProduction(true);
        }
        pBuilder.setOptions(oBuilder.build());

        return pBuilder.build();
    }
    /**
     * 极光推送方法(采用java SDK)
     * @return PushResult
     */
    public static PushResult push(Notice notice){
        ClientConfig clientConfig = ClientConfig.getInstance();
        JPushClient jpushClient = new JPushClient(masterSecret, appKey, null, clientConfig);
        PushPayload payload = buildPushObject_android_ios_alias_alert(notice);
        try {
            PushResult result = jpushClient.sendPush(payload);
            System.out.println("Got result - " + result);
            return result;
        } catch (APIConnectionException e) {
            log.error("Connection error. Should retry later. ", e);
        } catch (APIRequestException e) {
            log.error("Error response from JPush server. Should review and fix it. ", e);
            log.info("HTTP Status: " + e.getStatus());
            log.info("Error Code: " + e.getErrorCode());
            log.info("Error Message: " + e.getErrorMessage());
            log.info("Msg ID: " + e.getMsgId());
        }
        return null;
    }

    /**
     * 获取推送用户标签
     * @return
     */
    public static List<String> getPushTags(){
        ClientConfig clientConfig = ClientConfig.getInstance();
        JPushClient jpushClient = new JPushClient(masterSecret, appKey, null, clientConfig);
        try {
            TagListResult tagListResult = jpushClient.getTagList();
            return tagListResult.tags;
        } catch (APIConnectionException e) {
            e.printStackTrace();
        } catch (APIRequestException e) {
            e.printStackTrace();
        }
        return null;
    }
}
