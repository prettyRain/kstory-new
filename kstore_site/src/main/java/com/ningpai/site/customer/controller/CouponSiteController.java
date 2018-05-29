/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
/**
 * 
 */
package com.ningpai.site.customer.controller;

import com.ningpai.coupon.bean.Coupon;
import com.ningpai.coupon.bean.CouponNo;
import com.ningpai.coupon.bean.ParamIds;
import com.ningpai.coupon.service.CouponNoService;
import com.ningpai.coupon.service.CouponService;
import com.ningpai.customer.bean.Customer;
import com.ningpai.index.service.TopAndBottomService;
import com.ningpai.logger.util.OperaLogUtil;
import com.ningpai.site.customer.service.CustomerServiceInterface;
import com.ningpai.site.customer.vo.CustomerConstantStr;
import com.ningpai.system.service.BasicSetService;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PageBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 控制器-我的优惠劵
 * 
 * @author NINGPAI-WangHaiYang
 * @since 2014年4月14日下午2:10:30
 */
@Controller
public class CouponSiteController {

    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(CouponSiteController.class);

    private static final String CUSTOMERID = "customerId";

    /**
     * 会员服务接口
     */
    private CustomerServiceInterface customerServiceInterface;

    /**
     * 站点设置服务层接口
     */
    @Resource(name = "basicSetService")
    private BasicSetService basicSetService;

    /**
     * 优惠券接口
     */
    private CouponService couponService;

    /**
     * 优惠券券码接口
     */
    private CouponNoService couponNoService;

    /**
     * 获取头尾
     */
    private TopAndBottomService topAndBottomService;

    /**
     * 进入优惠卷列表页
     *
     * @param request
     * @param
     * @return
     */
    @RequestMapping("coupon/queryCouponList")
    public ModelAndView queryMyCoupon(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        // 设置要跳转的页面
        mav.setViewName("coupon/couponlist");
        // 查询所有的优惠卷信息
        mav.addObject("couponLists", couponService.selectCouponList_site());
        // 新加载头部和底部信息<br/>
        return topAndBottomService.getTopAndBottom(mav);
    }

    /**
     * 查询我的优惠券
     * 
     * @Description: 查询我的优惠券
     * @param request
     *            请求
     * @param pageBean
     *            分页类
     * @param codeStatus
     *            状态
     * @return
     */
    @RequestMapping(value = "/queryMyCoupon")
    public ModelAndView queryMyCoupon(HttpServletRequest request, PageBean pageBean, String codeStatus) {
        ModelAndView mav = new ModelAndView();
        try {
            // 检查用户是否登录
            if (checkLoginStatus(request)) {
                Long cId = (Long) request.getSession().getAttribute(CUSTOMERID);
                // 根据主键 获取会员详细信息
                Customer customer = customerServiceInterface.queryCustomerById(cId);
                // 非空验证 用户名
                if (null != customer.getCustomerUsername()) {
                    LOGGER.info("查询会员【" + customer.getCustomerUsername() + "】的优惠券");
                }
                // 设置显示行数
                pageBean.setPageSize(12);
                mav.addObject("codeStatus", codeStatus);
                pageBean.setList(null);
                // 我的优惠券
                mav.addObject("pb", couponService.myCouponList(pageBean, cId, codeStatus));
                pageBean.setUrl("mycoupon-" + Integer.valueOf(codeStatus));
                // 查询站点信息
                mav.addObject("basicSet", basicSetService.findBasicSet());
                mav.setViewName("customer/newmycoupon");
            } else {
                // 没登录的用户跳转到登录页面
                mav = new ModelAndView("/login/redirect").addObject("url", "/mycoupon/1");
            }
            // 跳转到我的优惠券
            return topAndBottomService.getTopAndBottom(mav);
        } finally {
            mav = null;
        }
    }
    /**
     * 用户自己添加优惠券
     * @param request
     * @param couponCode
     * @return
     */
    @RequestMapping("addSiteCoupons")
    @ResponseBody
    public Object addCoupons(HttpServletRequest request, String couponCode){
        Object flag;
        if (checkLoginStatus(request)) {
            flag = couponNoService.selectCouponByCode(couponCode,(Long) request.getSession()
                    .getAttribute(CUSTOMERID));
        }else {
            // 没登录的用户跳转到登录页面
            flag = "login.html?url=/mycoupon-1.html";
        }
        return flag;
    }
    /**
     * 根据货品id查询未使用的优惠券列表
     * 商品详情页使用
     * @author houyichang 2015/10/19
     * @param productId 货品id
     *
     * */
    @RequestMapping("/querySiteCouponList")
    @ResponseBody
    public Map<String,List<Coupon>> queryCouponListBySpuId(HttpServletRequest request, Long productId, Long cateId, Long brandId, Long thirdId){
        //查询优惠券所需的参数集合
        List<ParamIds> paramIdsList = new ArrayList<ParamIds>();
        //查询优惠券所需的参数封装类
        ParamIds paramIds = new ParamIds();
        //查询优惠券所需的货品id
        paramIds.setCouponRangeFkId(productId);
        //查询优惠券所需的优惠券类型
        paramIds.setCouponRangeType("2");

        ParamIds paramIds1 = new ParamIds();
        //查询优惠券所需的分类id
        paramIds1.setCouponRangeFkId(cateId);
        paramIds1.setCouponRangeType("0");

        ParamIds paramIds2 = new ParamIds();
        //查询优惠券所需的品牌id
        paramIds2.setCouponRangeFkId(brandId);
        paramIds2.setCouponRangeType("1");
        paramIdsList.add(paramIds);
        paramIdsList.add(paramIds1);
        paramIdsList.add(paramIds2);

        //需要在此再加一个按品牌查和按分类查
        //查询优惠券列表并返回数据到前台
        Map map = new HashMap();
        List<Coupon> couponList = this.couponService.selectGoodsDetailCouponListByIdsNew(paramIdsList,thirdId,request);
        Long cId = (Long) request.getSession().getAttribute("customerId");
        List<Object> cList = new ArrayList<Object>();
        if(cId!=null && cId>0l){
            for(int i = 0;i<couponList.size();i++){
                Coupon coupon = couponList.get(i);
                // 查询该用户此优惠券领取的张数
                int counts = couponNoService.selectReadyGet(coupon.getCouponId(), cId);
                //获取优惠券码去查询
                if(counts >= coupon.getCouponGetNo()){
                    cList.add(coupon.getCouponId());
                }
            }
        }
        map.put("cList",cList);
        map.put("coupons",couponList);
        return map;
    }

