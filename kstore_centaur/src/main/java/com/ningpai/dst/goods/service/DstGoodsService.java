package com.ningpai.dst.goods.service;

import com.ningpai.dst.goods.bean.DstComboGoodsDetail;
import com.ningpai.dst.goods.bean.DstGoods;
import com.ningpai.dst.goods.bean.DstGoodsVo;
import com.ningpai.dst.goods.bean.DstShopGoods;
import com.ningpai.util.ERPUtil;
import com.ningpai.util.ResultUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * 电商通商品service
 */
@Service
public class DstGoodsService {

    /**
     * 创建商品
     * @param goodsList
     * @return
     */
    public Map dstAddGoods(List<DstGoods> goodsList){
        TreeMap map = new TreeMap();
        for (DstGoods dstOrder : goodsList) {
            if(dstOrder==null){
                return null;
            }
        }
        map.put("goods",goodsList);
        String result = ERPUtil.requestDST(map, "dstGoodsBatchadd");
        map.clear();
        map.put("flag",null);
        map.put("code",null);
        map.put("message",null);
        map.put("data",null);
        return ResultUtil.resultToMap(result,map);
    }

    /**
     * 创建店铺商品（用于对应商城和电商通商品关系）
     * @param goodsList
     * @return
     */
    public Map dstAddShopGoods(List<DstShopGoods> goodsList) {
        TreeMap map = new TreeMap();
        for (DstShopGoods dstShopGoods : goodsList) {
            if(dstShopGoods==null){
                return null;
            }
            dstShopGoods.setShopId(ERPUtil.getShopId());
        }
        map.put("goods",goodsList);
        String result = ERPUtil.requestDST(map, "dstGoodsShopGoodsBatchAdd");
        map.clear();
        map.put("flag",null);
        map.put("code",null);
        map.put("message",null);
        map.put("data",null);
        return ResultUtil.resultToMap(result,map);
    }

    /**
     * 批量查询商品
     * @return
     */
    public Map dstGetGoods(TreeMap map) {
        Map resultMap = new HashMap();
        String result = ERPUtil.requestDST(map, "dstGoodsBatchget");
        if(result==null || "".equals(result)){
            return null;
        }
        JSONObject resultJson = JSONObject.fromObject(result);
        //判断返回结果是否成功（code）
        String code = (String) resultJson.get("code");
        resultMap.put("code",code);
        if(!"0000".equals(code) || "failure".equals((String) resultJson.get("flag"))){
            if(code.indexOf("ERROR-PLAT")>-1){
                resultMap.put("message",resultJson.get("msg"));
            }else {
                resultMap.put("message", resultJson.get("message"));
            }
            return resultMap;
        }
        JSONObject dataJson = JSONObject.fromObject(resultJson.get("data"));
        //获取数量信息
        resultMap.put("total",dataJson.get("total"));
        System.out.println("查询结果总数--------------" + dataJson.get("total"));
        //获取订单列表
        Map<String, Class> paramMap = new HashMap<String, Class>();
        paramMap.put("comboGoodsDetails", DstComboGoodsDetail.class);
        JSONArray jsonArray = JSONArray.fromObject(dataJson.get("goodsList"));
        List list = new ArrayList();
        for (int i = 0; i < jsonArray.size(); i++) {
            list.add(JSONObject.toBean(jsonArray.getJSONObject(i), DstGoodsVo.class, paramMap));
        }
        resultMap.put("goodsList",list);
        return resultMap;
    }
}
