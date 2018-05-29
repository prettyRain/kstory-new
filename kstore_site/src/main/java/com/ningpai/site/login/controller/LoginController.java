/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.site.login.controller;

import com.alibaba.fastjson.JSONObject;
import com.ningpai.common.util.ConstantUtil;
import com.ningpai.customer.bean.Customer;
import com.ningpai.customer.dao.CustomerMapper;
import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.index.service.TopAndBottomService;
import com.ningpai.other.bean.CustomerAllInfo;
import com.ningpai.other.util.IPAddress;

import com.ningpai.site.customer.service.CustomerServiceInterface;
import com.ningpai.site.customer.vo.CustomerConstantStr;
import com.ningpai.site.goods.service.BrowerService;
import com.ningpai.site.login.service.LoginService;
import com.ningpai.site.threepart.bean.ThreePart;
import com.ningpai.site.threepart.dao.ThreePartMapper;
import com.ningpai.site.threepart.service.ThreePartService;
import com.ningpai.site.threepart.util.QQMessage;
import com.ningpai.site.threepart.util.SinaMessage;
import com.ningpai.site.threepart.util.WeiXinMessage;
import com.ningpai.system.service.AuthService;
import com.ningpai.util.MyLogger;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 登录Controller
 *
 * @author NINGPAI-zhangqiang
 * @version 0.0.1
 * @since 2014年4月15日 下午3:06:26
 */
@Controller
public class LoginController {

    /**
     * 记录日志对象
     */
    private static final MyLogger LOGGER = new MyLogger(LoginController.class);

    private static final String LOGIN_LOGIN_JD = "/login/login_jd";
    private static final String INDEX_HTML = "index.html";
    private static final String _NPSTORE_USERNAME = "_npstore_username";

    /**
     * 会员登陆限制输入密码错误的次数
     */
    private static final Long LOGINMAXERRORCOUNT = 5L;

    /**
     * 每次达到错误次数 要求锁定的时间(分钟)
     */
    private static final Long LOCKMAXTIME = 30L;

    /**
     * spring 注解 登录service
     */
    private LoginService loginService;

    /**
     * 获取已启用的第三方登录接口
     */
    @Resource(name = "authService")
    private AuthService authService;

    /**
     * 获取头尾
     */
    private TopAndBottomService topAndBottomService;

