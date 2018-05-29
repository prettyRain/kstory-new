package com.ningpai.site.threepart.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.ningpai.index.service.TopAndBottomService;
import com.ningpai.site.shoppingcart.service.ShoppingCartService;
import com.ningpai.site.threepart.util.QQMessage;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.ningpai.customer.bean.Customer;
import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.other.bean.CustomerAllInfo;
import com.ningpai.other.util.IPAddress;
import com.ningpai.site.customer.mapper.CustomerMapper;
import com.ningpai.site.customer.service.CustomerServiceInterface;
import com.ningpai.site.threepart.bean.ThreePart;
import com.ningpai.site.threepart.service.ThreePartService;
import com.ningpai.site.threepart.util.StringUtil;
import com.ningpai.site.threepart.util.WeiXinMessage;
import com.ningpai.system.bean.Auth;
import com.ningpai.system.service.AuthService;
import com.ningpai.util.MyLogger;

/**
 * Date: 12-12-4 Time: 下午4:36
 */
@Controller
public class AfterLoginWeixinController extends HttpServlet {

    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(AfterLoginQQController.class);

    private AuthService authService;

    private CustomerServiceInterface customerServiceInterface;

    private CustomerServiceMapper customerServiceMapper;

    private CustomerMapper customerMapper;

    private ThreePartService threePartService;

    @Resource(name = "ShoppingCartService")
    private ShoppingCartService shoppingCartService;
    @Autowired
    private TopAndBottomService topAndBottomService;
    private static final String LOGIN_LOGIN_BANGDING = "/login/binding_page";

    /**
     * QQ登录
     * 
     * @param request
     * @param response
     * @return
     * @throws IOException
     *             afterloginqq
     */
    @RequestMapping("afterloginweixin")
    public ModelAndView afterloginweixin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        response.setContentType("text/html; charset=utf-8");
        String preurl = request.getParameter("myurl");
        try {
            Auth auth = authService.findAuthByAuthType("7");
            if (auth != null) {
                String appID = auth.getAuthClientId();
                String appKEY = auth.getAuthClientSecret();
                String code = request.getParameter("code");
                request.getSession().setAttribute("weixin_code", code);
                String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appID + "&secret=" + appKEY + "&code=" + code + "&grant_type=authorization_code";
                String userInfo;
                GetMethod getMethod = new GetMethod(url);
                HttpClient client = new HttpClient();
                Map<String, String> pmap = null;
                client.executeMethod(getMethod);
                userInfo = getMethod.getResponseBodyAsString();

                JSONObject jsonObject = JSONObject.parseObject(userInfo);
                pmap = JSONObject.parseObject(jsonObject.toJSONString(), new TypeReference<Map<String, String>>(){});

                //                pmap = StringUtil.formatString(userInfo);

                if (pmap == null) {
                    return new ModelAndView(new RedirectView("404.html"));
                }

                String accessToken = pmap.get("access_token");
                String openid = pmap.get("openid");

                ThreePart tp = threePartService.selectThreePart(openid);
                if (tp != null) {
                    // 获取用户信息
                    Customer cus = customerServiceInterface.queryCustomerById(tp.getThreePartMemberId());
                    request.getSession().setAttribute("cust", cus);
                    request.getSession().setAttribute("customerId", cus.getCustomerId());
                    request.getSession().setAttribute("isThirdLogin", "1");
                } else {
                    request.getSession().setAttribute("appID", appID);
                    request.getSession().setAttribute("uid", openid);
                    request.getSession().setAttribute("accessToken", accessToken);
                    request.getSession().setAttribute("threePartType", "2");
                    Map<String, String> userData = WeiXinMessage.getWeiXinMessage(accessToken, openid);
                    resultMap.put("screen_name",userData.get("screen_name"));
                    resultMap.put("headimg",userData.get("headimg").toString());
                    resultMap.put("three_part_type","微信");
                    resultMap.put("threePartType","2");
                    request.getSession().setAttribute("weixinResultMap", resultMap);
                    return new ModelAndView("redirect:/bindingpage.htm?myurl="+preurl);
//                    return topAndBottomService.getBottom(new ModelAndView(LOGIN_LOGIN_BANGDING).addAllObjects(resultMap));
                }

                // 将cookie中的购物车商品加载到当前登入用户下面
                shoppingCartService.loadCoodeShopping(request);

                // 删除cookie中购物车的商品
                Cookie cook = new Cookie("_npstore_shopcar", null);
                cook.setMaxAge(-1);
                cook.setPath("/");
                response.addCookie(cook);
            }

        } catch (Exception e) {
            LOGGER.error("微信错误" + e);
        }

        // 如果是从购物车页面跳转过来的  则又跳转回购物车页面
        if (StringUtils.isNotEmpty(preurl) && preurl.indexOf("myshoppingcart") != -1) {
            return new ModelAndView(new RedirectView(request.getContextPath() + "/myshoppingcart.htm"));
        } else {
            return new ModelAndView("redirect:/");
        }

    }


    @RequestMapping("bindingpage")
    public ModelAndView bindingpage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            resultMap = (Map<String, Object>) request.getSession().getAttribute("weixinResultMap");
        }catch (Exception e)
        {
            e.printStackTrace();
            return new ModelAndView("redirect:/");
        }
        return topAndBottomService.getBottom(new ModelAndView(LOGIN_LOGIN_BANGDING).addAllObjects(resultMap));
    }

    public AuthService getAuthService() {
        return authService;
    }

    @Resource(name = "authService")
    public void setAuthService(AuthService authService) {
        this.authService = authService;
    }

    public CustomerMapper getCustomerMapper() {
        return customerMapper;
    }

    @Resource(name = "customerMapperSite")
    public void setCustomerMapper(CustomerMapper customerMapper) {
        this.customerMapper = customerMapper;
    }

    public CustomerServiceMapper getCustomerServiceMapper() {
        return customerServiceMapper;
    }

    @Resource(name = "customerServiceMapper")
    public void setCustomerServiceMapper(CustomerServiceMapper customerServiceMapper) {
        this.customerServiceMapper = customerServiceMapper;
    }

    public CustomerServiceInterface getCustomerServiceInterface() {
        return customerServiceInterface;
    }

    @Resource(name = "customerServiceSite")
    public void setCustomerServiceInterface(CustomerServiceInterface customerServiceInterface) {
        this.customerServiceInterface = customerServiceInterface;
    }

    public ThreePartService getThreePartService() {
        return threePartService;
    }

    @Resource(name = "ThreePartService")
    public void setThreePartService(ThreePartService threePartService) {
        this.threePartService = threePartService;
    }

}
