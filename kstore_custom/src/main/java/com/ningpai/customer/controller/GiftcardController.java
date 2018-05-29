/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.customer.controller;

import com.ningpai.comment.bean.ValueUtil;
import com.ningpai.common.safe.CSRFTokenManager;
import com.ningpai.customer.bean.Giftcard;
import com.ningpai.customer.bean.GiftcardSegment;
import com.ningpai.customer.service.GiftcardService;
import com.ningpai.customer.util.GiftcardUtil;
import com.ningpai.customer.vo.GiftcardVo;
import com.ningpai.other.util.CustomerConstantStr;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 礼品卡控制层
 */
@Controller
public class GiftcardController {
    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(GiftcardController.class);

    private static final String PAGEBEAN = "pageBean";

    @Autowired
    private GiftcardService giftcardService;

    /**
     * 通过礼品卡密码获取详细信息
     * @param giftcardPwd
     * @return
     */
    @RequestMapping("/giftcard/getGiftcard")
    @ResponseBody
    public GiftcardVo getGiftcard(String giftcardPwd) throws Exception {
        Giftcard giftcard = new Giftcard();
        giftcard.setGiftcardPwd(giftcardPwd);
        return giftcardService.getGiftcard(giftcard);
    }

    /**
     * 礼品卡资金列表
     *
     * @param giftcardVo
     * @param pageBean
     * @return
     */
    @RequestMapping("/initGiftcardInfoList")
    public ModelAndView selectGiftcardInfoList(HttpServletRequest request, GiftcardVo giftcardVo, PageBean pageBean) {
        Map<String, Object> result = null;
        Integer pageNoInt = 1;
        String pageNostr = null;
        try {
            pageNostr = request.getParameter("pageNos");
            if(pageNostr!=null && pageNostr!=""){
                pageNoInt = Integer.valueOf(pageNostr);
            }
            if(pageNoInt > 1){
                pageBean.setPageNo(pageNoInt);
            }
            //查询平台总金额
            //result = depositInfoService.selectTotalDesposit();
            pageBean.setUrl(CustomerConstantStr.INITGIFTCARDINFOLIST);
            LOGGER.info("查询会员资金！");
            pageBean = giftcardService.selectGiftcardInfoList(giftcardVo, pageBean);
        } catch (Exception e) {
            LOGGER.error(e.toString());
        }
        return new ModelAndView(CustomerConstantStr.GIFTCARDINFOJSP, PAGEBEAN, pageBean).addObject("result", result);
    }

    /**
     * 跳转到礼品卡激活页面
     * @return
     */
    @RequestMapping("/toActiveGiftcard")
    public ModelAndView toActiveGiftcard(){
        return new ModelAndView("jsp/customer/giftcardActive");
    }

    @RequestMapping("/activeGiftcard")
    @ResponseBody
    public int activeGiftcard(HttpServletRequest request, Giftcard giftcard) throws Exception {
        GiftcardVo giftcardVo = giftcardService.getGiftcard(giftcard);
        if(giftcardVo!=null && !"-1".equals(giftcardVo.getActiveFlag())){
            //礼品卡是否激活
            if("0".equals(giftcardVo.getActiveFlag())){
                giftcardVo.setActiveFlag("1");
                giftcardVo.setActiveTime(new Date());
                giftcardVo.setActiveName(request.getSession().getAttribute(ValueUtil.NAME).toString());
                giftcardService.updateGiftcard(giftcardVo);
                return 1;
            }
            return 2;
        }
        return 0;
    }

    /**
     * 跳转到礼品卡制作页面
     * @return
     */
    @RequestMapping("/toMakeGiftcard")
    public ModelAndView toMakeGiftcard(HttpServletRequest request, PageBean pageBean, GiftcardSegment segment){
        // 设置本地路径
        pageBean.setUrl("toMakeGiftcard.htm");
        // 获取列表
        PageBean pageBean1 = giftcardService.searchSegmentList(segment, pageBean);
        // 返回到页面
        return new ModelAndView("jsp/customer/giftcardMake", PAGEBEAN, pageBean1).addObject("sx", request.getSession()
                .getAttribute(CSRFTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME).toString());
    }

