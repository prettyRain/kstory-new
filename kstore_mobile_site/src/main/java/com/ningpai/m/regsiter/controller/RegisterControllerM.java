/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.m.regsiter.controller;

import com.ningpai.coupon.bean.CouponNo;
import com.ningpai.coupon.service.CouponNoService;
import com.ningpai.customer.bean.Customer;
import com.ningpai.customer.bean.RegisterPoint;
import com.ningpai.customer.service.CustomerPointServiceMapper;
import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.m.common.service.SeoService;
import com.ningpai.m.customer.service.CustomerService;
import com.ningpai.m.customer.vo.CustomerConstants;
import com.ningpai.m.login.service.LoginService;
import com.ningpai.m.regsiter.controller.service.RegisterService;
import com.ningpai.m.weixin.bean.ThreePart;
import com.ningpai.m.weixin.service.ThreePartService;
import com.ningpai.marketing.bean.RegisterMarketing;
import com.ningpai.marketing.service.MarketingService;
import com.ningpai.other.bean.CustomerAllInfo;
import com.ningpai.other.bean.IntegralSet;
import com.ningpai.other.util.IPAddress;
import org.elasticsearch.common.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 手机端注册Controller
 *
 * @author NINGPAI-zhangqiang
 * @version 0.0.1
 * @since 2014年8月21日 下午5:09:05
 */
@Controller
public class RegisterControllerM {

    // spring 注解 会员服务Service
    private CustomerServiceMapper customerServiceMapper;
    private CustomerPointServiceMapper customerPointServiceMapper;

    @Resource(name = "SeoService")
    private SeoService seoService;

    @Resource(name = "registerServiceM")
    private RegisterService registerService;

    @Resource(name = "loginServiceM")
    private LoginService loginService;

    @Resource(name = "customerServiceM")
    private CustomerService customerService;

    @Resource(name = "MarketingService")
    private MarketingService marketingService;

    @Resource(name = "CouponNoService")
    private CouponNoService couponNoService;

    @Resource(name="threePartServiceM")
    private ThreePartService threePartService;

    Date startTime = null;

    Date endTime = null;
    // 是否赠送优惠卷
    int count = 0;
    private static final String CUSTOMERID = "customerId";

    /**
     * 跳转注册页面
     *
     * @return {@link ModelAndView}
     */
    @RequestMapping("/customer/register")
    public ModelAndView toRegister(String url) {

        return new ModelAndView(CustomerConstants.REGOSTER).addObject("url", url);
    }

    /**
     * 验证手机号是否已注册
     *
     * @param mobile
     * @return
     */
    @RequestMapping("/customer/mobileExist")
    @ResponseBody
    public int mobileExist(HttpServletRequest request, HttpServletResponse response, String mobile) throws UnsupportedEncodingException {
        return registerService.checkCustomerExists(request, response, mobile, null);
    }

    /**
     * 跳转到注册第二步页面
     *
     * @param url
     * @return
     */
    @RequestMapping("/customer/registersecond")
    public ModelAndView toRegisterSecond(String url, String mobile) {

        return new ModelAndView(CustomerConstants.REGISTERSECOND).addObject("mobile", mobile).addObject("url", url);
    }

    /**
     * 验证手机验证码是否正确
     *
     * @param code
     * @return
     */
    @RequestMapping("/customer/checkCode")
    @ResponseBody
    public int checkCode(HttpServletRequest request, String code) {
        try {
            if (!code.equals((int) request.getSession().getAttribute("mcCode") + "")) {
                return 1;
            }
        }catch(Exception e){
            //session中没有mcCode
            return 1;
        }
        return 0;
    }

