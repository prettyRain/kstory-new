package com.ningpai.site.customer.deposit.controller;

import com.ningpai.common.util.BaseSiteController;
import com.ningpai.customer.bean.Customer;
import com.ningpai.customer.bean.Giftcard;
import com.ningpai.customer.service.GiftcardService;
import com.ningpai.customer.vo.GiftcardVo;
import com.ningpai.deposit.bean.Deposit;
import com.ningpai.deposit.bean.Trade;
import com.ningpai.index.service.TopAndBottomService;
import com.ningpai.site.customer.deposit.bean.TradeConst;
import com.ningpai.site.customer.deposit.service.SiteDepositService;
import com.ningpai.site.customer.deposit.service.TradeService;
import com.ningpai.site.customer.service.CustomerServiceInterface;
import com.ningpai.site.customer.vo.CustomerAllInfo;
import com.ningpai.site.customer.vo.CustomerConstantStr;
import com.ningpai.util.PageBean;
import com.ningpai.util.UtilDate;
import com.ningpai.utils.SecurityUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Yang on 2016/9/19.
 */
@Controller
public class DepositController extends BaseSiteController {

    @Autowired
    TopAndBottomService topAndBottomService;

    @Autowired
    private SiteDepositService depositService;

    @Autowired
    private TradeService tradeService;

    @Autowired
    private CustomerServiceInterface customerServiceInterface;

    @Autowired
    private GiftcardService giftcardService;

    @RequestMapping("/depositlist")
    @ResponseBody
    public List<Deposit> depositList(HttpServletRequest request) {

        // 获取用户id
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        // 判断用户id是否为空
        if (customerId == null) {
            return null;
        }
        //组织参数map
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("customerId", customerId);
        List<Deposit> result = depositService.depositList(paramMap);
        return result;
    }

    /**
     * 页面，我的预存款
     *
     * @return
     */
    @RequestMapping("/deposit/mydepositOld")
    public ModelAndView myDeposit(HttpServletRequest request, PageBean pb) {
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        if (customerId == null) {
            ModelAndView mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT);
            return topAndBottomService.getTopAndBottom(mav);
        }
        String time = request.getParameter("time") == null ? "" : request.getParameter("time");/* 保证time不空，进入到mapper中的choose */
        String type = request.getParameter("type") == null ? "" : request.getParameter("type");
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("customerId", customerId);

        Deposit deposit = depositService.getDeposit(paramMap);

        paramMap.put("time", time);
        //查询分页信息
        //queryParam.put("startRowNum",startRowNum);
        String[][] types = new String[][]{
                {"0", "1"},//收入
                {"2", "3"},//支出
        };
        //无效数字保护
        if (!("0".equals(type) || "1".equals(type))) {
            type = "";
        }
        if (StringUtils.isNumeric(type)) {
            paramMap.put("types", types[Integer.valueOf(type)]);
        }
        //pb.setPageSize(2);
        PageBean pageBean = tradeService.pageTrade(paramMap, pb);
        pageBean.setUrl("customer/mydeposit");
        ModelAndView mav = new ModelAndView("deposit/mydeposit");
        mav.addObject("customerId", customerId);
        mav.addObject("deposit", deposit);
        mav.addObject("pwdExist", StringUtils.isNotBlank(deposit.getPayPassword()));
        mav.addObject("pb", pageBean);
        mav.addObject("type", type);
        mav.addObject("time", time);

