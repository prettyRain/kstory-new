/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */

package com.ningpai.site.goods.service.impl;

import com.ningpai.common.util.ConstantUtil;
import com.ningpai.goods.dao.GoodsElasticMapper;
import com.ningpai.goods.util.GoodsMarketingCodeUtil;
import com.ningpai.site.customer.bean.Browserecord;
import com.ningpai.site.customer.controller.CustomerController;
import com.ningpai.site.customer.service.BrowserecordService;
import com.ningpai.site.customer.vo.GoodsBean;
import com.ningpai.site.goods.dao.GoodsProductMapper;
import com.ningpai.site.goods.service.BrowerService;
import com.ningpai.site.goods.vo.GoodsProductVo;
import com.ningpai.util.MyLogger;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;

/**
 * 浏览历史Service实现
 *
 * @author NINGPAI-YuanKangKang
 * @since 2014年4月17日 下午2:27:40
 * @version 1.0
 */
@Service("BrowerService")
public class BrowerServiceImpl implements BrowerService {

    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(CustomerController.class);

    private static final String COOKIE = "_npstore_browpro";

    private BrowserecordService browserecordService;

    private GoodsProductMapper goodsProductMapper;

    // pring注入
    @Resource(name = "GoodsElasticMapper")
    private GoodsElasticMapper goodsElasticMapper;