    /**
     *
     * @param request
     * @param response
     * @param mobile
     * @param code
     * @param partType
     * @param url
     * @param openId
     * @param accessToken
     * @return 1：code错误  2：未注册  3：该手机号已与这种登录方式绑定  4：用户被冻结  5：用户被锁定
     */
    @RequestMapping("/checkCodeAndLonginPart")
    @ResponseBody
    public String checkCodeAndLonginPart(HttpServletRequest request,HttpServletResponse response,String mobile,String code,String partType,String url,String openId,String accessToken){
        try {
            if (!code.equals(request.getSession().getAttribute("mcCode").toString())) {
                return "1";
            }
            if(!mobile.equals(request.getSession().getAttribute("userMobile").toString())){
                return "1";
            }

            int isExists = registerService.checkCustomerExists(request, response, mobile, null);
            //根据手机号和第三方登录方式 查询该手机号是否已与这种登录方式绑定
            int isBound  = customerService.queryPartByMobile(mobile,partType);
            if(isBound==4){
                //没有绑定

                    //已注册
                    if(isExists==1){
                        //进行绑定
                        Map map = new HashMap();
                        map.put("uType", "mobile");
                        map.put("username",mobile);
                        com.ningpai.m.customer.bean.Customer customer = customerService.selectCustomerByCustNameAndType(map);
                        ThreePart threePart = new ThreePart();
                        threePart.setThreePartMemberId(customer.getCustomerId());
                        threePart.setThreePartUid(openId);
                        threePart.setThreePartToken(accessToken);
                        threePart.setThreePartType(partType);
                        threePartService.insertThreePart(threePart);
                        //修改登录时间  登录ip 赠送积分
                        int loginmstate = loginService.threePartLoginm(customer, response);
                         if(loginmstate==0){
                            //用户被冻结
                            return "4";

                        }else if(loginmstate==5){
                            //用户被锁定
                            return "5";
                        }else{
                            //登录成功
                             return url;
                         }
                    }else {
                        //未注册
                        return "2";
                    }
            }else {
                //已绑定
                return "3";
            }

        }catch(Exception e){
            //session中没有mcCode
            e.printStackTrace();
            return "1";
        }


    }


    /**
     * 跳转到注册第三步页面
     *
     * @param url
     * @return
     */
    @RequestMapping("/customer/registerthird")
    public ModelAndView toRegisterThird(String url, String mobile) {

        return new ModelAndView(CustomerConstants.REGISTERTHIRD).addObject("mobile", mobile).addObject("url", url);
    }