        return withTopAndBottom(mav);
    }

    /**
     * 修改密码
     *
     * @param request
     * @return
     */
    @RequestMapping("/deposit/changepaypasswordview")
    public ModelAndView changePayPasswordView(HttpServletRequest request) {
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        if (customerId == null) {
            ModelAndView mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT);
            return topAndBottomService.getTopAndBottom(mav);
        }
        ModelAndView mav = new ModelAndView("deposit/setPasswordStep1");
        mav.addObject(CustomerConstantStr.CUSTOMER, customerServiceInterface.queryCustomerById(customerId));
        return withTopAndBottom(mav);
    }

    @RequestMapping("/deposit/sendvalidatecode")
    @ResponseBody
    public int sendValidateCode(HttpServletRequest request) {
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        CustomerAllInfo customer = (CustomerAllInfo) customerServiceInterface.queryCustomerById(customerId);
        String mobile = customer.getInfoMobile();
        // 根据session中的customerId查询用户信息
        CustomerAllInfo user = customerServiceInterface.selectByPrimaryKey(customerId);
        if (user == null) {
            return -1;
        }
        // 发送手机验证码
        int result = customerServiceInterface.sendPost(request, user.getInfoMobile());
        return result;
    }

    @RequestMapping("/deposit/validatecode")
    public ModelAndView validateCode(HttpServletRequest request, String code) {
        ModelAndView mav = new ModelAndView();
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        if (customerId == null) {
            mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT);
            return topAndBottomService.getTopAndBottom(mav);
        }

        //@return 0不同 1相同
        int result = customerServiceInterface.getMCode(request, code);
        if (result == 1) {
            mav = new ModelAndView("deposit/setPasswordStep2");
            request.getSession().setAttribute("mobileCode", code);
        } else {
            mav = new ModelAndView("deposit/setPasswordStep1");
            mav.addObject("msg", "验证码不正确");
            mav.addObject("retcode", "-1");
            mav.addObject(CustomerConstantStr.CUSTOMER, customerServiceInterface.queryCustomerById(customerId));
        }
        return withTopAndBottom(mav);
    }

    /**
     * 设置支付密码
     *
     * @param request
     * @return
     */
    @RequestMapping("/deposit/resetpaypwd")
    public ModelAndView resetPwd(HttpServletRequest request) {
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        if (customerId == null) {//未登录直接到登陆页面
            ModelAndView mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT);
            return withTopAndBottom(mav);
        }

        ModelAndView mav = null;
        String code = (String) request.getSession().getAttribute("mobileCode");
        //空
        if (StringUtils.isBlank(code)) {
            mav = new ModelAndView("deposit/setPasswordStep1");
            mav.addObject(CustomerConstantStr.CUSTOMER, customerServiceInterface.queryCustomerById(customerId));
            return withTopAndBottom(mav);
        }
        //验证结果
        /*
        int val = customerServiceInterface.getMCode(request, code);
        if(val != 1){
            mav = new ModelAndView("deposit/setPasswordStep1");
            mav.addObject(CustomerConstantStr.CUSTOMER, customerServiceInterface.queryCustomerById(customerId));
            return topAndBottomService.getTopAndBottom(mav);
        }else{

        }
        */
        mav = new ModelAndView("deposit/setPasswordStep3");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        if (StringUtils.isBlank(password)) {
            mav.addObject("msg", "密码为空");
            mav.addObject("retcode", "-1");
            return withTopAndBottom(mav);
        }
        if (StringUtils.isBlank(repassword)) {
            mav.addObject("msg", "确认密码为空");
            mav.addObject("retcode", "-1");
            return withTopAndBottom(mav);
        }
        if (!StringUtils.equals(password, repassword)) {
            mav.addObject("msg", "两次密码不一致");
            mav.addObject("retcode", "-1");
            return withTopAndBottom(mav);
        }

        Map<String, Object> params = new HashMap<>();
        params.put("customerId", customerId);
