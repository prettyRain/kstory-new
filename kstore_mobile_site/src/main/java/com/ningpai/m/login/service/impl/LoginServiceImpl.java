/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.m.login.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.m.customer.vo.CustomerAllInfo;
import com.ningpai.utils.SecurityUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.ningpai.customer.bean.CustomerAddress;
import com.ningpai.customer.dao.CustomerAddressMapper;
import com.ningpai.customer.service.CustomerPointServiceMapper;
import com.ningpai.m.customer.bean.Customer;
import com.ningpai.m.customer.mapper.CustomerMapper;
import com.ningpai.m.customer.service.BrowserecordService;
import com.ningpai.m.login.service.LoginService;
import com.ningpai.m.shoppingcart.service.ShoppingCartService;
import com.ningpai.other.util.IPAddress;
import com.ningpai.util.UtilDate;

/**
 * @author NINGPAI-zhangqiang
 * @version 0.0.1
 * @see com.ningpai.m.login.service.LoginService
 * @since 2014年8月19日 上午10:33:36
 */
@Service("loginServiceM")
public class LoginServiceImpl implements LoginService {

    // spring注解 会员Mapper
    private CustomerMapper customerMapper;

    private CustomerAddress address;

    private CustomerAddressMapper addressMapper;

    private CustomerPointServiceMapper customerPointServiceMapper;

    private ShoppingCartService shoppingCartService;

    private static final String UTYPE = "uType";

    private static final String USENAME = "username";
    @Resource(name = "mbrowserecordService")
    private BrowserecordService browserecordService;

    // spring 注解
    @Resource(name = "customerServiceMapper")
    private CustomerServiceMapper customerServiceMapper;

