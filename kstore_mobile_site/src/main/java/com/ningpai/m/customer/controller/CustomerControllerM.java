/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.m.customer.controller;

import com.ningpai.coupon.service.CouponService;
import com.ningpai.customer.bean.AvatarNotice;
import com.ningpai.customer.bean.CustomerPointLevel;
import com.ningpai.customer.service.CustomerPointServiceMapper;
import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.customer.service.InsideLetterServiceMapper;
import com.ningpai.customer.service.PointLevelServiceMapper;
import com.ningpai.customer.vo.InsideLetterVo;
import com.ningpai.goods.bean.GoodsProduct;
import com.ningpai.m.backorder.service.ReturnGoodsService;
import com.ningpai.m.common.service.SeoService;
import com.ningpai.m.customer.bean.Customer;
import com.ningpai.m.customer.bean.OrderNotice;
import com.ningpai.m.customer.service.*;
import com.ningpai.m.customer.vo.CustomerAllInfo;
import com.ningpai.m.customer.vo.CustomerConstants;
import com.ningpai.m.deposit.bean.DepositInfo;
import com.ningpai.m.deposit.service.DepositInfoService;
import com.ningpai.m.deposit.service.TradeInfoService;
import com.ningpai.m.goods.service.GoodsProductService;
import com.ningpai.m.util.LoginUtil;
import com.ningpai.system.service.DefaultAddressService;
import com.ningpai.util.PageBean;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 手机端会员控制层
 *
 * @author NINGPAI-zhangqiang
 * @since 2014年8月20日 上午10:16:32
 * @version 0.0.1
 */
@Controller
public class CustomerControllerM {

    // spring 注解 会员service
    @Resource(name = "customerServiceM")
    private CustomerService customerService;

    @Resource(name = "SeoService")
    private SeoService seoService;

    @Resource(name="customerFollowServiceMSite")
    private CustomerFollowService customerFollowService;

    @Resource(name="mbrowserecordService")
    private BrowserecordService browserecordService;

    @Resource(name="insideLetterServiceMapper")
    private InsideLetterServiceMapper insideLetterServiceMapper;

    @Resource(name="orderNoticeServiceM")
    private OrderNoticeService orderNoticeService;

    @Resource(name="GuessLikeGoodsServiceM")
    private GuessLikeGoodsService guessLikeGoodsService;

    @Resource(name="HsiteGoodsProductService")
    private GoodsProductService goodsProductMapper;

    // spring注解 会员订单service
    @Resource(name="customerOrderServiceM")
    private CustomerOrderService customerOrderService;

    @Resource(name="MReturnGoodsService")
    private ReturnGoodsService returnGoodsService;

    @Resource(name="customerPointServiceMapper")
    private CustomerPointServiceMapper customerPointServiceMapper;
    // spring 注解
    @Resource(name="customerServiceMapper")
    private CustomerServiceMapper customerServiceMapper;

    @Autowired
    private DepositInfoService depositInfoService;

    // 优惠券Service
    @Resource(name = "CouponService")
    private CouponService couponService;

    @Autowired
    private TradeInfoService tradeInfoService;

    //查询默认地址接口
    @Resource(name = "DefaultAddressService")
    private DefaultAddressService addressService;

    private static final String URLREDIRECT = "redirect:/loginm.html?url=/myaccount/.html";
    private static final String URLREDIRECTMAINONE = "redirect:/loginm.html?url=/myaccount.html?main=1";
    private static final String URLREDIRECTMAINTWO = "redirect:/loginm.html?url=/myaccount.html?main=2";
    private static final String RULMYACCOUNT="redirect:/myaccount.html";
    private static final String RULMYACCOUNTMAINONE = "redirect:/myaccount.html?main=1";
    private static final String RULMYACCOUNTMAINTWO = "redirect:/myaccount.html?main=2";
    private static final String CUSTOMER = "customer";
    public PointLevelServiceMapper getPointLevelServiceMapper() {
        return pointLevelServiceMapper;
    }
    private PointLevelServiceMapper pointLevelServiceMapper;
    // Spring注入
    @Resource(name = "pointLevelServiceMapper")
    public void setPointLevelServiceMapper(PointLevelServiceMapper pointLevelServiceMapper) {
        this.pointLevelServiceMapper = pointLevelServiceMapper;
    }

