package com.ningpai.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.green.model.v20170112.ImageSyncScanRequest;
import com.aliyuncs.http.FormatType;
import com.aliyuncs.http.HttpResponse;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;

import java.util.*;

/**
 * 阿里绿网：同步图片风险检测，同步允许的最长检测时间是6秒
 * 图片链接协议支持：http和https
   图片格式支持: PNG,JPG,JPEG,BMP,GIF
   同步调用时图片大小限制为5M，异步调用时图片大小限制为20M，下载时间3s内;
   图片像素建议不小于256*256，太小可能会影响识别效果
 * Created by dll on 2017/6/1.
 */
public class AliSyncImageFilter {

    public static void main(String[] args) {
        System.out.println(AliSyncImageFilter.checkImage("http://www.ge960.com/upload/20170523/1495532863377.jpg"));
    }


    /**
     * 验证图片是否可用
     * @param imgUrl 需要验证的图片地址
     * @return [“pass”, “review”, “block”], pass：图片正常，review：需要人工审核，block：图片违规，可以直接删除或者做限制处理
     */
    public static String checkImage(String imgUrl){
        try {
            //请替换成你自己的accessKeyId、accessKeySecret
            IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAIGhvv31QYw4jF", "UOqKZwYq9oh11CpzJop0lEEpGDGgEM");
            DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", "Green", "green.cn-hangzhou.aliyuncs.com");
            IAcsClient client = new DefaultAcsClient(profile);
            ImageSyncScanRequest imageSyncScanRequest = new ImageSyncScanRequest();
            imageSyncScanRequest.setAcceptFormat(FormatType.JSON); // 指定api返回格式
            imageSyncScanRequest.setContentType(FormatType.JSON);
            imageSyncScanRequest.setMethod(com.aliyuncs.http.MethodType.POST); // 指定请求方法
            imageSyncScanRequest.setEncoding("utf-8");
            imageSyncScanRequest.setRegionId("cn-hangzhou");
            List<Map<String, Object>> tasks = new ArrayList<Map<String, Object>>();
            Map<String, Object> task = new LinkedHashMap<String, Object>();
            task.put("dataId", UUID.randomUUID().toString());
            task.put("url", imgUrl);
            task.put("time", new Date());
            tasks.add(task);
            JSONObject data = new JSONObject();
            /**
             * porn: 色情
             * terrorism: 暴恐
             * qrcode: 二维码
             * ad: 图片广告
             * ocr: 文字识别
             */
            data.put("scenes", Arrays.asList("porn"));
            data.put("tasks", tasks);
            imageSyncScanRequest.setContent(data.toJSONString().getBytes("UTF-8"), "UTF-8", FormatType.JSON);
            /**
             * 请务必设置超时时间
             */
            imageSyncScanRequest.setConnectTimeout(3000);
            imageSyncScanRequest.setReadTimeout(6000);
            HttpResponse httpResponse = client.doAction(imageSyncScanRequest);
            if (httpResponse.isSuccess()) {
                JSONObject scrResponse = JSON.parseObject(new String(httpResponse.getContent(), "UTF-8"));
                System.out.println(JSON.toJSONString(scrResponse, true));
                if (200 == scrResponse.getInteger("code")) {
                    JSONArray taskResults = scrResponse.getJSONArray("data");
                    for (Object taskResult : taskResults) {
                        if (200 == ((JSONObject) taskResult).getInteger("code")) {
                            JSONArray sceneResults = ((JSONObject) taskResult).getJSONArray("results");
                            for (Object sceneResult : sceneResults) {
                                String scene = ((JSONObject) sceneResult).getString("scene");
                                String suggestion = ((JSONObject) sceneResult).getString("suggestion");
                                //根据scene和suggetion做相关的处理
                                //do something
                                //System.out.println("args = [" + scene + "]");
                                //System.out.println("args = [" + suggestion + "]");
                                return suggestion;
                            }
                        } else {
                            System.out.println("task process fail:" + ((JSONObject) taskResult).getInteger("code"));
                        }
                    }
                } else {
                    System.out.println("detect not success. code:" + scrResponse.getInteger("code"));
                }
            } else {
                System.out.println("response not success. status:" + httpResponse.getStatus());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