    /**
     * 会员
     */
    private CustomerServiceMapper customerService;
    @Resource(name="BrowerService")
    private BrowerService browerService;
    /**
     * 跳转登录
     *
     * @return ModelAndView
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/customer/login")
    public ModelAndView login(HttpServletRequest request, String url, String isTemp, Long[] box) throws UnsupportedEncodingException {
        // 删除临时用户的session
        request.getSession().removeAttribute("is_temp_cust");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        // 临时用户提交的参数
        resultMap.put("isTemp", isTemp);
        resultMap.put("box", box);
        String status = request.getParameter("status");
        String urlEmp = url;
        String preUrl = request.getHeader("Referer");

        // 如果不使用Referer
        if (isNotUseReferUrl(url)) {
            preUrl = null;
        }

        if (StringUtils.isNotEmpty(preUrl)) {
            preUrl = URLDecoder.decode(preUrl, "utf-8");
        }


        if ("1".equals(status)) {
            setResultMap(request, resultMap, urlEmp);
            resultMap.put("t", authService.findByShow());
            // return topAndBottomService.getBottom(new
            // ModelAndView("/login/login").addAllObjects(resultMap));
            return topAndBottomService.getBottom(new ModelAndView(LOGIN_LOGIN_JD).addAllObjects(resultMap));
        }
        if (preUrl != null) {
            String strRegex = "^((https|http|ftp|rtsp|mms)?://)"
            // ftp的user@
                    + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?"
                    // IP形式的URL- 199.194.52.184
                    // 允许IP和DOMAIN（域名）
                    + "(([0-9]{1,3}\\.){3}[0-9]{1,3}" + "|"
                    // 域名- www.
                    + "([0-9a-z_!~*'()-]+\\.)*"
                    // 二级域名
                    + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\."
                    // first level domain- .com or .museum
                    + "[a-z]{2,6}|"
                    // 测试用 : 本地localhost.
                    + "([0-9a-z][0-9a-z-]{0,61}))"
                    // 端口- :80
                    + "(:[0-9]{1,4})?" +
                    // 项目名称
                    request.getContextPath() + "/";
            urlEmp = preUrl.replaceFirst(strRegex, "");
        } else {
            preUrl = (String) request.getSession().getAttribute("preferUrl");

            if (isNotUseReferUrl(url)) {
                preUrl = null;
            }

            preUrl = preUrl == null ? urlEmp : preUrl;
            if (preUrl != null) {
                urlEmp = preUrl;
            } else {
                urlEmp = INDEX_HTML;
            }
        }
        if (urlEmp.indexOf("register") != -1 || urlEmp.indexOf("success") != -1 || urlEmp.length() == 0 || urlEmp.indexOf("updatesucess") != -1) {
            urlEmp = INDEX_HTML;
        }
        if (urlEmp.indexOf("validateidentity") != -1 || urlEmp.indexOf("reirectpem") != -1) {
            urlEmp = "customer/securitycenter.html";
        }
        //if (urlEmp.indexOf(".html") == -1) {
        //    urlEmp = urlEmp + ".html";
        //}
        setResultMap(request, resultMap, urlEmp);
        resultMap.put("t", authService.findByShow());
        // return topAndBottomService.getBottom(new
        // ModelAndView("/login/login").addAllObjects(resultMap));
        return topAndBottomService.getBottom(new ModelAndView(LOGIN_LOGIN_JD).addAllObjects(resultMap));

    }

    /**
     * 判断是否不使用referurl
     *
     * @param url 传入的url
     * @return 不使用返回true  使用返回false
     */
    private boolean isNotUseReferUrl(String url) {

        if (StringUtils.isEmpty(url)) {
            return false;
        }

        if (url.indexOf("cosult/") != -1) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * 退出 跳转登录
     *
     * @return ModelAndView
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/customer/logout")
    public ModelAndView loginOut(HttpServletRequest request, String url) throws UnsupportedEncodingException {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String url1 = url;
        if (url1 == null) {
            url1 = INDEX_HTML;
        }
        // 清空session已登录数据
        request.getSession().removeAttribute("cust");
        request.getSession().removeAttribute("customerId");
        request.getSession().removeAttribute("isThirdLogin");
        request.getSession().removeAttribute("bsetDomain");
        resultMap.put("t", authService.findByShow());
        setResultMap(request, resultMap, url1);
        return topAndBottomService.getBottom(new ModelAndView(LOGIN_LOGIN_JD).addAllObjects(resultMap));

    }


    @Autowired
    ThreePartMapper threePartMapper;
    @Autowired
    private CustomerServiceInterface customerServiceInterface;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private ThreePartService threePartService;
    /**
     * 验证绑定
     *
     * @param request
     * @param username
     *            用户名
     * @param password
     *            密码
     * @param url
     *            跳转路径
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/checkbangding")
    @ResponseBody
    public JSONObject checkbangding(HttpServletRequest request, HttpServletResponse response, String username, String threePartType,String password, String url)
            throws UnsupportedEncodingException {

        String url1 = url;
        JSONObject jsonObject = new JSONObject();
        int status = loginService.checkCustomerExists(request, username, password);
//        String threePartType = request.getSession().getAttribute("threePartType").toString();
        if (status == 1) {
            // 根据用户名 获取单个的会员对象
            Customer customer = customerService.getCustomerByUsernameType(username);
            //是否已绑定
            Map<String ,Object> paraMap = new HashedMap();
            paraMap.put("threePartMemberId",customer.getCustomerId());
            paraMap.put("threePartType",threePartType);//three_part_type
            ThreePart threePart = threePartMapper.selectThreePartByUidAndType(paraMap);
            if(threePart != null) {
                jsonObject.put("status", "error");
                jsonObject.put("filed", "cw_error");
                jsonObject.put("msg", "该账号已绑定过该平台账号");
            }
            else {


                // 判断是否锁定 锁定时间是否为空 账户锁定期间 输入正确密码 也要等锁定时间到期
                if (customer != null && null != customer.getLoginLockTime()) {
                    // 判断是否锁定 锁定时间是否为空
                    // 计算是否锁定时间
                    status = getTimeDifference(customer.getLoginLockTime(), customer.getLoginTime(), customer, request, username, password);
                    if (status == 4 || status == 8) {
                        jsonObject.put("status", status);
                    }

                    /*
                     * else { return checkUser(type, username, password,
                     * response, customer, url); }
                     */
                }