    /**
     * 会员中心
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/customercenter")
    public ModelAndView index(HttpServletRequest request,HttpServletResponse response) {
        // 跳转个人中心
        ModelAndView mav = null;
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {

                Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);

                //查询会员获得总积分
                int pointSum = this.customerPointServiceMapper.getCustomerAllPoint(customerId+"");
                CustomerAllInfo info = new CustomerAllInfo();
                info.setCustomerId(customerId);
                info.setInfoPointSum(pointSum);
                this.customerService.updateCustomerInfo(info);
                //根据查询到的用户总积分来更新其用户等级
                Long levelId=0L;
                String levelName="";
                Integer gradePoint = pointSum-customerPointServiceMapper.getCustomerOrderSubtractPoint(customerId+"");
                List<CustomerPointLevel> pointList = this.pointLevelServiceMapper.selectAllPointLevel();
                if(null != pointList && pointList.size()>0){
                    for(int i = 0;i<pointList.size();i++){
                        String[] a = pointList.get(i).getPointNeed().split("~");
                        if(gradePoint >= Integer.parseInt(a[0]) && gradePoint <= Integer.parseInt(a[1])){
                            levelId = pointList.get(i).getPointLelvelId();
                            levelName = pointList.get(i).getPointLevelName();
                            break;
                        }
                    }
                }

                //执行修改会员等级方法
                this.customerService.updCustLevel(levelId,levelName,customerId);

                request.getSession().setAttribute("cust",customerService.selectByPrimaryKey(customerId));
                //我的收藏数目
//                Long myCollectionCount = customerFollowService.myCollectionsCount(customerId);
//                Long browereCount = browserecordService.browereCount(customerId);
//                //站内信消息数目
//                Long insideLetterCount = insideLetterServiceMapper.getIsNotReadCount((Long) request
//                        .getSession().getAttribute(
//                                CustomerConstants.CUSTOMERID));
//                //订单消息通知数目
//                Long orderNoticeCount = this.orderNoticeService.getIsNotReadCount((Long) request
//                        .getSession().getAttribute(
//                                CustomerConstants.CUSTOMERID));


                //猜你喜欢
                List<GoodsProduct> guessLikes = this.guessLikeGoodsService.guessLikeGoodsList(customerId);

                //未付款订单总数
                int noMoneyCount = this.customerOrderService.queryNoMoneyOrderCount("","1",customerId);

                //待发货订单总数
                int noFaHuoCount = this.customerOrderService.queryOrderCountC("","2",customerId);

                //未收货订单总数
                int noShowHuoCount = this.customerOrderService.queryOrderCountC("","3",customerId);

                //待评价订单总数
                int noCommentCount = this.customerOrderService.queryOrderCountC("","4",customerId);

                //退款、退货订单总数
                int cancelCount = this.returnGoodsService.queryCancleOrderCount((Long) request
                        .getSession().getAttribute(
                                CustomerConstants.CUSTOMERID));

                //消息总数 = 系统通知 + 商城通知
                Long noticeCount = this.orderNoticeService.getUnReadCounts(customerId) + this.insideLetterServiceMapper.getUnReadCounts(customerId);

                //查询该会员下资产总额
                DepositInfo depositInfo = depositInfoService.queryDepositInfo(customerId);

                //积分
                CustomerAllInfo customerAllInfo = customerService.selectByPrimaryKey(customerId);
                int point = customerAllInfo.getInfoPointSum() - customerPointServiceMapper.getCustomerReducePoint(customerId + "");

                //优惠券数量
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("customerId",customerId);
                map.put("codeStatus","1");
                int couponCount = couponService.myCouponListCount(map);

                if (!guessLikes.isEmpty()) {
                    resultMap.put("guessLikes", guessLikes);
                }else{
                    resultMap.put("guessLikes", goodsProductMapper.queryInfosOrderBySales(10l));
                }
//                resultMap.put("mycollectcount", myCollectionCount);
//                resultMap.put("browereCount", browereCount);
//                resultMap.put("xiaoxiCount", insideLetterCount.longValue()+orderNoticeCount.longValue());
                //获取区县id
                //先获取session中的地址  如果为空的话就获取默认的地址
                Long defaultDistrictId = null;
               /* 如果session中的地区ID为空,就设置为默认江苏南京 */
                if (null != request.getSession().getAttribute("distinctId")) {
                    defaultDistrictId = Long.parseLong(request.getSession().getAttribute("distinctId").toString());
                }else{
                    // 默认地区ID
                    defaultDistrictId = addressService.getDefaultIdService();
                }
                request.getSession().setAttribute("distinctId",defaultDistrictId);
                response.setHeader("Cache-Control","no-store");
                response.setDateHeader("Expires", 0);
                response.setHeader("Pragma","no-cache");
                resultMap.put("noMoneyCount",noMoneyCount);
                resultMap.put("noShowHuoCount",noShowHuoCount);
                resultMap.put("noFaHuoCount",noFaHuoCount);
                resultMap.put("noCommentCount",noCommentCount);
                resultMap.put("cancelCount",cancelCount);
                resultMap.put("noticeCount",noticeCount);
                resultMap.put("depositInfo",depositInfo);
                resultMap.put("couponCount",couponCount);
                resultMap.put("point",point);
                resultMap.put("sessionOpedId", request.getSession().getAttribute("openid"));
                mav = new ModelAndView(CustomerConstants.CUSTOMERINDEX);
                mav.addAllObjects(resultMap);
            } else {
                mav = new ModelAndView(
                        "redirect:/loginm.html?url=/customercenter.html");
            }
            return seoService.getCurrSeo(mav);
        } finally {
            mav = null;
            resultMap = null;
        }
    }

    /**
     * 发送手机验证码
     *
     * @throws IOException
     */
    @RequestMapping("/sendcode")
    @ResponseBody
    public int sendcode(HttpServletRequest request, String mobile,String checkCode)
            throws IOException {
        String patchca = (String) request.getSession().getAttribute("PATCHCA");
        if(checkCode!=null&&checkCode.equals(patchca)){
            request.getSession().removeAttribute("PATCHCA");
            return customerService.sendPost(request, mobile);
        }else{
            return 2;
        }
    }


    /**
     * 检查手机验证码
     *
     * @return 0不同 1相同
     * @throws IOException
     */
    @RequestMapping("validate/getMCode")
    @ResponseBody
    public int getMCode(HttpServletRequest request, String code)
            throws IOException {
        return customerService.getMCode(request, code);
    }

    /**
     * 我的账户
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/myaccount")
    public ModelAndView myaccount(HttpServletRequest request,String main) {
        // 跳转我的账户
        ModelAndView mav = null;
        Map<String, Object> resultMap = new HashMap<String, Object>();
        // main 1：个人中心跳过来的  2：设置个人资料跳过来的
        if(StringUtils.isNotBlank(main)){
            resultMap.put("main",main);
        }else{
            resultMap.put("main","2");
        }
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                request.getSession().setAttribute(
                        "cust",
                        customerService.selectByPrimaryKey((Long) request
                                .getSession().getAttribute(
                                        CustomerConstants.CUSTOMERID)));
                mav = new ModelAndView(CustomerConstants.MYACCOUNT);
                mav.addAllObjects(resultMap);
            } else {
                if(StringUtils.isNotBlank(main)&&"1".equals(main)){
                    mav = new ModelAndView(URLREDIRECTMAINONE);
                }else{
                    mav = new ModelAndView(URLREDIRECTMAINTWO);
                }

            }
            return mav;
        } finally {
            mav = null;
            resultMap = null;
        }
    }

    /**
     * 跳转到修改昵称页面
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/changenickname")
    public ModelAndView toChangeNickName(HttpServletRequest request,String main) {
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                mav = new ModelAndView(CustomerConstants.CHANGENAME);
                mav.addObject(CUSTOMER, customerService
                        .selectByPrimaryKey((Long) request.getSession()
                                .getAttribute(CustomerConstants.CUSTOMERID))).addObject("main",main);
            } else {
               // mav = new ModelAndView(URLREDIRECT);
                if(StringUtils.isNotBlank(main)&&"1".equals(main)){
                    mav = new ModelAndView(URLREDIRECTMAINONE);
                }else{
                    mav = new ModelAndView(URLREDIRECTMAINTWO);
                }

            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 修改昵称
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/savenickname")
    public ModelAndView saveNickName(HttpServletRequest request,
            Customer customers,String main) throws UnsupportedEncodingException {
        // 跳转我的账户
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                Customer customer = new Customer();
                customer.setCustomerId((Long) request.getSession()
                        .getAttribute(CustomerConstants.CUSTOMERID));
                customer.setCustomerNickname(customers.getCustomerNickname());
                this.customerService.updateCustomer(customer);
                if(StringUtils.isNotBlank(main)&&"1".equals(main)){
                    mav = new ModelAndView(RULMYACCOUNTMAINONE);
                }else {
                    mav = new ModelAndView(RULMYACCOUNTMAINTWO);
                }
                //mav = new ModelAndView(RULMYACCOUNT);
                customer = null;
            } else {
                if(StringUtils.isNotBlank(main)&&"1".equals(main)){
                    mav = new ModelAndView(URLREDIRECTMAINONE);
                }else{
                    mav = new ModelAndView(URLREDIRECTMAINTWO);
                }
                //mav = new ModelAndView(URLREDIRECT);
            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 跳转到修改姓名页面
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/changename")
    public ModelAndView toChangeName(HttpServletRequest request) {
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                mav = new ModelAndView(CustomerConstants.CHANGENAME2);
                mav.addObject(CUSTOMER, customerService
                        .selectByPrimaryKey((Long) request.getSession()
                                .getAttribute(CustomerConstants.CUSTOMERID)));
            } else {
                mav = new ModelAndView(URLREDIRECT);
            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 修改姓名
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/savename")
    public ModelAndView saveName(HttpServletRequest request,CustomerAllInfo customers)
            throws UnsupportedEncodingException {
        // 跳转我的账户
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                CustomerAllInfo customer = new CustomerAllInfo();
                customer.setCustomerId((Long) request.getSession()
                        .getAttribute(CustomerConstants.CUSTOMERID));
                customer.setInfoRealname(customers.getInfoRealname());
                this.customerService.updateCustomerInfo(customer);
                mav = new ModelAndView(RULMYACCOUNT);
                customer = null;
            } else {
                mav = new ModelAndView(URLREDIRECT);
            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 我的积分
     *
     * @param request
     * @param pb
     * @return
     */
    @RequestMapping("/myintegral")
    public ModelAndView queryCustomerPoint(HttpServletRequest request,
            PageBean pb, Long date, String type) {
        pb.setUrl("1".equals(date.toString()) ? CustomerConstants.CUSTOMER
                + "/myintegral" : CustomerConstants.CUSTOMER + "/myintegral-"
                + date);
        if (LoginUtil.checkLoginStatus(request)) {
            Long customerId = (Long) request.getSession().getAttribute(
                    CustomerConstants.CUSTOMERID);

            CustomerAllInfo customerAllInfo = customerService.selectByPrimaryKey(customerId);
            customerAllInfo.setInfoPointSum(customerAllInfo.getInfoPointSum() - customerPointServiceMapper.getCustomerReducePoint(customerId + ""));
            return new ModelAndView(CustomerConstants.MYINTEGRAL)
                    .addObject(
                            "pb",
                            customerService.selectAllCustomerPoint(customerId,
                                    pb, date, type))
                    .addObject(CUSTOMER,
                            customerAllInfo)
                    .addObject(CustomerConstants.DATE, date)
                    .addObject("type", type);
        } else {
            // 没登录的用户跳转到登录页面
            return new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
        }
    }

    /**
     * 查询我的积分加载数据
     *
     * @param request
     * @param pb
     * @return
     */
    @RequestMapping("/allmyintegral")
    @ResponseBody
    public PageBean allMyIntegral(HttpServletRequest request, PageBean pb,
            String type) {
        PageBean pbNew = pb;
        if (LoginUtil.checkLoginStatus(request)) {
            Long customerId = (Long) request.getSession().getAttribute(
                    CustomerConstants.CUSTOMERID);
            pbNew = customerService.selectAllCustomerPoint(customerId, pbNew,
                    1L, type);
        }
        return pbNew;
    }

    /**
     * 修改性别
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/changegender")
    public ModelAndView changeGender(HttpServletRequest request, String gender,String main )
            throws UnsupportedEncodingException {
        // 跳转我的账户
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                CustomerAllInfo customer = new CustomerAllInfo();
                customer.setCustomerId((Long) request.getSession()
                        .getAttribute(CustomerConstants.CUSTOMERID));
                customer.setInfoGender(gender);
                this.customerService.updateCustomerInfo(customer);
                if(StringUtils.isNotBlank(main)&&"1".equals(main)){
                    mav = new ModelAndView(RULMYACCOUNTMAINONE);
                }else {
                    mav = new ModelAndView(RULMYACCOUNTMAINTWO);
                }
                //mav = new ModelAndView(RULMYACCOUNT);
                customer = null;
            } else {
                if(StringUtils.isNotBlank(main)&&"1".equals(main)){
                    mav = new ModelAndView(URLREDIRECTMAINONE);
                }else {
                    mav = new ModelAndView(URLREDIRECTMAINTWO);
                }
                //mav = new ModelAndView(URLREDIRECT);
            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 跳到现在手机验证页
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/phonevalidate1")
    public ModelAndView phonevalidate1(HttpServletRequest request)
            throws UnsupportedEncodingException {
        // 跳转我的账户
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                mav = new ModelAndView(CustomerConstants.PHONEVALIDATE1);
                mav.addObject(
                        "custInfo",
                        customerService.selectByPrimaryKey(
                                (Long) request.getSession().getAttribute(
                                        CustomerConstants.CUSTOMERID)));
            } else {
                mav = new ModelAndView(
                        URLREDIRECT);
            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 跳转到修改绑定新手机页面
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/phonevalidate3")
    public ModelAndView phonevalidate3(HttpServletRequest request) {
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                mav = new ModelAndView(CustomerConstants.PHONEVALIDATE3);
            } else {
                mav = new ModelAndView(
                        URLREDIRECT);
            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 修改手机号
     *
     * @throws IOException
     */
    @RequestMapping("/modifyMobile")
    @ResponseBody
    public Object modifyMobile(HttpServletRequest request, String mobile,
            String code) throws IOException {
        Object flag = 0;
        // 验证登录
        if (LoginUtil.checkLoginStatus(request)) {
            int isCode = customerService.getMCode(request, code);
            // 验证码正确
            if (isCode == 1) {
                CustomerAllInfo customer = new CustomerAllInfo();
                customer.setCustomerId((Long) request.getSession()
                        .getAttribute(CustomerConstants.CUSTOMERID));
                //手机号取的是收到短信的那个手机号
                customer.setInfoMobile((String)request.getSession()
                        .getAttribute("userMobile"));
                customer.setIsMobile("1");
                // 修改手机号
                this.customerService.updateCustomerInfo(customer);
                customer = null;
                Customer customer2 = new Customer();
                customer2.setCustomerId((Long) request.getSession()
                        .getAttribute(CustomerConstants.CUSTOMERID));
                customer2.setIsMobile("1");
                this.customerService.updateCustomer(customer2);
                customer2 = null;
                flag = "/myaccount.html";
            } else {
                // 验证码错误
                flag = 2;
            }
        } else {
            flag = "/loginm.html?url=/myaccount.html";
        }
        return flag;
    }

    /**
     * 查询我的收藏
     * @param request
     * @param pb 分页
     * @return mav
     */
    @RequestMapping("/mycollections")
    public ModelAndView myCollections(HttpServletRequest request, PageBean pb){
        //定义ModelAndView
        ModelAndView mav = null;
        //判断用户登陆状态
        if (LoginUtil.checkLoginStatus(request)) {
            //用户id
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            //我的收藏页面
            mav = new ModelAndView(CustomerConstants.MYCOLLECTIONS)
            //页面数据 我的收藏
            .addObject("pb",customerFollowService.selectCustomerFollow(customerId,pb));
        }else{
             // 没登录的用户跳转到登录页面
           mav=new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
        }
        return seoService.getCurrSeo(mav);
    }

    /**
     * 根据会员和货品查询收藏记录
     *
     * @author houyichang 2015/11/3
     * */
    @RequestMapping("/ajaxcollection")
    @ResponseBody
    public int ajaxcollection(HttpServletRequest request,Long productId){
        int resultData = -1;
        //判断用户登陆状态
        if (LoginUtil.checkLoginStatus(request)) {
            //用户id
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            resultData = this.customerFollowService.selectCUstFollowByCustIdAndProId(customerId,productId);
        }
        return resultData;
    }


    /**
     * 我的收藏页面ajax加载数据
     * @param request
     * @param pb
     * @return
     */
    @RequestMapping("/allmycollection")
    @ResponseBody
    public PageBean allMyCollections(HttpServletRequest request,PageBean pb){
        PageBean pbNew = pb;
        //判断登陆状态
        if (LoginUtil.checkLoginStatus(request)) {
            //用户id
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            //我的收藏分页数据
            pbNew= customerFollowService.selectCustomerFollow(customerId,pb);
        }
        return pbNew;
    }

    /**
     * 取消关注
     * @param request
     * @return
     */
    @RequestMapping("/cancelcollection")
    @ResponseBody
    public Map<String, Object> cancelMyCollections(HttpServletRequest request,Long followId){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        int flag=0;
        if (LoginUtil.checkLoginStatus(request)) {
            //用户id
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            //取消收藏
            flag = customerFollowService.deleteFollow(followId, customerId);
            //获取收藏数量
            Long myCollectionCount = customerFollowService.myCollectionsCount((Long) request
                    .getSession().getAttribute(
                            CustomerConstants.CUSTOMERID));
            resultMap.put("flag", flag);
            resultMap.put("myCollectionCount", myCollectionCount);
        }
        return resultMap;
    }

    /**
     * 浏览记录
     * @param request
     * @param pb
     * @return
     */
    @RequestMapping("/mybrowerecord")
    public ModelAndView myBrowserecord(HttpServletRequest request,PageBean pb){
        //定义ModelAndView
        ModelAndView mav = null;
        //判断用户登陆状态
        if (LoginUtil.checkLoginStatus(request)) {
            //用户id
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            //浏览记录页面
            mav = new ModelAndView(CustomerConstants.BROWSERECORD)
            //页面数据 我的收藏
            .addObject("pb",browserecordService.selectBrowserecord(customerId, pb));
        }else{
             // 没登录的用户跳转到登录页面
           mav=new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
        }
        return seoService.getCurrSeo(mav);
    }


    /**
     * 加载我的浏览记录
     * @param request
     * @param pb
     * @return
     */
    @RequestMapping("/allbrowerecord")
    @ResponseBody
    public PageBean allMyBrowerecord(HttpServletRequest request,PageBean pb){
        PageBean pbNew = pb;
        //判断登陆状态
        if (LoginUtil.checkLoginStatus(request)) {
            //用户id
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            //浏览记录分页数据
            pbNew= browserecordService.selectBrowserecord(customerId, pbNew);
        }
        return pbNew;
    }

    /**
     * 清空浏览记录
     *
     * @return
     */
    @RequestMapping("/browerecord/remove")
    @ResponseBody
    public int delAddress(HttpServletRequest request, Long likeId) {
        // 获得用户Id
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
        // 判断是否登录
        if (customerId != null) {
            browserecordService.deleteByPrimaryKey(likeId,customerId);
            return 1;
        } else {
            // 去登录
            return 0;
        }
    }



    /**
     * 跳转到账号安全页面
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/accountsafe")
    public ModelAndView safe(HttpServletRequest request) {
        ModelAndView mav = null;
        //登陆验证
        if (LoginUtil.checkLoginStatus(request)) {
            mav = new ModelAndView(CustomerConstants.ACCOUNTSAFE);
        } else {
            mav = new ModelAndView(URLREDIRECT);
        }
        return mav;
    }

    /**
     * 跳转到账号安全页面
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/tochangepassword")
    public ModelAndView tochangepassword(HttpServletRequest request) {
        ModelAndView mav = null;
        //登陆验证
        if (LoginUtil.checkLoginStatus(request)) {
            mav = new ModelAndView(CustomerConstants.CHANGEPASSWORD);
        } else {
            mav = new ModelAndView(URLREDIRECT);
        }
        return mav;
    }

    /**
     * 修改密码
     *
     * @return
     */
    @RequestMapping("/modifypassword")
    @ResponseBody
    public Object modifypassword(HttpServletRequest request, HttpServletResponse response, String password, String newPassword,String code) {
        //登陆验证
        if (LoginUtil.checkLoginStatus(request)) {

            // 判断输入的验证码是否正确
//            if (!request.getSession().getAttribute("PATCHCA").equals(code)) {
//                return -1;
//            }
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            //添加系统消息
            AvatarNotice avatarNotice=new AvatarNotice();
            avatarNotice.setCustomerId(customerId);
            avatarNotice.setIsRead("0");
            avatarNotice.setNoticeTitle("您的登录密码修改成功");
            avatarNotice.setNoticeContent("您的登录密码已修改成功，请妥善保存！");
            avatarNotice.setCreateTime(new Date());
            this.customerServiceMapper.addAvatarNatice(avatarNotice);
            return this.customerService.modifyPassword(request, response, password, newPassword);
        } else {
            return "/loginm.html?url=/myaccount.html";
        }
    }

    /**
     * 安全提示
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/tosafetips")
    public ModelAndView tosafetips(HttpServletRequest request) {
        //登陆验证
        if (LoginUtil.checkLoginStatus(request)) {
            return new ModelAndView("member/my_account_safe_tips");
        } else {
            return new ModelAndView(URLREDIRECT);
        }
    }

    /**
     * 安全提示
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/phonevalidate4")
    public ModelAndView phonevalidate4(HttpServletRequest request) {
        //登陆验证
        if (LoginUtil.checkLoginStatus(request)) {
            return new ModelAndView("member/phonevalidate4");
        } else {
            return new ModelAndView(URLREDIRECT);
        }
    }

    /**
     * 跳转到修改qq页面
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/changeqq")
    public ModelAndView toChangeQq(HttpServletRequest request) {
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                mav = new ModelAndView(CustomerConstants.CHANGEQQ);
                mav.addObject(CUSTOMER, customerService
                        .selectByPrimaryKey((Long) request.getSession()
                                .getAttribute(CustomerConstants.CUSTOMERID)));
            } else {
                mav = new ModelAndView(URLREDIRECT);
            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 修改qq
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/saveqq")
    public ModelAndView saveQq(HttpServletRequest request, String changeQq)
            throws UnsupportedEncodingException {
        // 跳转我的账户
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                CustomerAllInfo customer = new CustomerAllInfo();
                customer.setCustomerId((Long) request.getSession()
                        .getAttribute(CustomerConstants.CUSTOMERID));
                customer.setInfoQQ(changeQq);
                this.customerService.updateCustomerInfo(customer);
                mav = new ModelAndView(RULMYACCOUNT);
                customer = null;
            } else {
                mav = new ModelAndView(URLREDIRECT);
            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 安全验证，验证身份
     *
     * @return 0登陆 1通过 2验证码错误 3密码错误
     * @throws IOException
     */
    @RequestMapping("validate/checkidentity")
    @ResponseBody
    public int checkidentity(HttpServletRequest request, String valiCode,String password)
            throws IOException {
        if (LoginUtil.checkLoginStatus(request)) {
            return this.customerService.checkIdentity(request, valiCode, password);
        } else {
            return 0;
        }
    }

    @RequestMapping("/customers/notice")
    public ModelAndView notice(HttpServletRequest request,String mark){
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
        // 验证登录
        if (LoginUtil.checkLoginStatus(request)) {
            OrderNotice orderNotice = orderNoticeService.getUnReadAndNewNotice(customerId);
            int flag = 0;
            InsideLetterVo insideLetterVo = insideLetterServiceMapper.getUnReadAndNewNotice(customerId);
            if(orderNotice.getNoticeTitle() != null && insideLetterVo.getLetterTitle() != null){
                flag = orderNotice.getCreateTime().getTime() > insideLetterVo.getCreateTime().getTime() ? 0:1;
            }
            return new ModelAndView("member/notice").addObject("orderNotice",orderNotice).addObject("insideLetterVo",insideLetterVo).addObject("flag",flag).addObject("mark",mark);
        }else{
            return new ModelAndView(URLREDIRECT);
        }
    }

    /**
     * 修改生日
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/changebirthday")
    public ModelAndView changeBirthday(HttpServletRequest request, String birthday,String main)
            throws UnsupportedEncodingException {
        // 跳转我的账户
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                CustomerAllInfo customer = new CustomerAllInfo();
                customer.setCustomerId((Long) request.getSession()
                        .getAttribute(CustomerConstants.CUSTOMERID));
                customer.setInfoBirthday(birthday);
                this.customerService.updateCustomerInfo(customer);
                if("1".equals(main)){
                    mav = new ModelAndView(RULMYACCOUNTMAINONE);
                }else{
                    mav = new ModelAndView(RULMYACCOUNTMAINTWO);
                }
              //  mav = new ModelAndView(RULMYACCOUNT);
                customer = null;
            } else {
                if("1".equals(main)){
                    mav = new ModelAndView(URLREDIRECTMAINONE);
                }else{
                    mav = new ModelAndView(URLREDIRECTMAINTWO);
                }

            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 跳转到修改邮箱页面
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/changeemail")
    public ModelAndView toChangeEmail(HttpServletRequest request,String main) {
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                mav = new ModelAndView(CustomerConstants.CHANGEEMAIL);
                mav.addObject(CUSTOMER, customerService
                        .selectByPrimaryKey((Long) request.getSession()
                                .getAttribute(CustomerConstants.CUSTOMERID))).addObject("main",main);
            } else {
                if("1".equals(main)){
                    mav = new ModelAndView(URLREDIRECTMAINONE);
                }else{
                    mav = new ModelAndView(URLREDIRECTMAINTWO);
                }

            }
            return mav;
        } finally {
            mav = null;
        }
    }

    /**
     * 修改邮箱
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/saveemail")
    public ModelAndView saveEmail(HttpServletRequest request,
                                  CustomerAllInfo customers,String main) throws UnsupportedEncodingException {
        // 跳转我的账户
        ModelAndView mav = null;
        try {
            // 验证登录
            if (LoginUtil.checkLoginStatus(request)) {
                CustomerAllInfo customer = new CustomerAllInfo();
                customer.setCustomerId((Long) request.getSession()
                        .getAttribute(CustomerConstants.CUSTOMERID));
                customer.setInfoEmail(customers.getInfoEmail());
                this.customerService.updateCustomerInfo(customer);
                if("1".equals(main)){
                    mav = new ModelAndView(RULMYACCOUNTMAINONE);
                }else{
                    mav = new ModelAndView(RULMYACCOUNTMAINTWO);
                }

                customer = null;
            } else {
                if("1".equals(main)){
                    mav = new ModelAndView(URLREDIRECTMAINONE);
                }else{
                    mav = new ModelAndView(URLREDIRECTMAINTWO);
                }

            }
            return mav;
        } finally {
            mav = null;
        }
    }

    @RequestMapping("/customer/mygiftcard")
    public ModelAndView queryGiftcard(HttpServletRequest request, PageBean pb){
        // 验证登录
        if (LoginUtil.checkLoginStatus(request)) {
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("customerId", customerId);
            //查询该会员下资产总额
            DepositInfo depositInfo = depositInfoService.queryDepositInfo(customerId);
            pb = tradeInfoService.queryTradeInfo(pb, paramMap);

            return new ModelAndView("customer/giftcard").addObject("deposit",depositInfo).addObject("pb",pb);
        }else{
            return new ModelAndView(URLREDIRECT);
        }
    }

    @RequestMapping("/queryTradeInfoAjax")
    @ResponseBody
    public Map queryTradeInfoAjax(HttpServletRequest request, PageBean pb){
        Map<String, Object> resultMap = new HashMap<>();
        // 检查用户是否登录
        if (LoginUtil.checkLoginStatus(request)) {
            Map<String, Object> paramMap = new HashMap<>();
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            paramMap.put(CustomerConstants.CUSTOMERID, customerId);
            pb = tradeInfoService.queryTradeInfo(pb, paramMap);
            resultMap.put("pb", pb);
        }
        return resultMap;
    }

}