//        Customer customer = customerServiceInterface.queryCustomerById(customerId);
        // 生成盐值
        String salt = SecurityUtil.getNewPsw();
        params.put("userSaltVal", salt);

        String encodePwd = SecurityUtil.getStoreLogpwd(customerId.toString(), password, salt);

        params.put("payPassword", encodePwd);

        int result = depositService.resetPayPassword(params);
        if (result == 1) {
            mav.addObject("msg", "恭喜您，密码重置成功！");
            mav.addObject("retcode", "1");
        } else {
            mav.addObject("retcode", "-1");
        }
        //删除掉这个session内容
        request.getSession().removeAttribute("mobileCode");
        return withTopAndBottom(mav);
    }


    /**
     * 初始密码设置页
     *
     * @param request
     * @return
     */
    @RequestMapping("/deposit/setpaypasswordview")
    public ModelAndView setPayPasswordView(HttpServletRequest request) {
        ModelAndView mav = null;
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        if (customerId == null) {
            mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT);
            return topAndBottomService.getTopAndBottom(mav);
        }
        mav = new ModelAndView("deposit/setPayPassword");
        mav.addObject(CustomerConstantStr.CUSTOMER, customerServiceInterface.queryCustomerById(customerId));
        return withTopAndBottom(mav);
    }

    /**
     * 设置支付密码
     *
     * @param request
     * @return
     */
    @RequestMapping("/deposit/setpaypassword")
    public ModelAndView setPayPassword(HttpServletRequest request) {
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        if (customerId == null) {//未登录直接到登陆页面
            ModelAndView mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT);
            return withTopAndBottom(mav);
        }

        Customer customer = customerServiceInterface.queryCustomerById(customerId);

        ModelAndView mav = new ModelAndView("deposit/setPayPassword");
        mav.addObject(CustomerConstantStr.CUSTOMER, customer);

        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        if (StringUtils.isBlank(password)) {
            mav.addObject("msg", "密码为空");
            mav.addObject("retcode", "-1");
            return withTopAndBottom(mav);
        }
        if (StringUtils.isBlank(repassword)) {
            mav.addObject("msg", "确认密码为空");
            mav.addObject("retcode", "-1");
            return withTopAndBottom(mav);
        }
        if (!StringUtils.equals(password, repassword)) {
            mav.addObject("msg", "两次密码不一致");
            mav.addObject("retcode", "-1");
            return withTopAndBottom(mav);
        }

        String code = request.getParameter("mobileCode");
        //空
        if (StringUtils.isBlank(code)) {
            mav.addObject("msg", "请填写验证码");
            mav.addObject("retcode", "-1");
            return withTopAndBottom(mav);
        }

        //验证结果
        int val = customerServiceInterface.getMCode(request, code);
        if (val != 1) {
            mav.addObject("msg", "验证码不正确");
            mav.addObject("retcode", "-1");
            return withTopAndBottom(mav);
        }

        mav.setViewName("deposit/setPayPassword_result");

        // 生成盐值
        String salt = SecurityUtil.getNewPsw();
        String encodePwd = SecurityUtil.getStoreLogpwd(customerId.toString(), password, salt);

        Map<String, Object> params = new HashMap<>();
        params.put("customerId", customerId);
        params.put("payPassword", encodePwd);
        params.put("userSaltVal", salt);
        int result = depositService.resetPayPassword(params);
        if (result == 1) {
            mav.addObject("msg", "恭喜您，密码设置成功！");
            mav.addObject("retcode", "1");
        } else {
            mav.addObject("msg", "很抱歉，密码设置失败！");
            mav.addObject("retcode", "-1");
        }
        return withTopAndBottom(mav);
    }

    private ModelAndView withTopAndBottom(ModelAndView mav) {
        return topAndBottomService.getTopAndBottom(mav);
    }

    /**
     * 跳转到我的礼品卡页面
     */
    @RequestMapping("/deposit/mydeposit")
    public ModelAndView myGiftcard(HttpServletRequest request, HttpServletResponse response, PageBean pb) {
        ModelAndView mav;
        // 验证登录
        if (request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID) != null) {
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
            String time = request.getParameter("time") == null ? "" : request.getParameter("time");/* 保证time不空，进入到mapper中的choose */
            String type = request.getParameter("type") == null ? "" : request.getParameter("type");
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("customerId", customerId);

            Deposit deposit = depositService.getDeposit(paramMap);

            paramMap.put("time", time);
            //查询分页信息
            String[][] types = new String[][]{
                    //新增 4线下现金充值 5线下刷卡充值 6线下支付宝充值 7线下微信充值
                    {"0", "1","4","5","6","7"},//收入
                    {"2", "3", "8"},//支出
            };
            //无效数字保护
            if (!("0".equals(type) || "1".equals(type))) {
                type = "";
            }
            if (StringUtils.isNumeric(type)) {
                paramMap.put("types", types[Integer.valueOf(type)]);
            }
            String activeFlag = "0";
            if(StringUtils.isNotEmpty(deposit.getGiftcardNo())){
                try {
                    activeFlag = giftcardService.getGiftcard(new Giftcard(deposit.getGiftcardNo(), null)).getActiveFlag();
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
            //pb.setPageSize(2);
            PageBean pageBean = tradeService.pageTrade(paramMap, pb);
            pageBean.setUrl("customer/mygiftcard");
            mav = new ModelAndView("giftcard/mygiftcard");
            mav.addObject("customerId", customerId);
            mav.addObject("deposit", deposit);
            mav.addObject("pwdExist", StringUtils.isNotBlank(deposit.getPayPassword()));
            mav.addObject("pb", pageBean);
            mav.addObject("type", type);
            mav.addObject("time", time);
            mav.addObject("activeFlag",activeFlag);
            // 记录日志
        } else {
            mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT).addObject(CustomerConstantStr.URL, CustomerConstantStr.CUSTOMERS + "mygiftcard");
        }
        return topAndBottomService.getTopAndBottom(mav);
    }

    /**
     * 跳转到绑定礼品卡页面（第一步）
     *
     * @return
     */
    @RequestMapping("/giftcard/bindGiftcardFirst")
    public ModelAndView bindGiftcard(HttpServletRequest request) {
        ModelAndView mav;
        // 验证登录
        if (request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID) != null) {
            mav = new ModelAndView("/giftcard/bindGiftcard1");
        } else {
            mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT).addObject(CustomerConstantStr.URL, CustomerConstantStr.CUSTOMERS + "mygiftcard");
        }
        return topAndBottomService.getTopAndBottom(mav);
    }

    /**
     * 判断验证码
     *
     * @return
     */
    @RequestMapping("/giftcard/checkCode")
    @ResponseBody
    public int checkCode(HttpServletRequest request, String checkCode) {
        // 验证 验证码是否正确
        String patchca = (String) request.getSession().getAttribute("PATCHCA");
        if (checkCode == null || patchca == null || !checkCode.equals(patchca)) {
            return 0;
        } else {
            // 清掉session中的验证码
            //request.getSession().setAttribute("PATCHCA", null);
            return 1;
        }
    }

    /**
     * 跳转到设置支付密码页面（第二步）
     *
     * @param request
     * @param giftcardPwd
     * @return
     */
    @RequestMapping("/giftcard/bindGiftcardSecond")
    public ModelAndView bindGiftcardSecond(HttpServletRequest request, String giftcardPwd) {
        ModelAndView mav;
        // 验证登录
        if (request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID) != null) {
            mav = new ModelAndView("/giftcard/bindGiftcard2").addObject("giftcardPwd", giftcardPwd);
        } else {
            mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT).addObject(CustomerConstantStr.URL, CustomerConstantStr.CUSTOMERS + "mygiftcard");
        }
        return topAndBottomService.getTopAndBottom(mav);
    }

    /**
     * 绑定用户的礼品卡信息（第三步）
     *
     * @return
     */
    @RequestMapping("/giftcard/updateGiftcard")
    public ModelAndView updateGiftcard(HttpServletRequest request, Deposit deposit, String giftcardPwd) throws Exception {
        ModelAndView mav = new ModelAndView(new RedirectView(request.getContextPath() + "/index.html"));
        // 验证登录
        if (request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID) != null) {
            String customerId = request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID).toString();
            if (deposit.getPayPassword() == null || giftcardPwd == null) {
                throw new NullPointerException();
            }
            Customer customer = customerServiceInterface.queryCustomerById(Long.valueOf(customerId));
            GiftcardVo giftcard = giftcardService.getGiftcard(new Giftcard(null, giftcardPwd));

            //第一次礼品卡金额加入用户账户，添加交易记录
            BigDecimal giftcardPrice = giftcard.getGiftcardPrice();
            //礼品卡面额上限
            if (giftcardPrice.compareTo(TradeConst.MAX_PER_RECHARGE) > 0) {
                return null;
            }
            // 生成交易订单号
            int randomNum = new Random().nextInt(9000) + 1000;
            String orderCode = "G" + UtilDate.mathString(new Date()) + randomNum;
            saveTrade(Long.valueOf(customerId), orderCode, giftcardPrice, "在线充值-礼品卡");
            //添加交易记录end

            //绑定账户和礼品卡
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("customerId", customerId);
            Deposit deposit0 = depositService.getDeposit(paramMap);
            String encodePwd = SecurityUtil.getStoreLogpwd(customer.getUniqueCode(), deposit.getPayPassword(), customer.getSaltVal());
            paramMap.put("payPassword", encodePwd);
            paramMap.put("passwordTime", new Date());
            paramMap.put("preDeposit", giftcardPrice.add(deposit0.getPreDeposit()));
            paramMap.put("giftcardNo", giftcard.getGiftcardNo());
            int i = depositService.updateDeposit(paramMap);

            if (i == 1) {
                //修改礼品卡信息（激活状态：2，面值：0）
                giftcard.setGiftcardPrice(BigDecimal.valueOf(0.00));
                giftcard.setActiveFlag("2");
                giftcard.setCustomerId(null);
                int j = giftcardService.updateGiftcard(giftcard);
                mav = new ModelAndView(new RedirectView("/customer/mygiftcard.html"));
            }
        } else {
            mav = new ModelAndView(CustomerConstantStr.LOGINREDIRECT).addObject(CustomerConstantStr.URL, CustomerConstantStr.CUSTOMERS + "mygiftcard");
        }
        return topAndBottomService.getTopAndBottom(mav);
    }


    private int saveTrade(Long customerId, String orderCode, BigDecimal totalPrice, String remark) {
        Map<String, Object> qParam = new HashMap<>();
        qParam.put("customerId", customerId);
        //查总账信息。获取可用的余额信息
        Deposit deposit = depositService.getDeposit(qParam);

        BigDecimal preDeposit = deposit.getPreDeposit();
        BigDecimal freezePreDeposit = deposit.getFreezePreDeposit();
        BigDecimal currentPrice = preDeposit.add(freezePreDeposit);
        Trade tTrade = new Trade();
        tTrade.setCustomerId(customerId);
        tTrade.setCreatePerson(customerId);
        tTrade.setCreateTime(new Date());
        tTrade.setOrderPrice(totalPrice);
        tTrade.setDelFlag("0");
        tTrade.setOrderCode(orderCode);
        tTrade.setOrderStatus("6");
        tTrade.setOrderType("0");
        tTrade.setTradeRemark(remark);
        //当前可用余额信息。
        tTrade.setCurrentPrice(currentPrice.add(totalPrice));
        int ret = tradeService.saveTrade(tTrade);
        return ret;
    }
}
