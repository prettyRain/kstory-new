package com.ningpai.util;

import com.google.gson.Gson;
import net.sf.json.JSONObject;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.junit.Test;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/30 0030.
 */
public class TestUtil {

    @Test
    public void testUtilGY(){
        String url = "http://v2.api.guanyierp.com/rest/erp_open";
        String appkey = "112194";
        String sessionkey = "50b24306aacf479a9a5651f0fc7cabc3";
        String secret = "7d3330562019420da7f3098aa630556b";
        String method = "gy.erp.warehouse.get";
        Map map = new HashMap();
        map.put("appkey",appkey);
        map.put("sessionkey",sessionkey);
        map.put("method",method);
        map.put("page_no","1");
        map.put("page_size","10");
        JSONObject json = JSONObject.fromObject(map);
        System.out.println(json.toString());
        String sign = SignUtil.sign(json.toString(),secret);
        map.put("sign",sign);
        System.out.println(JSONObject.fromObject(map).toString());
        String result = HttpMethodUtil.getResult(url, JSONObject.fromObject(map).toString());
        System.out.println(result);
    }

    @Test
    public void testUtilDST(){
        Map map = new HashMap();
        String url = "https://sjt.yonyoucloud.com/servlet/BaseHttpServlet";
        Map params = new HashMap();
        params.put("plat","dst");
        params.put("access","1");
        params.put("session","a803957c84cf4d9094c605ed4ac637c5");
        params.put("method","dstGoodsBatchget");
        //request
        Map request = new HashMap();
        request.put("startTime","2018-04-01 09:31:00");
        request.put("endTime","2018-04-11 09:31:00");
        request.put("erpOrgId","s20180404882");
        request.put("productType","0");
        params.put("request",request);
        String result = HttpMethodUtil.getDSTResult(url, new Gson().toJson(params), "");

    }
}