                //xcy 删除cookie中的浏览记录 放入到用户浏览记录表中
                Cookie[] cookies = request.getCookies();
                String allpro = "";
                Map map = new HashMap();
                if (cookies != null) {
                    for (Cookie c : cookies) {
                        if (c != null && "_npstore_browpro".equals(c.getName())) {
                            //获取cookie中的商品
                            allpro = URLDecoder.decode(c.getValue(), "utf-8");
                            //清除cookie中的商品
                            Cookie cookie = new Cookie(URLEncoder.encode("_npstore_browpro"), "");
                            cookie.setMaxAge(-1);
                            cookie.setPath("/");
                            response.addCookie(cookie);
                        }
                    }
                    if (StringUtils.isNotBlank(allpro)) {
                        allpro = allpro.replace("e", "");
                        allpro = allpro.replace(",s", ",");
                        String[] idsAndTimes = allpro.split(",");
                        if (idsAndTimes.length > 0) {
                            //遍历cookie中的商品 保存到用户下面
                            for (String idAndTime : idsAndTimes) {
                                if (StringUtils.isNotBlank(idAndTime)) {
                                    String[] params = idAndTime.split("-");
                                    map.put("custId", customer.getCustomerId());
                                    map.put("productId", params[0]);
                                    map.put("creatTime", new Date(Long.parseLong(params[1])));
                                    Date date = browerService.getBrowerCreatTime(map);
                                    if (date != null) {
                                        Long time = date.getTime();
                                        if (Long.parseLong(params[1]) > time) {
                                            //如果已经存在的话删除 并且时间长于cookie中时间
                                            browerService.updateGoodsBrowStatus(map);
                                            //保存到数据库
                                            browerService.saveGoodsBrowCookie(map);
                                        }
                                    } else {
                                        //保存到数据库
                                        browerService.saveGoodsBrowCookie(map);
                                    }


                                }
                            }
                        }
                    }


                    // 删除cookie
                    Cookie cook = new Cookie("_npstore_shopcar", null);
                    cook.setMaxAge(-1);
                    cook.setPath("/");
                    response.addCookie(cook);
                    if ("order/suborder.html".equals(url1) || "suborder.html".equals(url1)) {
                        url1 = INDEX_HTML;
                    }
                    if ("order/subgrouponorder.html".equals(url1) || "subgrouponorder.html".equals(url1)) {
                        url1 = INDEX_HTML;
                    }
                    if ("order/submrorder.html".equals(url1) || "submrorder.html".equals(url1)) {
                        url1 = INDEX_HTML;
                    }


                    ThreePart tp = new ThreePart();
                    String uid = (String) request.getSession().getAttribute("uid");
                    String appID = (String) request.getSession().getAttribute("appID");
                    String accessToken = (String) request.getSession().getAttribute("accessToken");
                    Map<String, String> userData = null;
                    CustomerAllInfo customerAllInfo = new CustomerAllInfo();
                    if(threePartType.equals("3")) {
                        try {
                            userData = SinaMessage.getSinaMessage(accessToken, uid);
                            customerAllInfo.setInfoGender("m".equals(userData.get("gender")) ? "1" : "2");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }else if(threePartType.equals("1"))
                    {
                        try {
                            userData = QQMessage.getQQMessage(appID,accessToken, uid);
                            customerAllInfo.setInfoGender("男".equals(userData.get("gender")) ? "1" : "2");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }else if(threePartType.equals("2"))
                    {
                        try {
                            userData = WeiXinMessage.getWeiXinMessage(accessToken, uid);
                            customerAllInfo.setInfoGender("sex".equals(userData.get("gender")) ? "1" : "2");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }

                    customerAllInfo.setCustomerId(customer.getCustomerId());
                    customerAllInfo.setCustomerNickname(userData.get("screen_name"));
                    customer.setCustomerImg(userData.get("headimg").toString());

                    int f = customerServiceMapper.updateCustomer(customerAllInfo);

                    if (f == 1) {
                        tp = new ThreePart();
                        tp.setThreePartUid(uid);
                        tp.setThreePartType(threePartType);//three_part_type
                        tp.setThreePartToken(accessToken);
                        tp.setThreePartMemberId(customer.getCustomerId());
                        threePartService.insertThreePart(tp);
                        Customer cus = customerServiceInterface.queryCustomerById(tp.getThreePartMemberId());
                        request.getSession().setAttribute("cust", cus);
                        request.getSession().setAttribute("isThirdLogin", "1");
                        request.getSession().setAttribute("customerId", cus.getCustomerId());




                        jsonObject.put("status", "success");
                        jsonObject.put("url", url);
                    }


                }
            }

        } else if (status == 3) {
            //用户被冻结
            jsonObject.put("status", "error");
            jsonObject.put("filed", "cw_error");
            jsonObject.put("msg", "用户被冻结");
        } else if (status == 2) {
            // 用户名不存在
            jsonObject.put("status", "error");
            jsonObject.put("filed", "cw_error");
            jsonObject.put("msg", "用户名不存在");
        } else {
            //密码错误
            jsonObject.put("status", "error");
            jsonObject.put("filed", "cw_error1");
            jsonObject.put("msg", "密码错误");
        }

        return jsonObject;
    }