    /**
     * 注册（新）
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws ParseException
     */
    @RequestMapping("/registerNew")
    @ResponseBody
    public Object registerNew(HttpServletRequest request, HttpServletResponse response, String mobile, String password, String repassword, String url, String custId) throws UnsupportedEncodingException, ParseException {
        if (mobile == null || password == null || repassword == null) {
            throw new NullPointerException();
        }
        //如果URL为空，跳回首页
        if (url == null || "".equals(url)) {
            url = "main.html";
        }
        CustomerAllInfo allInfo = new CustomerAllInfo();
        Object flag;
        allInfo.setCustomerUsername(mobile);
        allInfo.setCustomerPassword(password);
        allInfo.setLoginIp(IPAddress.getIpAddrTwo(request));
        allInfo.setLoginTime(new Date());
        allInfo.setIsSeller("0");
        allInfo.setIsMobile("1");
        synchronized (this) {
            // 判断用户名是否存在
            Long isUsernameFlag = customerServiceMapper.selectCustomerByName(allInfo.getCustomerUsername());
            // 如果不存在则注册
            if (isUsernameFlag == 0) {
                customerServiceMapper.addCustomer(allInfo);
                loginService.checkCustomerExists(request, response, mobile, password, null, "1");
                Long customerId = (Long) request.getSession().getAttribute(CUSTOMERID);
                if (null != custId && !"null".equals(custId) && !"".equals(custId)) {

                    Long cusId = Long.valueOf(custId);
                    customerPointServiceMapper.addIntegralByType(cusId, "5");
                    // 保存推广注册成功的信息
                    registPoint(request, cusId, allInfo.getCustomerUsername());
                }
                customerPointServiceMapper.addIntegralByType(customerId, "0");
//            customerPointServiceMapper.addIntegralByType(customerId, "1");

                // 判断注册送优惠券是否开启
                RegisterMarketing registerMarketing = marketingService.findRegisterMarketing();

                //如果活动开启，发放优惠券
                if (registerMarketing != null && registerMarketing.getIsUsed() != null && Integer.parseInt(registerMarketing.getIsUsed()) == 1) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    //活动开始时间，结束时间
                    startTime = sdf.parse(registerMarketing.getStartTime());
                    endTime = sdf.parse(registerMarketing.getEndTime());
                    Date date = new Date();
                    // 判断活动开启关闭时间
                    if (startTime.before(date) && endTime.after(date)) {
                        // 判断该优惠券是否还有
                        count = couponNoService.selectCouponNoByStatus(registerMarketing.getRegisterCouponId());
                        if (count > 0) {
                            // 根据优惠券id随机获取一张未使用的优惠券码
                            CouponNo couponNo = couponNoService.selectNoByCouponIdByStatus(registerMarketing.getRegisterCouponId());
                            // 获取用户id 把优惠券给用户
                            couponNoService.updateCouponCustomer(couponNo.getCodeId(), customerId);
                        }
                    }
                }
            }
                flag = "/" + url.replaceFirst(request.getContextPath() + "/", "");
                if (count > 0) {
                    //到优惠券页面
                    flag = "1";
                }
                try{
                    String openId = request.getParameter("openId");
                    String accessToken = request.getParameter("accessToken");
                    String partType = request.getParameter("partType");
                    Long customerId = (Long) request.getSession().getAttribute(CUSTOMERID);
                    if(org.apache.commons.lang.StringUtils.isNotBlank(openId)&&org.apache.commons.lang.StringUtils.isNotBlank(accessToken)){
                        ThreePart threePart = new ThreePart();
                        threePart.setThreePartMemberId(customerId);
                        threePart.setThreePartUid(openId);
                        threePart.setThreePartToken(accessToken);
                        threePart.setThreePartType(partType);
                        threePartService.insertThreePart(threePart);
                    }


                }catch (Exception e){
                    return flag;
                }
            return flag;
        }
    }

    @RequestMapping("/mobileExistAndSendcodereg")
    @ResponseBody
    public int mobileExistAndSendcodereg(HttpServletRequest request, String mobile,HttpServletResponse response)throws Exception{
        int isExists = registerService.checkCustomerExists(request, response, mobile, null);
        if(isExists==2){
            //用户不存在
            return 2;
        }
        //1成功 0失败
        return  customerService.sendPost(request, mobile);

    }
    /**
     * 发送手机验证码（新）
     *
     * @throws IOException
     */
    @RequestMapping("/sendcoderegNew")
    @ResponseBody
    public int sendcodeRegNew(HttpServletRequest request, String mobile) {
        return customerService.sendPost(request, mobile);
    }

    /**
     * 注册
     *
     * @param request
     * @param allInfo
     * @return
     * @throws ParseException
     */
    @RequestMapping("/customer/addcustomer")
    public ModelAndView register(HttpServletRequest request, @Valid CustomerAllInfo allInfo, String code) throws ParseException {
        if (allInfo.getCustomerUsername() == null || allInfo.getCustomerPassword() == null || code == null || (code != null && code.trim().length() == 0)) {
            throw new NullPointerException();
        }
        if (!code.equals((int) request.getSession().getAttribute("mcCode") + "")) {
            throw new IllegalArgumentException();
        }
        allInfo.setLoginIp(IPAddress.getIpAddr(request));
        allInfo.setIsSeller("0");
        allInfo.setIsMobile("1");
        allInfo.setLoginTime(new Date());
        customerServiceMapper.addCustomer(allInfo);
        //loginService.checkCustomerExists(request, allInfo.getCustomerUsername(), allInfo.getCustomerPassword());
        Long customerId = (Long) request.getSession().getAttribute(CUSTOMERID);
        customerPointServiceMapper.addIntegralByType(customerId, "0");
        customerPointServiceMapper.addIntegralByType(customerId, "1");
        return new ModelAndView("redirect:/customercenter.html");
    }

    /**
     * 注册
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws ParseException
     */
    @RequestMapping("/register")
    @ResponseBody
    public Object register2(HttpServletRequest request, HttpServletResponse response, String code, String mobile, String password, String repassword, String url, String custId) throws UnsupportedEncodingException, ParseException {
        if (mobile == null || password == null || repassword == null || code == null || code.trim().length() == 0) {
            throw new NullPointerException();
        }
        //如果URL为空，跳回首页
        if (url == null || "".equals(url)) {
            url = "main.html";
        }


        CustomerAllInfo allInfo = new CustomerAllInfo();
        Object flag;
        int exist = registerService.checkCustomerExists(request, response, mobile, password);
        //已存在
        if (exist == 1) {
            flag = 1;
        } else if (!code.equals((int) request.getSession().getAttribute("mcCode") + "")) {
            //验证码错误
            flag = 2;
        } else {
            allInfo.setCustomerUsername(mobile);
            allInfo.setCustomerPassword(password);
            allInfo.setLoginIp(IPAddress.getIpAddr(request));
            allInfo.setLoginTime(new Date());
            allInfo.setIsSeller("0");
            allInfo.setIsMobile("1");
            customerServiceMapper.addCustomer(allInfo);
            loginService.checkCustomerExists(request, response, mobile, password, null, "1");
            Long customerId = (Long) request.getSession().getAttribute(CUSTOMERID);
            if (null != custId && !"null".equals(custId) && !"".equals(custId)) {

                Long cusId = Long.valueOf(custId);
                customerPointServiceMapper.addIntegralByType(cusId, "5");
                // 保存推广注册成功的信息
                registPoint(request, cusId, allInfo.getCustomerUsername());
            }
            customerPointServiceMapper.addIntegralByType(customerId, "0");
//            customerPointServiceMapper.addIntegralByType(customerId, "1");

            // 判断注册送优惠券是否开启
            RegisterMarketing registerMarketing = marketingService.findRegisterMarketing();

            //如果活动开启，发放优惠券
            if (registerMarketing != null && registerMarketing.getIsUsed() != null && Integer.parseInt(registerMarketing.getIsUsed()) == 1) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                //活动开始时间，结束时间
                startTime = sdf.parse(registerMarketing.getStartTime());
                endTime = sdf.parse(registerMarketing.getEndTime());
                Date date = new Date();
                // 判断活动开启关闭时间
                if (startTime.before(date) && endTime.after(date)) {
                    // 判断该优惠券是否还有
                    count = couponNoService.selectCouponNoByStatus(registerMarketing.getRegisterCouponId());
                    if (count > 0) {
                        // 根据优惠券id随机获取一张未使用的优惠券码
                        CouponNo couponNo = couponNoService.selectNoByCouponIdByStatus(registerMarketing.getRegisterCouponId());
                        // 获取用户id 把优惠券给用户
                        couponNoService.updateCouponCustomer(couponNo.getCodeId(), customerId);
                    }
                }
            }
            flag = "/" + url.replaceFirst(request.getContextPath() + "/", "");
        }
        return flag;
    }

    /**
     * 保存推广链接注册信息
     *
     * @return
     */
    protected int registPoint(HttpServletRequest request, Long customerId, String customerUsername) {
        int result = 0;
        IntegralSet inte = customerPointServiceMapper.findPointSet();
        // 根据ID获取会员对象
        Customer customer = customerPointServiceMapper.selectCusById(customerId);
        // 推广注册信息
        RegisterPoint point = new RegisterPoint();
        point.setRegPointReferee(customer.getCustomerUsername()); // 推荐人
        point.setRegPointRecom(customerUsername);// 被推荐人
        point.setRegPointNumber(inte.getPsetUser()); // 注册赠送的积分
        point.setRegPointTime(new Date()); // 推广注册时间
        result = customerPointServiceMapper.insertRegisterPoint(point);
        return result;
    }

    /**
     * 发送手机验证码
     *
     * @throws IOException
     */
    @RequestMapping("/sendcodereg")
    @ResponseBody
    public int sendcodeReg(HttpServletRequest request, HttpServletResponse response, String mobile, String checkCode)
            throws IOException {
        int exist = registerService.checkCustomerExists(request, response, mobile, checkCode);
        String patchca = (String) request.getSession().getAttribute("PATCHCA");
        //已存在
        if (exist == 1) {
            return 2;
        }
        /*if (patchca != null && patchca != "" && patchca.equals(checkCode)) {
            request.getSession().removeAttribute("patchca");
            return customerService.sendPost(request, mobile);
        } else {
            return 3;
        }*/
        return customerService.sendPost(request, mobile);
    }

    public CustomerServiceMapper getCustomerServiceMapper() {
        return customerServiceMapper;
    }

    @Resource(name = "customerServiceMapper")
    public void setCustomerServiceMapper(CustomerServiceMapper customerServiceMapper) {
        this.customerServiceMapper = customerServiceMapper;
    }

    public CustomerPointServiceMapper getCustomerPointServiceMapper() {
        return customerPointServiceMapper;
    }

    @Resource(name = "customerPointServiceMapper")
    public void setCustomerPointServiceMapper(CustomerPointServiceMapper customerPointServiceMapper) {
        this.customerPointServiceMapper = customerPointServiceMapper;
    }
}
