/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.m.weixin.controller;

import com.alibaba.fastjson.JSONObject;
import com.ningpai.customer.bean.Customer;
import com.ningpai.customer.dao.CustomerMapper;
import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.logger.util.OperaLogUtil;
import com.ningpai.m.customer.service.CustomerService;
import com.ningpai.m.login.service.LoginService;
import com.ningpai.m.weixin.bean.ThreePart;
import com.ningpai.m.weixin.service.ThreePartService;
import com.ningpai.m.weixin.util.WeiXinUtil;
import com.ningpai.system.bean.Auth;
import com.ningpai.system.bean.Pay;
import com.ningpai.system.service.AuthService;
import com.ningpai.system.service.PayService;
import com.ningpai.util.MyLogger;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 微信回调
 *
 * @author NINGPAI-zhangqiang
 * @since 2014年8月26日 下午4:14:20
 * @version 0.0.1
 */
@Controller
public class AfterWeiXinController {

    private static final String NEWREDIRECT = "/main.html";
    private static final String REDIRECT = "redirect:/main.html";
    private static final String SECRET = "&secret=";
    private static final String URLINFO1 = "&grant_type=authorization_code";
    private static final String UTF8 = "utf-8";
    private static final String OPENID = "openid";
    private static final String ACCESSTOKEN = "access_token";
    private static final String URLINFO2 = "https://api.weixin.qq.com/sns/userinfo?access_token=";
    private static final String URLOPENID = "&openid=";
    private static final String URLLANG = "&lang=zh_CN";
    private static final String URLINFO3 = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=";
    private static final String CODE = "&code=";

    private static MyLogger LOGGER = new MyLogger(AfterWeiXinController.class);

    private AuthService authService;

    private CustomerMapper customerMapper;

    private CustomerServiceMapper customerServiceMapper;

    private CustomerService customerService;

    private ThreePartService threePartService;

    @Resource(name = "payService")
    private PayService payService;

    // spring 注解 登录service
    private LoginService loginService;
    public LoginService getLoginService() {
        return loginService;
    }