    // spring 注解 会员服务Service
    @Autowired
    private CustomerServiceMapper customerServiceMapper;

    /**
     * 验证绑定
     *
     * @param request
     * @param mobile
     *            用户名
     * @param password
     *            密码
     * @param url
     *            跳转路径
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/checkwanshan")
    @ResponseBody
    public JSONObject checkwanshan(HttpServletRequest request, HttpServletResponse response, String mobile, String password,String threePartType,String mobileCode, String url)
            throws UnsupportedEncodingException {

        String url1 = url;
//        String threePartType = request.getSession().getAttribute("threePartType").toString();
        JSONObject jsonObject = new JSONObject();
        // 手机号验证规则
        String regEx = "0?1[3|4|5|8|7][0-9]\\d{8}";
        Pattern pattern = Pattern.compile(regEx);
        Matcher matcher = pattern.matcher(mobile);
        if(!matcher.matches()){
            //手机号不合法
            jsonObject.put("status","error");
            jsonObject.put("filed", "cw_errorone");
            jsonObject.put("msg","手机号不合法");
        }else {
            // 验证该手机号是否存在
            Long result = customerServiceMapper.checkMobileExist(mobile);
            if (result == 1) {
                jsonObject.put("status", "error");
                jsonObject.put("filed", "cw_errorone");
                jsonObject.put("msg", "手机号已存在");
            } else {
                if (request.getSession().getAttribute("mcCode") != null) {
                    if (!request.getSession().getAttribute("mcCode").toString().equals(mobileCode)) {
                        jsonObject.put("status", "error");
                        jsonObject.put("filed", "cw_errorone");
                        jsonObject.put("msg", "验证码不匹配");
                    } else {
                        jsonObject.put("status", "success");
                        jsonObject.put("url", url);
                        jsonObject.put("msg", "完善信息成功");
                        ThreePart tp = new ThreePart();
                        String uid = (String) request.getSession().getAttribute("uid");
                        String accessToken = (String) request.getSession().getAttribute("accessToken");
                        String appID = (String) request.getSession().getAttribute("appID");
                        Map<String, String> userData = null;
                        CustomerAllInfo allInfo = new CustomerAllInfo();
                        if("3".equals(threePartType)) {
                            try {
                                userData = SinaMessage.getSinaMessage(accessToken, uid);
                                allInfo.setInfoGender("m".equals(userData.get("gender")) ? "1" : "2");
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }else if("1".equals(threePartType))
                        {
                            try {
                                userData = QQMessage.getQQMessage(appID,accessToken, uid);
                                allInfo.setInfoGender("男".equals(userData.get("gender")) ? "1" : "2");
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }else if("2".equals(threePartType))
                        {
                            try {
                                userData = WeiXinMessage.getWeiXinMessage(accessToken, uid);
                                allInfo.setInfoGender("sex".equals(userData.get("gender")) ? "1" : "2");
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }

                        allInfo.setCustomerUsername(mobile);
                        allInfo.setInfoPhone(mobile);
                        allInfo.setLoginIp(IPAddress.getIpAddr(request));
                        allInfo.setPointLevelId(2L);
                        allInfo.setCustomerNickname(userData.get("screen_name"));
                        allInfo.setCustomerPassword(password);

                        allInfo.setCustomerImg(userData.get("headimg").toString());
                        int f = customerService.addCustomer(allInfo);
                        if (f == 1) {
                            Customer cus = customerMapper.selectCustomerByUserName(mobile);
                            tp = new ThreePart();
                            tp.setThreePartUid(uid);
                            tp.setThreePartType(threePartType);
                            tp.setThreePartToken(accessToken);
                            tp.setThreePartMemberId(cus.getCustomerId());
                            threePartService.insertThreePart(tp);

                            request.getSession().setAttribute("cust", cus);
                            request.getSession().setAttribute("isThirdLogin", "1");
                            request.getSession().setAttribute("customerId", cus.getCustomerId());
                        }
                    }
                } else {
                    jsonObject.put("status", "error");
                    jsonObject.put("filed", "cw_errorone");
                    jsonObject.put("msg", "验证码不匹配");
                }

            }
        }


        return jsonObject;
    }






    /**
     * 验证登录
     *
     * @param request
     * @param username
     *            用户名
     * @param password
     *            密码
     * @param url
     *            跳转路径
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/checklogin")
    @ResponseBody
    public Object checkLogin(HttpServletRequest request, HttpServletResponse response, String username, String password, String url, String type)
            throws UnsupportedEncodingException {
        String url1 = url;
        int status = loginService.checkCustomerExists(request, username, password);
        if (status == 1) {
            // 根据用户名 获取单个的会员对象
            Customer customer = customerService.getCustomerByUsernameType(username);
            // 判断是否锁定 锁定时间是否为空 账户锁定期间 输入正确密码 也要等锁定时间到期
            if (customer != null && null != customer.getLoginLockTime()) {
                // 判断是否锁定 锁定时间是否为空
                    // 计算是否锁定时间
                    status = getTimeDifference(customer.getLoginLockTime(), customer.getLoginTime(), customer, request, username, password);
                    if (status == 4 || status == 8) {
                        return status;
                    }

                    /*
                     * else { return checkUser(type, username, password,
                     * response, customer, url); }
                     */
            }
            if ("0".equals(type)) {
                Cookie cookie = new Cookie(_NPSTORE_USERNAME, URLEncoder.encode(username, CustomerConstantStr.UTF));
                // 设置七天
                cookie.setMaxAge(7 * 24 * 3600);
                response.addCookie(cookie);
            } else if ("1".equals(type)) {
                Cookie nameCookie = new Cookie(_NPSTORE_USERNAME, URLEncoder.encode(username, CustomerConstantStr.UTF));
                // 设置七天
                nameCookie.setMaxAge(7 * 24 * 3600);
                response.addCookie(nameCookie);

//                Cookie pwdCookie = new Cookie("_npstore_pwd", URLEncoder.encode(password, CustomerConstantStr.UTF));
//                // 设置七天
//                pwdCookie.setMaxAge(7 * 24 * 3600);
//                response.addCookie(pwdCookie);

            }
            //xcy 删除cookie中的浏览记录 放入到用户浏览记录表中
            Cookie[] cookies=request.getCookies();
            String allpro="";
            Map map=new HashMap();
            if(cookies != null){
                for(Cookie c:cookies){
                    if(c != null && "_npstore_browpro".equals(c.getName())){
                        //获取cookie中的商品
                        allpro=URLDecoder.decode(c.getValue(),"utf-8");
                        //清除cookie中的商品
                        Cookie cookie=new Cookie(URLEncoder.encode("_npstore_browpro"),"");
                        cookie.setMaxAge(-1);
                        cookie.setPath("/");
                        response.addCookie(cookie);
                    }
                }
                if(StringUtils.isNotBlank(allpro)){
                    allpro=allpro.replace("e","");
                    allpro=allpro.replace(",s",",");
                    String[] idsAndTimes=allpro.split(",");
                    if(idsAndTimes.length>0){
                        //遍历cookie中的商品 保存到用户下面
                        for(String idAndTime:idsAndTimes){
                            if(StringUtils.isNotBlank(idAndTime)){
                                String[] params=idAndTime.split("-");
                                map.put("custId", customer.getCustomerId());
                                map.put("productId", params[0]);
                                map.put("creatTime",new Date(Long.parseLong(params[1])));
                                Date date=browerService.getBrowerCreatTime(map);
                                if(date!=null){
                                   Long time= date.getTime();
                                   if(Long.parseLong(params[1])>time){
                                       //如果已经存在的话删除 并且时间长于cookie中时间
                                       browerService.updateGoodsBrowStatus(map);
                                       //保存到数据库
                                       browerService.saveGoodsBrowCookie(map);
                                   }
                                }else{
                                        //保存到数据库
                                        browerService.saveGoodsBrowCookie(map);
                                }


                            }
                        }
                    }
                }

            }
            // 删除cookie
            Cookie cook = new Cookie("_npstore_shopcar", null);
            cook.setMaxAge(-1);
            cook.setPath("/");
            response.addCookie(cook);
            if ("order/suborder.html".equals(url1) || "suborder.html".equals(url1)) {
                url1 = INDEX_HTML;
            }
            if ("order/subgrouponorder.html".equals(url1) || "subgrouponorder.html".equals(url1)) {
                url1 = INDEX_HTML;
            }
            if ("order/submrorder.html".equals(url1) || "submrorder.html".equals(url1)) {
                url1 = INDEX_HTML;
            }

            LOGGER.info("验证会员【" + username + "】登陆");
            customer.setLoginErrorCount(0L);
            customerService.updateCusErrorCount(customer);
            return encodeURL(url1, "utf-8");
        }else if(status==3){
           //用户被冻结
            return status;
        } else if (status == 2) {
            // 用户名不存在
            return status;
        } else {
            // 如果密码错误 就记录当前会员登陆的错误次数
            return this.updateOrrerCountNew(username, request, password);
        }
    }

    /**
     * 设置当前会员登陆的错误次数
     *
     * @param username
     *            用户名
     */
    public Object updateOrrerCount(String username, HttpServletRequest request, String password) {
        // 根据用户名 获取单个的会员对象
        Customer customer = customerService.getCustomerByUsername(username);
        // 判断用户名是否有效 限制登陆的次数是否有值 锁定的时间是否有值
        if (null != customer) {
            // 判断是否锁定 锁定时间是否为空
            if (null == customer.getLoginLockTime()) {
                // 修改会员登陆错误的次数加1
                Long loginErrorCount = Long.valueOf(customer.getLoginErrorCount()) + 1;
                customer.setLoginErrorCount(loginErrorCount);
                // 修改单个会员的信息
                customerService.updateCusErrorCount(customer);
            }
            // 判断当前会员登陆的错误次数是否大于限制的登陆次数
            if (customer.getLoginErrorCount() > LOGINMAXERRORCOUNT) {
                // 判断是否锁定 锁定时间是否为空
                if (null != customer.getLoginLockTime()) {
                    return getTimeDifference(customer.getLoginLockTime(), new Date(), customer, request, username, password);
                }
                // 如果超过限制的登陆次数就保存当前时间 用来作为锁定的时间
                customer.setLoginLockTime(new Date());
                customerService.updateCusLock(customer);
            }
        }
        return 0;
    }

    /**
     * 设置当前会员登陆的错误次数，用于前台输入密码时错误提醒
     *
     * @param username
     *            用户名
     */
    public Object updateOrrerCountNew(String username, HttpServletRequest request, String password) {
        // 根据用户名 获取单个的会员对象
        Customer customer = customerService.getCustomerByUsername(username);
        // 判断用户名是否有效 限制登陆的次数是否有值 锁定的时间是否有值
        if (null != customer) {
            // 判断是否锁定 锁定时间是否为空
            if (null == customer.getLoginLockTime()) {
                // 修改会员登陆错误的次数加1
                Long loginErrorCount = Long.valueOf(customer.getLoginErrorCount()) + 1;
                customer.setLoginErrorCount(loginErrorCount);
                // 修改单个会员的信息
                customerService.updateCusErrorCount(customer);
            }
            // 判断当前会员登陆的错误次数是否大于限制的登陆次数
            if (customer.getLoginErrorCount() > LOGINMAXERRORCOUNT) {
                // 判断是否锁定 锁定时间是否为空
                if (null != customer.getLoginLockTime()) {
                    return getTimeDifference(customer.getLoginLockTime(), new Date(), customer, request, username, password);
                }
                // 如果超过限制的登陆次数就保存当前时间 用来作为锁定的时间
                customer.setLoginLockTime(new Date());
                customerService.updateCusLock(customer);
            }
            customer.setLoginKey(null);
            customer.setCustomerPassword(null);
        }
        return customer;
    }

    /**
     * 计算两个Date时间差
     *
     * @param loginLockTime
     *            账户锁定时间
     * @param loginTime
     *            登陆时间
     */
    public int getTimeDifference(Date loginLockTime, Date loginTime, Customer customer, HttpServletRequest request, String username, String password) {
        // 创建一个用来处理时间的函数
        Calendar c1 = Calendar.getInstance();
        c1.clear();
        Calendar c2 = Calendar.getInstance();
        c2.clear();
        // 锁定日期
        String lockTimeYear = loginLockTime.toString();
        // 登陆日期
        String loginTimeYear = loginTime.toString();
        // 锁定日期年份
        lockTimeYear = lockTimeYear.substring(lockTimeYear.length() - 4, lockTimeYear.length());
        // 登陆日期年份
        loginTimeYear = loginTimeYear.substring(loginTimeYear.length() - 4, loginTimeYear.length());
        // 设置需要计算的时间
        c1.set(Integer.valueOf(lockTimeYear), loginLockTime.getMonth() + 1, loginLockTime.getDate(), loginLockTime.getHours(), loginLockTime.getMinutes());
        c2.set(Integer.valueOf(loginTimeYear), loginTime.getMonth() + 1, loginTime.getDate(), loginTime.getHours(), loginTime.getMinutes());

        // Print out the dates
        // SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd:HH:mm");

        long time1 = c1.getTimeInMillis();
        long time2 = c2.getTimeInMillis();

        // 相差的毫秒
        long diff = time2 - time1;
        /*
         * // 相差的秒数 long diffSec = diff / 1000;
         * 
         * // 相差的小时数 long diffHours = diff / (60 * 60 * 1000); // 相差的天书 long
         * diffDays = diff / (24 * 60 * 60 * 1000); //判断达到账户锁定时间
         */
        // 相差的分钟数
        long diffMin = diff / (60 * 1000);
        // 此次登陆时间与账户锁定的时间 差距是小于 系统规定的最大限制锁定时间
        if (diffMin < LOCKMAXTIME) {
            // 如果锁定时间没到 客户发送登陆请求 重新插入当前时间 如锁定时间 如果超过限制的登陆次数就保存当前时间 用来作为锁定的时间
            customer.setLoginLockTime(new Date());
            customerService.updateCusLock(customer);
            return 8;
        } else {
            // 大于规定的限制锁定时间 就清空 错误次数与锁定时间 （状态清零）
            customer.setLoginLockTime(null);
            customer.setLoginErrorCount(0L);
            customerService.updateCusErrorCount(customer);
            // 超过锁定限制时间 在重新查一次账户 如果用户密码正确 直接返回
            int status = loginService.checkCustomerExists(request, username, password);
            if (status == 1) {
                return 1;
            } else {
                return 4;
            }
        }
    }

    /**
     * 设置结果集
     * 
     * @param request
     * @param resultMap
     * @param url
     * @throws UnsupportedEncodingException
     */
    public void setResultMap(HttpServletRequest request, Map<String, Object> resultMap, String url) throws UnsupportedEncodingException {
        String username = "";
        // 读取cookie中的信息
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie != null && _NPSTORE_USERNAME.equals(cookie.getName())) {
                    username = URLDecoder.decode(cookie.getValue(), ConstantUtil.UTF);
                    break;
                }
            }
        }
        resultMap.put("username", username);
        resultMap.put("url", url);
    }

    public LoginService getLoginService() {
        return loginService;
    }

    @Resource(name = "loginServiceSite")
    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }

    public TopAndBottomService getTopAndBottomService() {
        return topAndBottomService;
    }

    @Resource(name = "TopAndBottomService")
    public void setTopAndBottomService(TopAndBottomService topAndBottomService) {
        this.topAndBottomService = topAndBottomService;
    }

    public CustomerServiceMapper getCustomerServiceMapper() {
        return customerService;
    }

    @Resource(name = "customerServiceMapper")
    public void setCustomerServiceMapper(CustomerServiceMapper customerService) {
        this.customerService = customerService;
    }

    /**
     * 对url进行编码  主要是对url中的中文进行编码
     *
     * @param url
     * @param encode
     * @return
     * @throws UnsupportedEncodingException
     */
    private String encodeURL(String url, String encode) throws UnsupportedEncodingException {
        StringBuilder sb = new StringBuilder();
        StringBuilder noAsciiPart = new StringBuilder();
        for (int i = 0; i < url.length(); i++) {
            char c = url.charAt(i);
            if (c > 255) {
                noAsciiPart.append(c);
            } else {
                if (noAsciiPart.length() != 0) {
                    sb.append(URLEncoder.encode(noAsciiPart.toString(), encode));
                    noAsciiPart.delete(0, noAsciiPart.length());
                }
                sb.append(c);
            }
        }
        return sb.append(URLEncoder.encode(noAsciiPart.toString(), encode)).toString();
    }
}