    /*
     * 验证用户
     * 
     * @see
     * com.ningpai.m.login.service.LoginService#checkCustomerExists(javax.servlet
     * .http.HttpServletRequest, java.lang.String, java.lang.String)
     */
    @SuppressWarnings("static-access")
    @Override
    public int checkCustomerExists(HttpServletRequest request, HttpServletResponse response, String username, String password, String code, String keeppwd) throws UnsupportedEncodingException {
        // 验证码
//        String patchca = (String) request.getSession().getAttribute("PATCHCA");
//        if (code != null && !("").equals(code)
//                && !patchca.equals(code)) {
//            // 验证码错误
//            return 3;
//        }
        Map<String, Object> paramMap = null;
        String nameEmp = username.trim();
        paramMap = new HashMap<String, Object>();
        if (nameEmp.indexOf("@") != -1) {
            paramMap.put(UTYPE, "email");
        } else if (Pattern.compile("^0?(13|15|17|18|14)[0-9]{9}$").matcher(nameEmp).find()) {
            paramMap.put(UTYPE, "mobile");
        } else {
            paramMap.put(UTYPE, USENAME);
        }
        paramMap.put(USENAME, username);
        Customer customerN = customerMapper.selectCustomerByCustNameAndType(paramMap);
        if (customerN != null) {
            //根据规则加密密码
            String encodePwd = SecurityUtil.getStoreLogpwd(customerN.getUniqueCode(), password, customerN.getSaltVal());
            //验证密码是否正确
            if (encodePwd.equals(customerN.getCustomerPassword())) {
                if ("1".equals(customerN.getIsFlag())) {
                    //被冻结
                    return 0;
                } else {
                    if(customerN.getLoginLockTime()!=null){
                        // 创建一个用来处理时间的函数
                        Calendar c1 = Calendar.getInstance();
                        c1.clear();
                        Calendar c2 = Calendar.getInstance();
                        c2.clear();
                        Date loginLockTime = customerN.getLoginLockTime();
                        Date loginTime = new Date();
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
                        if (diffMin < 30l) {
                            // 如果锁定时间没到 客户发送登陆请求 重新插入当前时间 如锁定时间 如果超过限制的登陆次数就保存当前时间 用来作为锁定的时间
                            customerN.setLoginLockTime(new Date());
                            // 修改单个会员的信息
                            this.customerMapper.updateByPrimaryKeySelective(customerN);
                            return 5;
                        }
                    }

                        // 增加登录积分
                        Date lastLoginTime = customerN.getLoginTime();
                        if (lastLoginTime == null) {
                            customerN.setLoginTime(new Date());
                            customerPointServiceMapper.addIntegralByType(customerN.getCustomerId(), "1");
                        } else if (!UtilDate.todayFormatString(new Date()).equals(UtilDate.todayFormatString(lastLoginTime))) {
                            customerPointServiceMapper.addIntegralByType(customerN.getCustomerId(), "1");
                        }
                        customerN.setCustomerPassword(null);
                        // 设置登录时间
                        customerN.setLoginTime(new Date());
                        // 设置登录Ip
                        customerN.setLoginIp(IPAddress.getIpAddrTwo(request));
                        //根据id查出省份
                        String province = customerServiceMapper.getProvinceByIP(((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest(),IPAddress.getIpAddrTwo(request));
                        if(StringUtils.isNotBlank(province)){
                            Long provinceId = customerMapper.queryProvinceIdByProvinceName(province);
                            //把查出来的省份保存到info里面
                            CustomerAllInfo customerAllInfo= new CustomerAllInfo();
                            customerAllInfo.setInfoProvince(provinceId.toString());
                            customerAllInfo.setCustomerId(customerN.getCustomerId());
                            customerMapper.updateCustomerInfo(customerAllInfo);
                        }
                        if (customerN.getAeadTime() == null) {
                            Calendar calendar = new GregorianCalendar();
                            calendar.setTime(new Date());
                            calendar.add(calendar.DATE, -1);
                            customerN.setAeadTime(calendar.getTime());
                        }
                        // 登陆错误次数归0
                        customerN.setLoginErrorCount(Long.valueOf(0));
                        customerN.setLoginLockTime(null);
                        customerMapper.updateByPrimaryKeySelective(customerN);

                        request.getSession().setAttribute("cust", customerN);
                        request.getSession().setAttribute("customerId", customerN.getCustomerId());
                        // 保存默认收获地址
                        address = addressMapper.selectDefaultAddr(customerN.getCustomerId());
                        browserecordService.loadBrowerecord(request);
                        //2017.12.6 现在不用
                    /*request.getSession().setAttribute("address", address);*/
                        // 密码正确
                        shoppingCartService.loadCoodeShopping(request);
                        //清除cookie中购物车项
                        Cookie cookieShopCart = new Cookie("_npstore_shopcar", null);
                        cookieShopCart.setMaxAge(-1);
                        cookieShopCart.setPath("/");
                        response.addCookie(cookieShopCart);
                        //清除cookie中浏览记录
                        Cookie cookieBrowpro = new Cookie("_npstore_browpro", null);
                        cookieBrowpro.setMaxAge(-1);
                        cookieBrowpro.setPath("/");
                        response.addCookie(cookieBrowpro);
                        if (("1").equals(keeppwd)) {
                            // 记住密码
                            Cookie cookieName = new Cookie("_kstore_newMobile_username",
                                    URLEncoder.encode(customerN.getCustomerUsername(), "UTF-8"));
                            Cookie cookiePassword = new Cookie(
                                    "_kstore_newMobile_password", URLEncoder.encode(
                                    encodePwd, "UTF-8"));
                            // 设置七天
                            cookieName.setMaxAge(7 * 24 * 3600);
                            cookiePassword.setMaxAge(7 * 24 * 3600);
                            cookieName.setPath("/");
                            cookiePassword.setPath("/");
                            response.addCookie(cookieName);
                            response.addCookie(cookiePassword);
                        }
                        return 1;
                    }


            } else {
                Long num;
                if (customerN.getLoginErrorCount() == null) {
                    num = (long) 0;
                } else {
                    num = customerN.getLoginErrorCount();
                }
                customerN.setCustomerPassword(null);
                // 错误次数加1
                customerN.setLoginErrorCount(num + 1);
                if (num + 1 > 5) {
                    customerN.setLoginErrorCount(6l);
                    customerN.setLoginLockTime(new Date());
                }
                // 修改单个会员的信息
                this.customerMapper.updateByPrimaryKeySelective(customerN);
                // 错误次数加1
                if (num + 1 > 5) {
                    // 错误大于5次

                    return 5;
                } else {
                    // 密码不正确
                    return 4;
                }
            }
        } else {
            // 用户名不存在
            return 2;
        }
    }



    public CustomerMapper getCustomerMapper() {
        return customerMapper;
    }

    @Resource(name = "customerMapperM")
    public void setCustomerMapper(CustomerMapper customerMapper) {
        this.customerMapper = customerMapper;
    }

    public CustomerAddressMapper getAddressMapper() {
        return addressMapper;
    }

    @Resource(name = "customerAddressMapper")
    public void setAddressMapper(CustomerAddressMapper addressMapper) {
        this.addressMapper = addressMapper;
    }

    public CustomerPointServiceMapper getCustomerPointServiceMapper() {
        return customerPointServiceMapper;
    }

    @Resource(name = "customerPointServiceMapper")
    public void setCustomerPointServiceMapper(CustomerPointServiceMapper customerPointServiceMapper) {
        this.customerPointServiceMapper = customerPointServiceMapper;
    }

    public ShoppingCartService getShoppingCartService() {
        return shoppingCartService;
    }

    @Resource(name = "ShoppingCartService")
    public void setShoppingCartService(ShoppingCartService shoppingCartService) {
        this.shoppingCartService = shoppingCartService;
    }

    /*
     * 是否记住用户
     * (non-Javadoc)
     * @see com.ningpai.m.login.service.LoginService#checkCookie(javax.servlet.http.HttpServletRequest)
     */
    @Override
    public ModelAndView checkCookie(HttpServletRequest request, HttpServletResponse response, String url) {
        String name = "";
        String password = "";
        name = getCookie(request, "_kstore_newMobile_username");
        password = getCookie(request, "_kstore_newMobile_password");

        // 如果cookie中登录信息有效，就登录
        if (!("").equals(name) && !("").equals(password)) {
            Map<String, Object> paramMap = new HashMap<String, Object>();
            if (name.indexOf("@") != -1) {
                paramMap.put(UTYPE, "email");
            } else if (Pattern.compile("^0?(13|15|17|18|14)[0-9]{9}$").matcher(name).find()) {
                paramMap.put(UTYPE, "mobile");
            } else {
                paramMap.put(UTYPE, USENAME);
            }
            paramMap.put(USENAME, name);
            paramMap.put("password", password);
            Customer customer = customerMapper.selectCustomerByNamePwdAndType(paramMap);
            if (customer != null) {
                // 把用户信息放入session
                // 增加登录积分
                if (!UtilDate.todayFormatString(new Date()).equals(UtilDate.todayFormatString(customer.getLoginTime()))) {
                    customerPointServiceMapper.addIntegralByType(customer.getCustomerId(), "1");
                }
                customer.setCustomerPassword(null);
                // 设置登录时间
                customer.setLoginTime(new Date());
                // 设置登录Ip
                customer.setLoginIp(IPAddress.getIpAddrTwo(request));
                if (customer.getAeadTime() == null) {
                    Calendar calendar = new GregorianCalendar();
                    calendar.setTime(new Date());
                    calendar.add(calendar.DATE, -1);
                    customer.setAeadTime(calendar.getTime());
                }
                // 登陆错误次数归0
                customer.setLoginErrorCount(Long.valueOf(0));
                customerMapper.updateByPrimaryKeySelective(customer);
                request.getSession().setAttribute("cust", customer);
                request.getSession().setAttribute("customerId", customer.getCustomerId());
                // 保存默认收获地址
                address = addressMapper.selectDefaultAddr(customer.getCustomerId());
                //2017.12.6  现在不用
                //request.getSession().setAttribute("address", address);
                // 密码正确
                shoppingCartService.loadCoodeShopping(request);
                //清除cookie中购物车项
                Cookie cookieShopCart = new Cookie("_npstore_shopcar", null);
                cookieShopCart.setMaxAge(-1);
                cookieShopCart.setPath("/");
                response.addCookie(cookieShopCart);
                //清除cookie中浏览记录
                Cookie cookieBrowpro = new Cookie("_npstore_browpro", null);
                cookieBrowpro.setMaxAge(-1);
                cookieBrowpro.setPath("/");
                response.addCookie(cookieBrowpro);
                // 登录成功后跳转页面
                if (url != null && !("").equals(url)) {
                    return new ModelAndView(new RedirectView(url));
                } else {
                    return new ModelAndView(new RedirectView("customercenter.html"));
                }
            } else {
                return new ModelAndView("/login/loginm").addObject("url",url);
            }
        } else {
            return new ModelAndView("/login/loginm").addObject("url",url);
        }

    }

    /**
     * 查询cookie中信息
     *
     * @param request
     * @return
     */
    public String getCookie(HttpServletRequest request, String param) {
        String str = "";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(param)) {
                    str = cookie.getValue();
                }
            }
        }
        return str;
    }

    /**
     * 第三方登录
     * @param customerN
     * @param response
     */
    public int threePartLoginm(Customer customerN,HttpServletResponse response){
        HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();


        if ("1".equals(customerN.getIsFlag())) {
            //被冻结
            return 0;
        } else {
            if(customerN.getLoginLockTime()!=null){
                // 创建一个用来处理时间的函数
                Calendar c1 = Calendar.getInstance();
                c1.clear();
                Calendar c2 = Calendar.getInstance();
                c2.clear();
                Date loginLockTime = customerN.getLoginLockTime();
                Date loginTime = new Date();
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
                if (diffMin < 30l) {
                    // 如果锁定时间没到 客户发送登陆请求 重新插入当前时间 如锁定时间 如果超过限制的登陆次数就保存当前时间 用来作为锁定的时间
                    customerN.setLoginLockTime(new Date());
                    // 修改单个会员的信息
                    this.customerMapper.updateByPrimaryKeySelective(customerN);
                    return 5;
                }
            }

            // 增加登录积分
            Date lastLoginTime = customerN.getLoginTime();
            if (lastLoginTime == null) {
                customerN.setLoginTime(new Date());
                customerPointServiceMapper.addIntegralByType(customerN.getCustomerId(), "1");
            } else if (!UtilDate.todayFormatString(new Date()).equals(UtilDate.todayFormatString(lastLoginTime))) {
                customerPointServiceMapper.addIntegralByType(customerN.getCustomerId(), "1");
            }
            customerN.setCustomerPassword(null);
            // 设置登录时间
            customerN.setLoginTime(new Date());
            // 设置登录Ip
            customerN.setLoginIp(IPAddress.getIpAddrTwo(request));
            //根据id查出省份
            String province = customerServiceMapper.getProvinceByIP(((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest(),IPAddress.getIpAddrTwo(request));
            if(StringUtils.isNotBlank(province)){
                Long provinceId = customerMapper.queryProvinceIdByProvinceName(province);
                //把查出来的省份保存到info里面
                CustomerAllInfo customerAllInfo= new CustomerAllInfo();
                customerAllInfo.setInfoProvince(provinceId.toString());
                customerAllInfo.setCustomerId(customerN.getCustomerId());
                customerMapper.updateCustomerInfo(customerAllInfo);
            }
            if (customerN.getAeadTime() == null) {
                Calendar calendar = new GregorianCalendar();
                calendar.setTime(new Date());
                calendar.add(calendar.DATE, -1);
                customerN.setAeadTime(calendar.getTime());
            }
            // 登陆错误次数归0
            customerN.setLoginErrorCount(Long.valueOf(0));
            customerN.setLoginLockTime(null);
            customerMapper.updateByPrimaryKeySelective(customerN);

            request.getSession().setAttribute("cust", customerN);
            request.getSession().setAttribute("customerId", customerN.getCustomerId());
            // 保存默认收获地址
            address = addressMapper.selectDefaultAddr(customerN.getCustomerId());
            browserecordService.loadBrowerecord(request);
            //2017.12.6 现在不用
                    /*request.getSession().setAttribute("address", address);*/
            // 密码正确
            shoppingCartService.loadCoodeShopping(request);
            //清除cookie中购物车项
            Cookie cookieShopCart = new Cookie("_npstore_shopcar", null);
            cookieShopCart.setMaxAge(-1);
            cookieShopCart.setPath("/");
            response.addCookie(cookieShopCart);
            //清除cookie中浏览记录
            Cookie cookieBrowpro = new Cookie("_npstore_browpro", null);
            cookieBrowpro.setMaxAge(-1);
            cookieBrowpro.setPath("/");
            response.addCookie(cookieBrowpro);

            return 1;
        }
    }
}