    @Resource(name = "loginServiceM")
    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }

    /**
     * 获取微信用户Code
     *
     * @param request
     * @param response
     * @throws java.io.IOException
     * @throws org.apache.commons.httpclient.HttpException
     */
    @RequestMapping("getwxtoken")
    protected ModelAndView getWXToken(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 获取code
        String code = request.getParameter("code");
        if (code == null) {
            return new ModelAndView(REDIRECT);
        }
        // 获取微信接口AppId...
        Auth auth = authService.findAuthByAuthType("9");
        if (auth != null) {
            String url = URLINFO3 + auth.getAuthClientId() + SECRET + auth.getAuthClientSecret() + CODE + code + URLINFO1;
            GetMethod getTokenMethod = new GetMethod(url);
            HttpClient clientToken = new HttpClient();
            getTokenMethod.getParams().setContentCharset(UTF8);
            String res = "";
            Map<String, String> resultMap = null;
            try {
                // 获取token
                clientToken.executeMethod(getTokenMethod);
                res = getTokenMethod.getResponseBodyAsString();
                resultMap = WeiXinUtil.getWeiToken(res);
                if (resultMap == null) {
                    return throwNullPointer(request);
                }
                url = URLINFO2 + resultMap.get(ACCESSTOKEN) + URLOPENID + resultMap.get(OPENID) + URLLANG;
                GetMethod getTokenInfo = new GetMethod(url);
                HttpClient clientInfo = new HttpClient();
                getTokenInfo.getParams().setContentCharset(UTF8);
                res = "";
                try {
                    getWXLogin(request, code, resultMap, getTokenInfo, clientInfo,response);
                } catch (Exception e) {
                    // 获取token失败
                    OperaLogUtil.addOperaException("获取token失败!", e, request);
                    return new ModelAndView(REDIRECT);
                }

            } catch (Exception e) {
                // 发送获取token请求失败
                OperaLogUtil.addOperaException("发送获取token请求失败!", e, request);
                return new ModelAndView(REDIRECT);
            }
        } else {
            try {
                // 微信接口数据未获取 throw NullPointerException...
                throw new NullPointerException();
            } catch (Exception e) {
                OperaLogUtil.addOperaException("获取微信设置失败!", e, request);
                return new ModelAndView(REDIRECT);
            }
        }
        return new ModelAndView("redirect:/addcouponpx.htm");
    }

    private ModelAndView throwNullPointer(HttpServletRequest request) {
        try {
            // 获取数据失败 throw NullPointerException ...
            throw new NullPointerException();
        } catch (Exception e) {
            // 获取token失败
            OperaLogUtil.addOperaException("获取token失败!", e, request);
            return new ModelAndView(REDIRECT);
        }
    }

    /**
     * 获取微信用户Code
     *
     * @param request
     * @param response
     * @throws java.io.IOException
     * @throws org.apache.commons.httpclient.HttpException
     */
    @RequestMapping("getwxtoken1")
    protected ModelAndView getWXToken1(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String openid = null;
        // 获取code
        String code = request.getParameter("code");
        //获取state state携带的参数是payid-cardNum-orderCode-orderId-payPrice
        String state = request.getParameter("state");
        if (code == null || state == null) {
            return new ModelAndView(REDIRECT);
        }
        System.out.println("payid-cardNum-orderCode-orderId-payPrice-----------------------------" + state);
        //payid-cardNum-orderCode-orderId-payPrice
        //支付时根据收货地址对应的appid和密钥获取openid
        if (!("1".equals(state)) && state.indexOf("-") != -1) {
            //支付方式
            List<Object> pays = payService.queryAllPaySet();
            //获取参数
            String[] split = state.split("-");
            //礼品卡
            int cardNum = Integer.valueOf(split[1]);
            //订单编号
            String orderCode = split[2];
            //订单id
            Long orderId = Long.valueOf(split[3]);
            //支付金额
            BigDecimal payPrice = BigDecimal.valueOf(Double.valueOf(split[4]));
            //微信支付payid
            Long payid = Long.valueOf(split[0]);
            Pay pay = null;
            pay = payService.findByPayId(Long.valueOf(payid));
            if (pay != null) {
                String url = URLINFO3 + pay.getApiKey() + SECRET + pay.getSecretKey() + CODE + code + URLINFO1;
                GetMethod getTokenMethod = new GetMethod(url);
                HttpClient clientToken = new HttpClient();
                getTokenMethod.getParams().setContentCharset(UTF8);
                String res = "";
                Map<String, String> resultMap = null;
                try {
                    // 获取token
                    clientToken.executeMethod(getTokenMethod);
                    res = getTokenMethod.getResponseBodyAsString();
                    resultMap = WeiXinUtil.getWeiToken(res);
                    if (resultMap == null) {
                        return new ModelAndView(REDIRECT);
                    }

                    openid = resultMap.get(OPENID);
                    System.out.println("openid-------------------------------------------------------" + openid);
                    //微信支付时用到的openid
                    request.getSession().setAttribute("payopenid", openid);
                    return new ModelAndView("order/payment").addObject("cardNum", cardNum).addObject("orderCode", orderCode).addObject("orderId", orderId).addObject("payPrice", payPrice).addObject("pays", pays);

                } catch (Exception e) {
                    // 发送获取token请求失败
                    OperaLogUtil.addOperaException("Sending getwxtoken request failed!", e, request);
                    return new ModelAndView(REDIRECT);
                }
            } else {
                try {
                    // 微信接口数据未获取 throw NullPointerException...
                    throw new NullPointerException();
                } catch (Exception e) {
                    OperaLogUtil.addOperaException("Getting WEIXIN set failed!", e, request);
                    return new ModelAndView(REDIRECT);
                }
            }

            //微信登录时获取openid
        } else if (!("1".equals(state)) && state.indexOf("-") == -1) {


            // 获取微信接口AppId...
            Auth auth = authService.findAuthByAuthType("9");
            if (auth != null) {
                String url = URLINFO3 + auth.getAuthClientId() + SECRET + auth.getAuthClientSecret() + CODE + code + URLINFO1;
                GetMethod getTokenMethod = new GetMethod(url);
                HttpClient clientToken = new HttpClient();
                getTokenMethod.getParams().setContentCharset(UTF8);
                String res = "";
                Map<String, String> resultMap = null;
                try {
                    // 获取token
                    clientToken.executeMethod(getTokenMethod);
                    res = getTokenMethod.getResponseBodyAsString();
                    resultMap = WeiXinUtil.getWeiToken(res);
                    if (resultMap == null) {
                        return new ModelAndView(REDIRECT);
                    }
                    Map userMap = WeiXinUtil.getWeiXinJosn(res);

                    // 验证存在 用户已存在 直接登录 用户不存在 则执行注册流程
                    String unionid = userMap.get("\"unionid\"").toString().substring(1,userMap.get("\"unionid\"").toString().length()-2);
                   ThreePart tp = threePartService.selectThreePart(unionid);
                    if(tp!=null){
                        com.ningpai.m.customer.bean.Customer cus = this.customerService.selectCustomermByPrimaryKey(tp.getThreePartMemberId());

                        if(cus==null){
                            this.threePartService.deleteThreepart(unionid);
                            //如果没有与用户绑定就跳到登录页
                            return new ModelAndView("login/third_party").addObject("openId",unionid).addObject("accessTokenn",resultMap.get(ACCESSTOKEN)).addObject("url",state).addObject("partType","2");
                        }
                        //修改登录时间  登录ip 赠送积分
                        int loginstate = loginService.threePartLoginm(cus,response);
                        if(loginstate==1){
                            //登录成功
                            return new ModelAndView(new RedirectView(state));
                        }else{
                            //已冻结或已锁定
                            return new ModelAndView("login/loginm");
                        }
                    }else{

                        //如果没有与用户绑定就跳到登录页
                        return new ModelAndView("login/third_party").addObject("openId",unionid).addObject("accessTokenn",resultMap.get(ACCESSTOKEN)).addObject("url",state).addObject("partType","2");
                    }

                } catch (Exception e) {
                    // 发送获取token请求失败
                    OperaLogUtil.addOperaException("Sending getwxtoken request failed!", e, request);
                    return new ModelAndView(REDIRECT);
                }
            } else {
                try {
                    // 微信接口数据未获取 throw NullPointerException...
                    throw new NullPointerException();
                } catch (Exception e) {
                    OperaLogUtil.addOperaException("Getting WEIXIN set failed!", e, request);
                    return new ModelAndView(REDIRECT);
                }
            }
            //获取用户信息
        } else {
            // 获取微信接口AppId...
            Auth auth = authService.findAuthByAuthType("9");
            if (auth != null) {
                String url = URLINFO3 + auth.getAuthClientId() + SECRET + auth.getAuthClientSecret() + CODE + code + URLINFO1;
                GetMethod getTokenMethod = new GetMethod(url);
                HttpClient clientToken = new HttpClient();
                getTokenMethod.getParams().setContentCharset(UTF8);
                String res = "";
                Map<String, String> resultMap = null;
                try {
                    // 获取token
                    clientToken.executeMethod(getTokenMethod);
                    res = getTokenMethod.getResponseBodyAsString();
                    resultMap = WeiXinUtil.getWeiToken(res);
                    Map<String, String> userMap;
                    userMap = WeiXinUtil.getWeiXinInfo(res);
                    if (resultMap == null) {
                        return new ModelAndView(REDIRECT);
                    }
                    url = URLINFO2 + resultMap.get(ACCESSTOKEN) + URLOPENID + resultMap.get(OPENID) + URLLANG;
                    GetMethod getTokenInfo = new GetMethod(url);
                    HttpClient clientInfo = new HttpClient();
                    getTokenInfo.getParams().setContentCharset(UTF8);

                    try {
                        getWXLogin(request, code, resultMap, getTokenInfo, clientInfo, response);
                        System.out.println("stratTomain---------------------------------------------------------------");
                    } catch (Exception e) {
                        // 获取token失败
                        OperaLogUtil.addOperaException("Getting userinfo failed!", e, request);
                        return new ModelAndView(REDIRECT);
                    }

                } catch (Exception e) {
                    // 发送获取token请求失败
                    OperaLogUtil.addOperaException("Sending getwxtoken request failed!", e, request);
                    return new ModelAndView(REDIRECT);
                }
            } else {
                try {
                    // 微信接口数据未获取 throw NullPointerException...
                    throw new NullPointerException();
                } catch (Exception e) {
                    OperaLogUtil.addOperaException("Getting WEIXIN set failed!", e, request);
                    return new ModelAndView(REDIRECT);
                }
            }
            return new ModelAndView(REDIRECT);

        }

    }
    /**
     * 获取微信用户Code
     *
     * @param request
     * @param response
     * @throws java.io.IOException
     * @throws org.apache.commons.httpclient.HttpException
     */
    @RequestMapping("getwxtoken2")
    protected ModelAndView getWXToken2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 获取code
        String code = request.getParameter("code");
        if (code == null) {
            return new ModelAndView(REDIRECT);
        }
        // 获取微信接口AppId...
        Auth auth = authService.findAuthByAuthType("9");
        if (auth != null) {
            String url = URLINFO3 + auth.getAuthClientId() + SECRET + auth.getAuthClientSecret() + CODE + code + URLINFO1;
            GetMethod getTokenMethod = new GetMethod(url);
            HttpClient clientToken = new HttpClient();
            getTokenMethod.getParams().setContentCharset(UTF8);
            String res = "";
            Map<String, String> resultMap = null;
            try {
                // 获取token
                clientToken.executeMethod(getTokenMethod);
                res = getTokenMethod.getResponseBodyAsString();
                resultMap = WeiXinUtil.getWeiToken(res);
                if (resultMap == null) {
                    return throwNullPointer(request);
                }
                url = URLINFO2 + resultMap.get(ACCESSTOKEN) + URLOPENID + resultMap.get(OPENID) + URLLANG;
                GetMethod getTokenInfo = new GetMethod(url);
                HttpClient clientInfo = new HttpClient();
                getTokenInfo.getParams().setContentCharset(UTF8);
                try {
                    getWXLogin(request, code, resultMap, getTokenInfo, clientInfo,response);
                } catch (Exception e) {
                    // 获取token失败
                    OperaLogUtil.addOperaException("Getting userinfo failed!", e, request);
                    return new ModelAndView(REDIRECT);
                }

            } catch (Exception e) {
                // 发送获取token请求失败
                OperaLogUtil.addOperaException("Sending getwxtoken request failed!", e, request);
                return new ModelAndView(REDIRECT);
            }
        } else {
            try {
                // 微信接口数据未获取 throw NullPointerException...
                throw new NullPointerException();
            } catch (Exception e) {
                OperaLogUtil.addOperaException("Getting WEIXIN set failed!", e, request);
                return new ModelAndView(REDIRECT);
            }
        }
        return new ModelAndView("redirect:/" + request.getSession().getAttribute("otherPayUrl"));
    }

    @RequestMapping(value = "/getwechatauth", method = RequestMethod.POST)
    @ResponseBody
    public int getWechatAuth(HttpServletRequest request,HttpServletResponse response){
            try {
                // 获取code
                String code = request.getParameter("code");
                if (code == null) {
                   throw new NullPointerException();
                }

                String sessionOpedId = (String)request.getSession().getAttribute("openid");

                if(sessionOpedId == null) {
                    // 获取微信接口AppId...
                    Auth auth = authService.findAuthByAuthType("9");
                    if (auth != null) {
                        String url = URLINFO3 + auth.getAuthClientId() + SECRET + auth.getAuthClientSecret() + CODE + code + URLINFO1;
                        GetMethod getTokenMethod = new GetMethod(url);
                        HttpClient clientToken = new HttpClient();
                        getTokenMethod.getParams().setContentCharset(UTF8);
                        String res = "";
                        Map<String, String> resultMap = null;
                        // 获取token
                        clientToken.executeMethod(getTokenMethod);
                        res = getTokenMethod.getResponseBodyAsString();
                        resultMap = WeiXinUtil.getWeiToken(res);
                        if (resultMap == null) {
                            throw new NullPointerException();
                        }
                        url = URLINFO2 + resultMap.get(ACCESSTOKEN) + URLOPENID + resultMap.get(OPENID) + URLLANG;
                        GetMethod getTokenInfo = new GetMethod(url);
                        HttpClient clientInfo = new HttpClient();
                        getTokenInfo.getParams().setContentCharset(UTF8);
                        getWXLogin(request, code, resultMap, getTokenInfo, clientInfo,response);
                        return 1;
                    } else {
                        // 微信接口数据未获取 throw NullPointerException...
                        throw new NullPointerException();
                    }
                }
            } catch (Exception e) {
                //e.printStackTrace();
                OperaLogUtil.addOperaException("Getting WEIXIN set failed!", e, request);
            }
            return 0;
        }

    private void getWXLogin(HttpServletRequest request, String code, Map<String, String> resultMap, GetMethod getTokenInfo, HttpClient clientInfo,HttpServletResponse response) throws IOException {
        String res;
        Map<String, String> userMap;
        clientInfo.executeMethod(getTokenInfo);
        res = getTokenInfo.getResponseBodyAsString();
        // 成功获取微信用户信息 下面开始解析用户信息
        userMap = WeiXinUtil.getWeiXinInfo(res);
        // 验证存在 用户已存在 直接登录 用户不存在 则执行注册流程
//        ThreePart tp = threePartService.selectThreePart(resultMap.get(OPENID));
//        if (tp != null) {
//            // 获取用户信息
//            if (this.customerService == null) {
//                this.customerService = this.getCustomerService();
//            }
//            Customer cus = this.customerService.selectByPrimaryKey(tp.getThreePartMemberId());
//            request.getSession().setAttribute("cust", cus);
//            request.getSession().setAttribute("customerId", cus.getCustomerId());
//            request.getSession().setAttribute("isWx", "1");
//        } else {
//            // 注册
//            CustomerAllInfo allInfo = new CustomerAllInfo();
//            allInfo.setLoginIp(IPAddress.getIpAddr(request));
//            allInfo.setCustomerUsername(resultMap.get(OPENID));
//            allInfo.setCustomerPassword("");
//            allInfo.setCustomerNickname(userMap.get("nickname"));
//            allInfo.setInfoGender(userMap.get("sex"));
//            allInfo.setCustomerImg(userMap.get("headimgurl").toString());
//            // 将微信用户添加到会员列表中
//            if (customerServiceMapper.addCustomer(allInfo) == 1) {
//                Map<String, Object> paramMap = new HashMap<String, Object>();
//                paramMap.put("username", resultMap.get(OPENID));
//                paramMap.put("password", "");
//                Customer customer = customerMapper.selectCustomerByNamePwd(paramMap);
//                tp = new ThreePart();
//                tp.setThreePartUid(resultMap.get(OPENID));
//                tp.setThreePartToken(resultMap.get(ACCESSTOKEN));
//                tp.setThreePartMemberId(customer.getCustomerId());
//                threePartService.insertThreePart(tp);
//                Customer cus = customerService.selectByPrimaryKey(tp.getThreePartMemberId());
//                request.getSession().setAttribute("cust", cus);
//                request.getSession().setAttribute("customerId", cus.getCustomerId());
//                request.getSession().setAttribute("isWx", "1");
//            }
//        }
        request.getSession().setAttribute("isWx", "1");
        Pay pay = payService.findByPayId(36L);
        request.getSession().setAttribute("accessToken", resultMap.get(ACCESSTOKEN));
        request.getSession().setAttribute("appid", pay.getApiKey());
        request.getSession().setAttribute("state", request.getParameter("state"));
        // 微信授权code
        request.getSession().setAttribute("code", code);
        request.getSession().setAttribute("openid", resultMap.get(OPENID));
    }

    public AuthService getAuthService() {
        return authService;
    }

    @Resource(name = "authService")
    public void setAuthService(AuthService authService) {
        this.authService = authService;
    }

    public CustomerService getCustomerService() {
        return customerService;
    }

    @Resource(name = "customerServiceM")
    public void setCustomerService(CustomerService customerService) {
        this.customerService = customerService;
    }

    public CustomerServiceMapper getCustomerServiceMapper() {
        return customerServiceMapper;
    }

    @Resource(name = "customerServiceMapper")
    public void setCustomerServiceMapper(CustomerServiceMapper customerServiceMapper) {
        this.customerServiceMapper = customerServiceMapper;
    }

    public CustomerMapper getCustomerMapper() {
        return customerMapper;
    }

    @Resource(name = "customerMapper")
    public void setCustomerMapper(CustomerMapper customerMapper) {
        this.customerMapper = customerMapper;
    }

    public ThreePartService getThreePartService() {
        return threePartService;
    }

    @Resource(name = "threePartServiceM")
    public void setThreePartService(ThreePartService threePartService) {
        this.threePartService = threePartService;
    }

    /**
     * 通过code获取网页静默授权access_token
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("getwxaccesstoken")
    protected void getwxaccesstoken(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 获取code
        String code = request.getParameter("code");
        if (code != null) {
            // 获取微信接口AppId...
            Auth auth = authService.findAuthByAuthType("9");
            if (auth != null) {
                //获取openid的url
                String url = URLINFO3 + auth.getAuthClientId() + SECRET + auth.getAuthClientSecret() + CODE + code + URLINFO1;
                GetMethod getTokenMethod = new GetMethod(url);
                HttpClient clientToken = new HttpClient();
                getTokenMethod.getParams().setContentCharset(UTF8);
                String res = "";
                Map<String, String> resultMap = null;
                try {
                    // 获取token
                    clientToken.executeMethod(getTokenMethod);
                    res = getTokenMethod.getResponseBodyAsString();
                    resultMap = WeiXinUtil.getWeiToken(res);
                    if (resultMap != null && resultMap.get(OPENID) != null) {
                        request.getSession().setAttribute(OPENID, resultMap.get(OPENID));
                        LOGGER.info("微信分享进入商城获取的openid:"+resultMap.get(OPENID));
                    }

                } catch (Exception e) {
                    // 发送获取token请求失败
                    OperaLogUtil.addOperaException("Sending getwxaccesstoken request failed!", e, request);
                }
            }
        }
        LOGGER.info("微信分享进入商城获取的jumpUrl:"+request.getSession().getAttribute("jumpUrl"));
        response.sendRedirect((String)request.getSession().getAttribute("jumpUrl"));
    }
}