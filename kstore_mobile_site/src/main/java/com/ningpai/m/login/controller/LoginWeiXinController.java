package com.ningpai.m.login.controller;

import com.ningpai.logger.util.OperaLogUtil;
import com.ningpai.system.bean.Auth;
import com.ningpai.system.service.AuthService;
import com.ningpai.util.MyLogger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2018/5/2.
 */
@Controller
public class LoginWeiXinController {
    private static final String WEIXIN_URL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=";
    private static final String REDIRECT_URI = "&redirect_uri=";
    private static final String WECHAT_REDIRECT = "&response_type=code&scope=snsapi_userinfo&state=1&connect_redirect=1#wechat_redirect";
    private static final String LOGGERINFO1 = "Sending getwxcode request failed!";
    private static final String LOGGERINFO2 = "Getting WEIXIN set failed!";
    private static final String WECHAT_BASEREDIRECT = "&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
    private static final String LOGGERINFO3 = "Getting queryWxConfig request failed!";
    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(LoginWeiXinController.class);

    private AuthService authService;

    /**
     *
     * @param request
     * @param response
     */
    @RequestMapping("/loginmwx")
    public void loginmwx(HttpServletRequest request, HttpServletResponse response){
        String preUrl = request.getParameter("preurl");
        Auth auth = authService.findAuthByAuthType("9");

        if (auth != null) {
            String url = WEIXIN_URL + auth.getAuthClientId() + REDIRECT_URI + auth.getAuthRedirectUri() + WECHAT_REDIRECT.replace("state=1","state="+preUrl);
            try {
                response.sendRedirect(url);
            } catch (IOException e) {
                OperaLogUtil.addOperaException(LOGGERINFO1, e, request);
            }
        } else {
            try {
                throw new NullPointerException();
            } catch (Exception e) {
                OperaLogUtil.addOperaException(LOGGERINFO2, e, request);
            }
        }

    }

    public AuthService getAuthService() {
        return authService;
    }

    @Resource(name = "authService")
    public void setAuthService(AuthService authService) {
        this.authService = authService;
    }
}