    /**
     * 领取优惠券
     */
    @RequestMapping("/getOffCouponSite")
    @ResponseBody
    public int getOffCouponSite(HttpServletRequest request, Long couponId) {
        int couponResult = 0;
        // 插叙优惠券详细
        Coupon coupon = couponService.searchCouponById(couponId);

        Long cId = (Long) request.getSession().getAttribute(CUSTOMERID);
        if (cId == null) {
            couponResult = 3;
        } else {
            // // 根据主键 获取会员详细信息
            // CustomerAllInfo customer =
            // customerService.queryCustomerById(cId);
            // // 非空验证 用户名
            // if (null != customer.getCustomerUsername() && null !=
            // coupon.getCouponName()) {
            // // 操作日志
            // OperaLogUtil.addOperaLog(request, customer.getCustomerUsername(),
            // "领取优惠券", "优惠券名称【" + coupon.getCouponName() + "】");
            // // 记录日志
            // LOGGER.info("会员【" + customer.getCustomerUsername() +
            // "】领取优惠券成功！");
            // }
            // 查询该用户此优惠券领取的张数
            int counts = couponNoService.selectReadyGet(couponId, cId);
            // 查询优惠券总数
            int countAll = couponNoService.selectCountAllByCouponId(couponId);

            // 如果等于0代表没有领取，可以进行领取
            // 否则提示已经领取过
            if (counts < coupon.getCouponGetNo().intValue()) {
                // 判断可领取张数减去已经被领取张数是否大于0
                // 如果大于0，可以进行领取
                // 否则提示已领取完
                if ((countAll - couponNoService.queryUsedCountByCouponId(
                        couponId).intValue()) > 0) {
                    Date d = new Date();
                    String timeType = coupon.getTimeType();
                    //0为起止时间
                    // 如果开始时间 大于当前时间 并且 结束世界晚于当前时间 为有效
                    if("0".equals(timeType)){
                        if (coupon.getCouponStartTime().before(d)
                                && coupon.getCouponEndTime().after(d)) {
                            // 返回劵码
                            CouponNo couponNo = couponNoService
                                    .selectNoByCouponIdByStatus(couponId);
                            if (couponNo != null) {
                                // 领取优惠券
                                int count = couponNoService.updateCouponCustomer(
                                        couponNo.getCodeId(), cId);
                                if (count > 0) {
                                    // 领取成功
                                    couponResult = 1;
                                    if(coupon.getCouponGetNo().intValue()-Long.valueOf(counts)==1l){
                                        //领取成功 且这是最后一张可以领取的
                                        couponResult =5;
                                    }
                                } else {
                                    // 已领取完
                                    couponResult = 2;
                                }
                            } else {
                                // 3就代表要跳转到登录页面
                                couponResult = 3;
                            }
                        } else {
                            // 优惠券已失效
                            couponResult = 2;
                        }
                        //1为固定时段
                    }else if("1".equals(timeType)){
                        // 返回劵码
                        CouponNo couponNo = couponNoService
                                .selectNoByCouponIdByStatus(couponId);
                        if (couponNo != null) {
                            // 领取优惠券
                            int count = couponNoService.updateCouponCustomer(
                                    couponNo.getCodeId(), cId);
                            if (count > 0) {
                                // 领取成功
                                couponResult = 1;
                                if(coupon.getCouponGetNo().intValue()-Long.valueOf(counts)==1l){
                                    //领取成功 且这是最后一张可以领取的
                                    couponResult =5;
                                }
                            } else {
                                // 已领取完
                                couponResult = 2;
                            }
                        } else {
                            // 3就代表要跳转到登录页面
                            couponResult = 3;
                        }
                    }

                } else {
                    // 已领取完
                    couponResult = 2;
                }
            } else {
                // 已领取过
                couponResult = 4;
            }
        }

        return couponResult;
    }
    /**
     * 领取优惠券
     * 
     * @param request
     * @param
     * @return
     */
    @RequestMapping("getOffCoupon")
    public ModelAndView getOffCoupon(HttpServletRequest request, Long couponId) {
        ModelAndView mav = new ModelAndView();
        // 插叙优惠券详细
        Coupon coupon = couponService.searchCouponById(couponId);
        try {

            Long cId = (Long) request.getSession().getAttribute(CUSTOMERID);
            if (cId == null) {
                mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT);
                // mav = new ModelAndView(new RedirectView("login.html"));
            } else {
                // 根据主键 获取会员详细信息
                Customer customer = customerServiceInterface.queryCustomerById(cId);
                // 非空验证 用户名
                if (null != customer.getCustomerUsername() && null != coupon.getCouponName()) {
                    // 操作日志
                    OperaLogUtil.addOperaLog(request, customer.getCustomerUsername(), "领取优惠券", "优惠券名称【" + coupon.getCouponName() + "】");
                    // 记录日志
                    LOGGER.info("会员【" + customer.getCustomerUsername() + "】领取优惠券成功！");
                }
                // 查询该用户此优惠券领取的张数
                int counts = couponNoService.selectReadyGet(couponId, cId);
                // 查询优惠券总数
                int countAll = couponNoService.selectCountAllByCouponId(couponId);

                // 如果等于0代表没有领取，可以进行领取
                // 否则提示已经领取过
                if (counts < coupon.getCouponGetNo().intValue()) {
                    // 判断可领取张数减去已经被领取张数是否大于0
                    // 如果大于0，可以进行领取
                    // 否则提示已领取完
                    if ((countAll - couponNoService.queryUsedCountByCouponId(couponId).intValue()) > 0) {
                        Date d = new Date();
                        // 如果开始时间 大于当前时间 并且 结束世界晚与当前时间 为有效
                        if (coupon.getCouponStartTime().before(d) && coupon.getCouponEndTime().after(d)) {
                            // 返回劵码
                            CouponNo couponNo = couponNoService.selectNoByCouponIdByStatus(couponId);
                            if (couponNo != null) {
                                // 领取优惠券
                                int count = couponNoService.updateCouponCustomer(couponNo.getCodeId(), cId);
                                if (count > 0) {
                                    // 领取成功页面
                                    mav.setViewName("customer/couponpage");
                                } else {
                                    // 已领取完页面
                                    mav.setViewName("customer/couponwrongpage");
                                }
                            } else {

                                mav = new ModelAndView(new RedirectView("login.html"));
                            }

                        } else {

                            // 已领取完页面
                            mav.setViewName("customer/couponstart");
                        }

                    } else {
                        // 已领取完页面
                        mav.setViewName("customer/couponwrongpage");
                    }
                } else {

                    // 已领取过页面
                    mav.setViewName("customer/coupongotpage");
                }
            }
            // 跳转到我的优惠券
            return topAndBottomService.getTopAndBottom(mav);
        } finally {
            mav = null;
        }
    }

    // 验证用户是否登录
    private boolean checkLoginStatus(HttpServletRequest request) {
        if (request.getSession().getAttribute(CUSTOMERID) == null) {
            return false;
        }
        return true;
    }

    public CouponNoService getCouponNoService() {
        return couponNoService;
    }

    @Resource(name = "CouponNoService")
    public void setCouponNoService(CouponNoService couponNoService) {
        this.couponNoService = couponNoService;
    }

    public CouponService getCouponService() {
        return couponService;
    }

    @Resource(name = "CouponService")
    public void setCouponService(CouponService couponService) {
        this.couponService = couponService;
    }

    public TopAndBottomService getTopAndBottomService() {
        return topAndBottomService;
    }

    @Resource(name = "TopAndBottomService")
    public void setTopAndBottomService(TopAndBottomService topAndBottomService) {
        this.topAndBottomService = topAndBottomService;
    }

    public CustomerServiceInterface getCustomerServiceInterface() {
        return customerServiceInterface;
    }

    @Resource(name = "customerServiceSite")
    public void setCustomerServiceInterface(CustomerServiceInterface customerServiceInterface) {
        this.customerServiceInterface = customerServiceInterface;
    }
}
