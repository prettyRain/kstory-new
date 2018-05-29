package com.ningpai.customer.service;

import com.ningpai.customer.bean.Giftcard;
import com.ningpai.customer.bean.GiftcardSegment;
import com.ningpai.customer.vo.GiftcardVo;
import com.ningpai.deposit.bean.Deposit;
import com.ningpai.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 礼品卡service接口
 */

public interface GiftcardService {

    //验证该礼品卡密码是否可用
    Long checkGiftcardPwd(String giftcardPwd) throws Exception;
    //检查礼品卡有效期
    void checkExpires(GiftcardVo giftcardVo);
    //获取礼品卡信息
    GiftcardVo getGiftcard(Giftcard giftcard) throws Exception;
    //修改礼品卡信息
    int updateGiftcard(GiftcardVo giftcard);

    //查询礼品卡资金信息列表
    PageBean selectGiftcardInfoList(GiftcardVo giftcardVo, PageBean pageBean);
    //查询所有礼品卡生成的卡段
    PageBean searchSegmentList(GiftcardSegment segment, PageBean pageBean);
    //批量添加礼品卡
    int addGiftcardBatch(GiftcardSegment segment) throws Exception;
    //查询卡段
    GiftcardSegment selectSegment(Long id);

    void exportCardNo(HttpServletResponse response, Long id) throws Exception;
    /**
     * 新增礼品卡信息
     */
    void insertGiftCard(Giftcard gc);

    /**
     * 获取最新的电子卡卡号
     * @return
     */
    String getECardNewNo();

    /**
     * 根据订单编号获取电子礼品卡集合
     * @param orderCode
     * @return
     */
    List<Giftcard> selectGiftcardByOrderCode(String orderCode);

    /**
     * 根据卡号和密码验证礼品卡是否存在
     * @param giftcard
     * @return
     */
    GiftcardVo getGiftCardByNoAndPwd(Giftcard giftcard);

    /**
     * 通过手机号查询该用户能否绑定礼品卡
     * @param mob
     * @param request
     * @return
     */
    int validaCustomerAndIsBinding(String mob,HttpServletRequest request);

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
    int saveBindingGift(String gcNo, String gcPwd, String mobile,String smscode, String pwd,HttpServletRequest request);

    /**
     * 保存后台礼品卡充值
     * @param customerId 充值用户
     * @param price 充值金额
     * @param payId 充值方式 “1线下现金”、“2线下刷卡”、“3线下支付宝”、“4线下微信”；
     * @return
     * @throws Exception
     */
    int saveRechargeGiftcard(Long customerId, String price, Long payId);

    int saveGuaShiGiftcard(Long customerId,String gcNo);

    int savetoNewGiftCard(Long customerId,String gcNo);
}
