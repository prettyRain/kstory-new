package com.ningpai.util;

import com.ningpai.common.util.DateUtil;
import com.ningpai.system.estore.bean.EStore;
import com.ningpai.system.estore.service.EStoreService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.util.*;

/**
 * 封装管易云
 */
@Controller
public class ERPUtil {
    /**
     * 静态service
     */
    private static EStoreService estoreService;
    /**
     * service
     */
    private EStoreService estoreServiceNext;

    /**
     * 初始化
     */
    @PostConstruct
    public void init() {
        estoreService = this.estoreServiceNext;
    }

    public EStoreService getEstoreServiceNext() {
        return estoreServiceNext;
    }

    @Resource(name = "estoreService")
    public void setEstoreServiceNext(EStoreService estoreServiceNext) {
        this.estoreServiceNext = estoreServiceNext;
    }

    /**
     * 将接口应用级参数及调用方法放入TreeMap，调用接口得到数据
     *
     * @return apiparamsMap
     */
    public static String requestAPI(TreeMap<String, String> map) {
        //去掉map中为空的键值对
        TreeMap<String, String> apiparamsMap = new TreeMap<>();
        for (String key : map.keySet()) {
            if(map.get(key)!=null && !"".equals(map.get(key))){
                apiparamsMap.put(key,map.get(key));
            }
        }
        // 查询管易云信息
        EStore eStore = estoreService.findEStore();
        // 判断是否开启
        if ("0".equals(eStore.getIsopen())) {
            // 不开启则返回
            return null;
        }
        if (eStore != null) {
            // 添加请求参数——appkey
            apiparamsMap.put("appkey", eStore.getAppkey());
            // 添加请求参数——sessionkey
            apiparamsMap.put("sessionkey", eStore.getSessionkey());
            //生成sign签名并添加到请求参数
            JSONObject json = JSONObject.fromObject(apiparamsMap);
            apiparamsMap.put("sign", SignUtil.sign(json.toString(), eStore.getSecret()));
            System.out.println("json报文："+JSONObject.fromObject(apiparamsMap).toString());
            String result = null;
            try {
                String encodePost = URLEncoder.encode(JSONObject.fromObject(apiparamsMap).toString(), "UTF-8");
                result = HttpMethodUtil.getResult(eStore.getUrl(), encodePost);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
                result = HttpMethodUtil.getResult(eStore.getUrl(), JSONObject.fromObject(apiparamsMap).toString());
            }
            return result;
        }
        // 返回
        return null;

    }

    /**
     * 对象转成map
     * @param object
     * @return
     */
    public static TreeMap objectToMap(Object object){
        TreeMap map = new TreeMap();
        try {
            Field[] declaredFields = object.getClass().getDeclaredFields();
            for (Field field : declaredFields) {
                field.setAccessible(true);
                //值为空，则不放到map中
                if(field.get(object)!=null && !"".equals(field.get(object))) {
                    Class<?> type = field.getType();
                    if(type== List.class){
                        List list = (List) field.get(object);
                        List<Map> mapList = new ArrayList();
                        for (Object o1 : list) {
                            mapList.add(objectToMap(o1));
                        }
                        map.put(field.getName(),mapList);
                    }else{
                        map.put(field.getName(), field.get(object));
                    }
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * 将接口应用级参数及调用方法放入TreeMap，调用接口得到数据
     *
     * @return apiparamsMap
     */
    public static String requestDST(TreeMap<String, String> requestMap, String method) {
        //去掉map中为空的键值对
        Iterator<Map.Entry<String, String>> iterator = requestMap.entrySet().iterator();
        while (iterator.hasNext()){
            Map.Entry<String, String> next = iterator.next();
            if(next.getValue()==null || "".equals(next.getValue())){
                iterator.remove();
            }
        }
        // 查询ERP系统级参数(server==url;dbhost==plat;token==session;appkey==erpOrgId)
        EStore eStore = estoreService.findEStore();
        // 判断是否开启
        if (eStore == null || "0".equals(eStore.getIsopen())) {
            // 不开启则返回
            return null;
        }
        TreeMap paramsMap = new TreeMap<>();
        if (eStore != null) {
            // 添加请求参数——plat
            paramsMap.put("plat", eStore.getDbhost());
            // 添加请求参数——access(服务商接口调用：1， 商家自研接口调用：2)
            paramsMap.put("access", "1");
            // 添加请求参数——session
            paramsMap.put("session", eStore.getSessionkey());
            // 添加请求参数——method
            paramsMap.put("method", method);
            // 添加请求参数——timestamp   时间戳（yyyy-MM-dd HH:mm:ss）
            paramsMap.put("timestamp", DateUtil.dateToString(new Date(),"yyyy-MM-dd HH:mm:ss"));
            //添加请求参数——format (json,xml)
            paramsMap.put("format","json");
            //添加请求参数——request
            requestMap.put("erpOrgId", eStore.getAppkey());
            if("1".equals(requestMap.get("shopId"))){
                requestMap.put("shopId", eStore.getShopId());
            }
            paramsMap.put("request", requestMap);
            System.out.println("请求报文："+JSONObject.fromObject(paramsMap).toString());
            //生成sign签名（目前为空）
            String sign = "";
            String result = null;
            result = HttpMethodUtil.getDSTResult(eStore.getUrl(), JSONObject.fromObject(paramsMap).toString(), sign);
            return result;
        }
        // 返回
        return null;
    }

    public static String getShopId(){
        return estoreService.findEStore().getShopId();
    }
}