    /**
     * 保存浏览记录
     *
     * @param request
     *            请求对象
     * @param response
     * @param productId
     *            货品ID
     * @return
     * @throws UnsupportedEncodingException
     */
    @Transactional
    public boolean saveBrowerHis(HttpServletRequest request, HttpServletResponse response, Long productId) throws UnsupportedEncodingException {
        // 取出当期那登陆的用户ID
        Long custId = (Long) request.getSession().getAttribute("customerId");
        Cookie cookie;
        String allBroPro = "";
        boolean cookieExits = false;
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (null != custId) {
                map.put("custId", custId);
                map.put("productId", productId);
                goodsProductMapper.updateGoodsBrowStatus(map);
                this.goodsProductMapper.saveGoodsBrow(map);
            } else {
                // 先取出来cookie中的值,然后拼接,重新保存到cookie中
                Cookie[] oldCookie = request.getCookies();
                StringBuilder sb=new StringBuilder();
                if (null != oldCookie) {
                    for (Cookie cookie2 : oldCookie) {
                        if (null != cookie2 && COOKIE.equals(cookie2.getName())) {
                            allBroPro = URLDecoder.decode(cookie2.getValue(), ConstantUtil.UTF);
//                            if (allBroPro.indexOf(",s" + productId + "e") != -1) {
//                                allBroPro = allBroPro.replace(",s" + productId + "e", "");
//                            }
//                            if (allBroPro.indexOf(",s" + productId) != -1) {
//                                allBroPro = allBroPro.replace(",s" + productId, "");
//                            }
                            //xcy  加了一个浏览时间
                            String[] arr=allBroPro.split(",s");
                            for(String str:arr){
                                if(StringUtils.isNotBlank(str)){
                                    if(str.indexOf(productId.toString())==-1){
                                        sb.append(",s"+str);
                                    }
                                }
                            }
                            // 说明存储浏览记录的cookie已经存在
                            cookieExits = true;
                        }
                    }
                    // 如果存在标记为false

                    allBroPro=sb.toString();

                    allBroPro += ",s" + productId +"-"+new Date().getTime()+ "e";
                }
                // 如果存储浏览记录的cookie不存在
                if (!cookieExits) {
                    Date date=new Date();
                    String time=date.getTime()+"";
                    allBroPro = String.valueOf(",s" + productId+"-"+time+ "e");
                }
                // 如果当前用户是未登录写状态就保存浏览记录到cookie中
                cookie = new Cookie(COOKIE, URLEncoder.encode(allBroPro, ConstantUtil.UTF));
                cookie.setMaxAge(15 * 24 * 3600);
                // 保存Cookie
                cookie.setPath("/");
                response.addCookie(cookie);
            }
            return false;
        } finally {
            custId = null;
            allBroPro = null;
            map = null;
        }
    }

    /**
     * 获取浏览的历史记录
     *
     * @param request
     *            请求对象
     * @return
     */
    public Map<String, Object> loadBrowHist(HttpServletRequest request) {
        // 取出当期那登陆的用户ID
        Long custId = (Long) request.getSession().getAttribute("customerId");
        Map<String, Object> map = new HashMap<String, Object>();
        String cookiestr = "";
        try {
            if (null != custId) {
                map.put("type", 1);
                List<Browserecord> browHist = this.browserecordService.selectBrowserecord(custId);
                for (Browserecord browserecord : browHist) {
                    GoodsBean goods = browserecord.getGoods();
                    BigDecimal finalPrice = goods.getGoodsPrice();
                    //查询商品是否有促销，有就显示促销价
                    List<GoodsMarketingCodeUtil> codeUtils = goodsElasticMapper.selectProductMarket(Long.valueOf(browserecord.getGoodsId()));
                    for (GoodsMarketingCodeUtil gms : codeUtils) {
                        if (gms.getCodexId() == 1) {
                            //直降
                            BigDecimal discount = goodsElasticMapper.selectPriceOffMarketingByMarketingId(gms.getMarketingId());
                            finalPrice = goods.getGoodsPrice().subtract(discount);
                        } else if (gms.getCodexId() == 10) {
                            //团购
                            BigDecimal discount = goodsElasticMapper.selectGrouponByMarketId(gms.getMarketingId());
                            finalPrice = goods.getGoodsPrice().multiply(discount);
                        } else if (gms.getCodexId() == 11) {
                            //抢购
                            BigDecimal discount = goodsElasticMapper.selectRushByMarketId(gms.getMarketingId());
                            finalPrice = goods.getGoodsPrice().multiply(discount);
                        } else if (gms.getCodexId() == 15) {
                            //折扣
                            Map<String, Object> param = new HashMap<String, Object>();
                            param.put("goodsId", Long.valueOf(browserecord.getGoodsId()));
                            param.put("marketingId", gms.getMarketingId());
                            BigDecimal discount = goodsElasticMapper.selectDiscountByMarketId(param);
                            finalPrice = goods.getGoodsPrice().multiply(discount);
                        }
                    }
                    goods.setGoodsMarketPrice(finalPrice);
                    browserecord.setGoods(goods);
                }
                map.put("browHist", browHist);
                map.put("pageLength",browHist.size());
            } else {
                map.put("type", 2);
                // 先取出来cookie中的值
                Cookie[] cookie = request.getCookies();
                if (null != cookie) {
                    for (Cookie cookie2 : cookie) {
                        if (null != cookie2 && COOKIE.equals(cookie2.getName())) {
                            try {
                                cookiestr = URLDecoder.decode(cookie2.getValue(), ConstantUtil.UTF);
                            } catch (UnsupportedEncodingException e) {
                                LOGGER.error("获取浏览记录报错：" + e);
                            }
                        }
                    }
                    // 判断取到的cookie值是不是为空
                    if (!"".equals(cookiestr)) {
                        cookiestr = cookiestr.replace(",s", ",");
                        cookiestr = cookiestr.replace("e", "");
                        // 截取第一个,
                        cookiestr = cookiestr.substring(0, cookiestr.length());
                        Map<String, Object> proMap = new HashMap<String, Object>();
                        List<Long> productIds = new ArrayList<Long>();
                        List<GoodsProductVo> proList = new ArrayList<GoodsProductVo>();
                        List<GoodsProductVo> calcList = new ArrayList<GoodsProductVo>();
                        //xcy

                        String[] idsAndTimes = cookiestr.split(",");
                        List<String> ids=new ArrayList();
                        for(String idAndTime:idsAndTimes){
                            if(StringUtils.isNotBlank(idAndTime)){
                                String[] idAndTimeArr=idAndTime.split("-");
                                ids.add(idAndTimeArr[0]);
                            }
                        }

                        try {
                            for (int i = 0; i < ids.size(); i++) {
                                productIds.add(Long.parseLong(ids.get(i)));
                            }
                            proMap.put("productIds", productIds);
                            proList = this.goodsProductMapper.queryProductsByProductIds(proMap);
                            // 循环匹配并排序
                            for (int i = productIds.size() - 1; i > -1; i--) {
                                for (GoodsProductVo product : proList) {
                                    if (productIds.get(i).equals(product.getGoodsInfoId())) {
                                        BigDecimal finalPrice = product.getGoodsInfoPreferPrice();
                                        //查询商品是否有促销，有就显示促销价
                                        List<GoodsMarketingCodeUtil> codeUtils = goodsElasticMapper.selectProductMarket(product.getGoodsInfoId());
                                        for (GoodsMarketingCodeUtil gms : codeUtils) {
                                            if (gms.getCodexId() == 1) {
                                                //直降
                                                BigDecimal discount = goodsElasticMapper.selectPriceOffMarketingByMarketingId(gms.getMarketingId());
                                                finalPrice = product.getGoodsInfoPreferPrice().subtract(discount);
                                            } else if (gms.getCodexId() == 10) {
                                                //团购
                                                BigDecimal discount = goodsElasticMapper.selectGrouponByMarketId(gms.getMarketingId());
                                                finalPrice = product.getGoodsInfoPreferPrice().multiply(discount);
                                            } else if (gms.getCodexId() == 11) {
                                                //抢购
                                                BigDecimal discount = goodsElasticMapper.selectRushByMarketId(gms.getMarketingId());
                                                finalPrice = product.getGoodsInfoPreferPrice().multiply(discount);
                                            } else if (gms.getCodexId() == 15) {
                                                //折扣
                                                Map<String, Object> param = new HashMap<String, Object>();
                                                param.put("goodsId", product.getGoodsInfoId());
                                                param.put("marketingId", gms.getMarketingId());
                                                BigDecimal discount = goodsElasticMapper.selectDiscountByMarketId(param);
                                                finalPrice = product.getGoodsInfoPreferPrice().multiply(discount);
                                            }
                                        }
                                        product.setGoodsInfoMarketPrice(finalPrice);
                                        calcList.add(product);
                                    }
                                }
                            }
                            map.put("productList", calcList);
                            map.put("pageLength",calcList.size());
                        } finally {
                            productIds = null;
                            ids = null;
                            proMap = null;
                        }
                    }
                }
            }
            return map;
        } finally {
            map = null;
            custId = null;
        }
    }

    @Override
    public void updateGoodsBrowStatus(Map map) {
        this.goodsProductMapper.updateGoodsBrowStatus(map);
    }

    @Override
    public void saveGoodsBrowCookie(Map map) {
       this.goodsProductMapper.saveGoodsBrowCookie(map);
    }

    @Override
    public Date getBrowerCreatTime(Map map) {
        return this.goodsProductMapper.getBrowerCreatTime(map);
    }

    public BrowserecordService getBrowserecordService() {
        return browserecordService;
    }

    @Resource(name = "browserecordService")
    public void setBrowserecordService(BrowserecordService browserecordService) {
        this.browserecordService = browserecordService;
    }

    public GoodsProductMapper getGoodsProductMapper() {
        return goodsProductMapper;
    }

    @Resource(name = "HsiteGoodsProductMapper")
    public void setGoodsProductMapper(GoodsProductMapper goodsProductMapper) {
        this.goodsProductMapper = goodsProductMapper;
    }

}
