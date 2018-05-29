package com.ningpai.dst.goods.controller;

import com.ningpai.dst.goods.bean.DstGoods;
import com.ningpai.dst.goods.bean.DstShopGoods;
import com.ningpai.dst.goods.service.DstGoodsService;
import com.ningpai.util.XStreamUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 * 电商通商品控制器
 */
@Controller
public class DstGoodsController {

    @Resource
    private DstGoodsService dstGoodsService;

    /**
     * 创建商品档案
     * @param response
     * @param dstGoods
     */
    @RequestMapping("/dstAddGoods")
    public void dstAddGoods(HttpServletResponse response, DstGoods dstGoods) {
        dstGoods.setGoodsName("测试商品");
        dstGoods.setGoodsNum("201709251812281");
        dstGoods.setPrice("0.01");
        dstGoods.setUnit("个");
        dstGoods.setSkuCode(dstGoods.getGoodsNum());
        List goodsList = new ArrayList();
        goodsList.add(dstGoods);
        Map resultMap = dstGoodsService.dstAddGoods(goodsList);
        XStreamUtil.responseXml(response, resultMap);
    }

    /**
     * 创建店铺商品档案
     * @param response
     * @param dstShopGoods
     */
    @RequestMapping("/dstAddShopGoods")
    public void dstAddShopGoods(HttpServletResponse response, DstShopGoods dstShopGoods) {
        dstShopGoods.setTitle("测试商品");
        dstShopGoods.setOuterId("201709251812281");
        List goodsList = new ArrayList();
        goodsList.add(dstShopGoods);
        Map resultMap = dstGoodsService.dstAddShopGoods(goodsList);
        XStreamUtil.responseXml(response, resultMap);
    }

    /**
     * 批量获取商品
     * @param response
     * @param request
     */
    @RequestMapping("/dstGetGoods")
    public void dstGetGoods(HttpServletResponse response, HttpServletRequest request) {
        TreeMap map = new TreeMap();
        map.put("startTime","2018-04-15 00:00:00");
        map.put("endTime","2018-04-25 00:00:00");
        map.put("productType","0");
        map.put("skuCode",request.getParameter("orderCode"));
        map.put("productName",request.getParameter("platOrderCode"));
        map.put("productNum",request.getParameter("orderStatus"));
        map.put("pageSize","100");
        map.put("pageIndex","0");
        Map resultMap = dstGoodsService.dstGetGoods(map);
        XStreamUtil.responseXml(response, resultMap);
    }

}
