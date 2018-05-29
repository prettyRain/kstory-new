package com.ningpai.m.main.controller;

import com.ningpai.m.util.LoginUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

/**
 * 页面跳转
 * Created by Administrator on 2017/2/24.
 */
@Controller
public class IntoPageController {

    @RequestMapping("/intoPage")
    public String pageInto(@RequestParam("pageName") String pageName, HttpServletRequest request, Long orderId, BigDecimal payPrice){
        if (pageName.indexOf("member/mysetting") != -1 && !LoginUtil.checkLoginStatus(request)) {
            return "redirect:/loginm.html";
        }
        if(orderId!=null && orderId!=0){
            request.setAttribute("orderId",orderId);
            request.setAttribute("payPrice",payPrice);
        }
        if(StringUtils.isNotBlank(pageName)){
            return pageName;
        }
        return "forward:/initMain";
    }
}
