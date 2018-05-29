/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.m.shoppingcart.controller;

import com.alibaba.fastjson.JSON;
import com.ningpai.goods.bean.GoodsProduct;
import com.ningpai.m.common.service.SeoService;
import com.ningpai.m.customer.service.CustomerOrderService;
import com.ningpai.m.customer.vo.CustomerConstants;
import com.ningpai.m.customer.vo.GoodsBean;
import com.ningpai.m.goods.service.GoodsProductService;
import com.ningpai.m.shoppingcart.bean.GoodsStockBean;
import com.ningpai.m.shoppingcart.bean.ShoppingCart;
import com.ningpai.m.shoppingcart.service.ShoppingCartService;
import com.ningpai.marketing.service.MarketingService;
import com.ningpai.system.address.bean.ShoppingCartWareUtil;
import com.ningpai.system.address.service.ShoppingCartAddressService;
import com.ningpai.system.service.DefaultAddressService;
import com.ningpai.util.MyLogger;
import com.ningpai.util.ShoppingCartConstants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * 购物车控制器
 * 
 * @author NINGPAI-LIH
 *
 */
@Controller
public class ShoppingCartMController {
    /**
     * 日志
     */
    public static final MyLogger LOGGER = new MyLogger(ShoppingCartMController.class);
    private static final String CUSTOMERID = "customerId";


    @Resource(name = "ShoppingCartService")
    private ShoppingCartService shoppingCartService;

    @Resource(name = "MarketingService")
    private MarketingService marketingService;

    @Resource(name = "customerOrderServiceM")
    private CustomerOrderService customerOrderService;

    @Resource(name = "DefaultAddressService")
    private DefaultAddressService addressService;

    @Resource(name = "SeoService")
    private SeoService seoService;

    @Resource(name = "HsiteGoodsProductService")
    private GoodsProductService goodsProductService;

    @Autowired
    private ShoppingCartAddressService shoppingCartAddressService;

    /**
     * 购物车路径
     */
    private static final String REDIRECT = "myshoppingmcart.html";

    /**
     * 查询购物车
     *
     * @return ModelAndView
     */
    @RequestMapping("myshoppingmcart")
    public ModelAndView shoppingCart(HttpServletRequest request, String stockinfos) {
        request.getSession().setAttribute("tok", UUID.randomUUID().toString());
        // 获取地址信息
        ShoppingCartWareUtil wareUtil = shoppingCartAddressService.loadAreaFromRequest(request);
        Long customerId = (Long) request.getSession().getAttribute(CUSTOMERID);

        Map<String, Object> shopMap = shoppingCartService.shopCartMap(customerId, wareUtil.getDistrictId(), request);

        //购物车内的商品
        List<Object> shoplist = (List<Object>) shopMap.get("shoplist");
        //购物车为空
        List<GoodsProduct> goods = null;
        if (shoplist.size() == 0) {
            //查询猜你喜欢商品
            goods = goodsProductService.queryInfosOrderBySales(4L);
        }

        List<GoodsStockBean> list = new ArrayList<>();

        if (StringUtils.isNotEmpty(stockinfos)) {
            try {
                list = JSON.parseArray(stockinfos, GoodsStockBean.class);
            } catch (Exception e) {
                LOGGER.error("parseArray fail..." + stockinfos, e);
            }
        }
        ModelAndView mav = new ModelAndView(ShoppingCartConstants.SHOPPINGMCARTLIST)
                .addObject("shopMap", shopMap)
                .addObject("pro", marketingService.selectAll()).addObject("sx", request.getSession().getAttribute("tok").toString())
                .addObject("goods", goods)
                .addObject("stockinfos", list)
                .addObject("sessionOpedId", request.getSession().getAttribute("openid"));
        return seoService.getCurrSeo(mav);
    }

    /**
     * 移动端查询购物车商品数量
     * 移动端商品详情页使用
     *
     * @author houyichang 2015/10/21
     */
    @RequestMapping("myshoppingmcartNum")
    @ResponseBody
    public Integer shoppingCartNum(HttpServletRequest request) {
        request.getSession().setAttribute("tok", UUID.randomUUID().toString());
        // 获取地址信息
        Long customerId = (Long) request.getSession().getAttribute(CUSTOMERID);
        if (customerId != null) {
            return shoppingCartService.countCart(customerId);
        } else {
            return shoppingCartService.countCartInCookie();
        }
    }


    /**
     * 修改商品优惠
     *
     * @param shoppingCartId
     * @param marketingActivityId
     * @param marketingId
     * @return
     */
    @RequestMapping("/changeshoppingcartmarts")
    public ModelAndView changeShoppingCartMarts(Long shoppingCartId, Long marketingActivityId, Long marketingId, HttpServletRequest request, HttpServletResponse response) {
        shoppingCartService.changeShoppingCartMarket(shoppingCartId, marketingId, marketingActivityId, request, response);
        return new ModelAndView(new RedirectView(REDIRECT));
    }

    /**
     * 修改购物数量
     *
     * @param shoppingCartId
     * @param num
     * @return int
     */
    @RequestMapping("changeshoppingmcartbyid")
    @ResponseBody
    public int changeShoppingCartById(Long shoppingCartId, Long num,HttpServletResponse response,Long goodsInfoId) {
        return shoppingCartService.changeShoppingCartById(shoppingCartId, num,response,goodsInfoId);
    }