    /**
     * 制作礼品卡
     * @return
     */
    @RequestMapping("/makeGiftcard")
    @ResponseBody
    public int makeGiftcard(HttpServletRequest request, GiftcardSegment segment) throws Exception {
        segment.setCreateTime(new Date());
        segment.setCreateName(request.getSession().getAttribute(ValueUtil.NAME).toString());
        int i = giftcardService.addGiftcardBatch(segment);
        //1：成功，0：失败，-1：卡号已存在，2：卡号超出位数
        return i;
    }

    /**
     * 查看卡段包含的所有礼品卡
     * @return
     */
    @RequestMapping("/selectCardSegmentAjax")
    @ResponseBody
    public Map<String, Object> selectCardSegmentAjax(PageBean pageBean, Long id){
        // 创建map
        Map<String, Object> map = new HashMap<String, Object>();
        // 查询礼品卡
        map.put(PAGEBEAN, giftcardService.selectSegment(id).getGiftcardList());
        return map;
    }

    /**
     * 导出卡段包含的所有礼品卡
     * @return
     */
    @RequestMapping("/exportCardNo")
    @ResponseBody
    public void exportCardNo(HttpServletResponse response, Long id) throws Exception {
        LOGGER.info("导出礼品卡列表");
        giftcardService.exportCardNo(response,id);
    }

    /**
     * 根据卡号和密码判断是否存在
     * @return
     */
    @RequestMapping("/validaGiftcard")
    @ResponseBody
    public int getGiftcard(String gcNo,String gcPwd) throws Exception {
        Giftcard giftcard = new Giftcard();
        giftcard.setGiftcardNo(gcNo);
        giftcard.setGiftcardPwd(GiftcardUtil.encodePwd(gcPwd));
        giftcard = giftcardService.getGiftCardByNoAndPwd(giftcard);
        if(giftcard != null && !giftcard.getActiveFlag().equals("2")){
            return 1;
        }
        return 0;
    }

    /**
     * 验证礼品卡绑定手机号
     * @param mob 绑定手机号
     * @return -1 手机号未注册 0 手机号已绑定礼品卡 1 可以绑定，发送验证码
     * @throws Exception
     */
    @RequestMapping("/sendGiftBindingSMS")
    @ResponseBody
    public int sendGiftBindingSMS(String mob,HttpServletRequest request) throws Exception {
        return giftcardService.validaCustomerAndIsBinding(mob,request);
    }

    /**
     * 保存会员绑定礼品卡
     * @param gcNo 礼品卡卡号
     * @param gcPwd 礼品卡密码
     * @param mobile 会员手机号
     * @param pwd 支付密码
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveBindingGift")
    @ResponseBody
    public int saveBindingGift(String gcNo,String gcPwd,String mobile,String smscode,String pwd,HttpServletRequest request) throws Exception {
        return giftcardService.saveBindingGift(gcNo,gcPwd,mobile,smscode,pwd,request);
    }


    /**
     * 保存后台礼品卡充值
     * @param customerId 充值用户
     * @param price 充值金额
     * @param payId 充值方式 “1线下现金”、“2线下刷卡”、“3线下支付宝”、“4线下微信”；
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveRechargeGiftcard")
    @ResponseBody
    public int saveRechargeGiftcard(Long customerId,String price,Long payId) throws Exception {
        return giftcardService.saveRechargeGiftcard(customerId,price,payId);
    }

    @RequestMapping("/saveGuaShiGiftcard")
    @ResponseBody
    public int saveGuaShiGiftcard(Long customerId,String gcNo) throws Exception {
        return giftcardService.saveGuaShiGiftcard(customerId,gcNo);
    }

    @RequestMapping("/savetoNewGiftCard")
    @ResponseBody
    public int savetoNewGiftCard(Long customerId,String gcNo) throws Exception {
        return giftcardService.savetoNewGiftCard(customerId,gcNo);
    }
}
