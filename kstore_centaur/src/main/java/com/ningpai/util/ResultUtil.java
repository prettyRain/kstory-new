package com.ningpai.util;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.*;

/**
 * 返回结果工具类
 */
public class ResultUtil {

    /**
     * 将结果转成map集合（添加、修改的回调）
     * @param result
     * @param map
     * @return
     */
    public static Map resultToMap(String result, Map map){
        if(result==null || "".equals(result)){
            return null;
        }
        JSONObject resultJson = JSONObject.fromObject(result);
        //判断返回结果是否成功（code）
        String code = (String) resultJson.get("code");
        if(!"0000".equals(code) || "failure".equals((String) resultJson.get("flag"))){
            if(code.indexOf("ERROR-PLAT")>-1){
                map.put("message",resultJson.get("msg"));
            }else {
                map.put("message", resultJson.get("message"));
            }
            map.put("code",code);
            map.put("flag","failure");
            map.put("data",resultJson.get("data"));
            return map;
        }
        Set set = map.keySet();
        Iterator iterator = set.iterator();
        while (iterator.hasNext()){
            String name = (String) iterator.next();
            map.put(name,resultJson.get(name));
        }
        return map;
    }
/*

    */
/**
     * 返回简单结果处理为实体对象（分页）
     * @param gPageBean
     * @param result
     * @param listName
     * @param clazz
     * @return
     *//*

    public static GPageBean resultToPage(GPageBean gPageBean, String result, String listName, Class clazz){
        if(result==null || "".equals(result)){
            return null;
        }
        System.out.println(result);
        JSONObject obj = JSONObject.fromObject(result);
        try {
            gPageBean.setRows((Integer) obj.get("total"));
            System.out.println("查询结果总数--------------" + obj.get("total"));
            List list = (List) JSONArray.toCollection(JSONArray.fromObject(obj.get(listName)), clazz);
            gPageBean.setList(list);
        } catch (Exception e) {
            e.printStackTrace();
            //输出错误信息
            gPageBean.setObjectBean(obj.get("errorDesc")+"("+obj.get("subErrorDesc")+")");
        }
        return gPageBean;
    }
*/

    /**
     * 返回复杂结果（包含有集合）处理为实体对象（分页）
     * @param result
     * @param listName
     * @param clazz
     * @param paramMap 包含的集合映射（对象名--类）
     * @return
     */
    public static Map resultWithListToMap(String result, String listName, Class clazz, Map<String, Class> paramMap){
        Map resultMap = new HashMap();
        System.out.println(result);
        JSONObject obj = JSONObject.fromObject(result);
        JSONArray jsonArray = JSONArray.fromObject(obj.get(listName));
        List list = new ArrayList();
        for (int i = 0; i < jsonArray.size(); i++) {
            list.add(JSONObject.toBean(jsonArray.getJSONObject(i), clazz, paramMap));
        }
        resultMap.put(listName,list);
        return resultMap;
    }
}