    /**
     * 删除购物车商品
     *
     * @param request
     * @return int
     */
    @RequestMapping("delshoppingcartbyid")
    @ResponseBody
    public int delShoppingCartById(String shoppingCartIds, String goodsInfoIds, HttpServletRequest request, HttpServletResponse response) {
        if(StringUtils.isNotBlank(shoppingCartIds)){
            shoppingCartIds = shoppingCartIds.substring(0,shoppingCartIds.length()-1);
            goodsInfoIds = goodsInfoIds.substring(0,goodsInfoIds.length()-1);
            String[] cartIds = shoppingCartIds.split(",");
            String[]  goodsIds = goodsInfoIds.split(",");

            shoppingCartService.delShoppingCartById(cartIds, goodsIds, request, response);

        }
        return 1;
    }


    /**
     * 添加购物车的控制器
     * KKK mobile-goods-detail  `加入购物车`->选择规格->`确定`
     *
     * @param goodsNum  购买货品的数量
     * @param productId 货品ID
     * @param request   请求对象
     * @return 添加购物车成功页面
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/addproducttoshopcarnew")
    @ResponseBody
    public int addProductToShopCarNew(Long goodsNum, Long productId, HttpServletRequest request, Long distinctId,Long mark, HttpServletResponse response)
            throws UnsupportedEncodingException {
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
        ShoppingCart shoppingCart = new ShoppingCart();
        shoppingCart.setDistinctId(null == distinctId ? 1103L : distinctId);
        shoppingCart.setGoodsInfoId(productId);
        if(goodsNum>99){
            goodsNum = 99l;
        }
        shoppingCart.setGoodsNum(goodsNum);
        if(customerId!=null){
            shoppingCart.setCustomerId(customerId);
        }
        int result = this.shoppingCartService.addShoppingCart(shoppingCart, request, response);
        if (mark > 0 && customerId != null) {
            //立即购买的逻辑  不影响其他
            Long ww=this.shoppingCartService.selectLastId(shoppingCart, response, request);
            return ww.intValue();
        }else{
            return result;
        }
        //return seoService.getCurrSeo(new ModelAndView(new RedirectView("addcartsuc.htm")).addObject("goodsInfoId", productId));
    }

    /**
     * 查询购物车数量
     * @param request
     * @return
     */
    @RequestMapping("/searchShopcartNum")
    @ResponseBody
    public Map<String,Object> searchShopcartNum(HttpServletRequest request){
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
        Long num = this.shoppingCartService.searchShopcartNum(request,customerId);
        Map map=new HashMap();
        map.put("num",num);
        return map;
    }



    /**
     * KKK mobile 购买优惠套装
     *
     * @param fitId
     *            套装ID {@link Long}
     * @return 购买标记 {@link Integer} 0:失败 1:成功
     */
    @RequestMapping("/buyPrePackage")
    @ResponseBody
    public int buyPrePackage(Long fitId, Long districtId, HttpServletRequest request, HttpServletResponse response) {
        ShoppingCart shoppingCart = new ShoppingCart();
        if (null != fitId && fitId > 0L) {
            shoppingCart.setGoodsInfoId(Long.parseLong("110012" + fitId));
            shoppingCart.setDistinctId(districtId);
            shoppingCart.setGoodsNum(1L);
            shoppingCart.setFitId(fitId);
            try {
                return shoppingCartService.addShoppingCart(shoppingCart, request, response);
            } catch (UnsupportedEncodingException e) {
                LOGGER.error("=====mobile==添加购物车报错：" + e);
                return 0;
            }

        }
        else{
            return 0;
        }
    }

    /**
     * 添加商品
     * @param request
     * @param orderId
     * @param response
     * @return
     */
    @RequestMapping("/addproducttoshopcarbyorderid")
    @ResponseBody
    public int addProductToShopCarByOrderId(HttpServletRequest request,Long orderId,HttpServletResponse response){
        //初始化
        int addCar = 0;
        //根据orderID查询订单下面的货品
        List<GoodsBean> goodsBeans = customerOrderService.selectByOrderId(orderId);
        //获取
        Long dId = request.getSession().getAttribute("distinctId")!=null?Long.valueOf(request.getSession().getAttribute("distinctId").toString()):addressService.getDefaultIdService();
        if (dId == null) {
            dId = 1103L;
        }
        if (CollectionUtils.isNotEmpty(goodsBeans)) {
            Long custId = (Long) request.getSession().getAttribute(CUSTOMERID);
            if(custId!=null){
                int sum = shoppingCartService.selectSumByCustomerId(custId);
                //购物车商品种类超过20件 时不能添加
                if(sum>20){
                    return -1;
                }
            }

            for (GoodsBean goodsBean : goodsBeans) {
                ShoppingCart shoppingCart = new ShoppingCart();
                try {
                    shoppingCart.setGoodsInfoId(goodsBean.getGoodsId());
                    shoppingCart.setGoodsNum(goodsBean.getGoodsNum());
                    shoppingCart.setDistinctId(dId);
                    addCar = shoppingCartService.addShoppingCart(shoppingCart, request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    LOGGER.info("添加购物车失败");
                }
            }
        }
        return addCar;
    }
}
