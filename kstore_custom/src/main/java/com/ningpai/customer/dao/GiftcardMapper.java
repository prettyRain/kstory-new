package com.ningpai.customer.dao;

import com.ningpai.customer.bean.DepositInfo;
import com.ningpai.customer.bean.Giftcard;
import com.ningpai.customer.bean.GiftcardSegment;
import com.ningpai.customer.vo.GiftcardVo;

import java.util.List;
import java.util.Map;

/**
 * 礼品卡接口
 */
public interface GiftcardMapper {

    //获取礼品卡信息
    GiftcardVo getGiftcard(Giftcard giftcard);
    //修改礼品卡信息
    int updateGiftcard(GiftcardVo giftcard);

    //查询礼品卡资金信息列表总条数，用于分页
    Long selectTotalGiftcardInfo(GiftcardVo giftcardVo);
    //查询礼品卡资金信息列表
    List<Object> selectGiftcardInfoList(GiftcardVo giftcardVo);

    Long selectTotalSegmentInfo(GiftcardSegment segment);

    List<Object> selectSegmentInfoList(GiftcardSegment segment);
    //添加卡段
    int addSegment(GiftcardSegment segment);
    //批量添加礼品卡
    void addGiftcardBatch(List<Giftcard> giftcardList);
    //查询卡段
    GiftcardSegment selectSegment(Long id);

    /**
     * 新增礼品卡信息
     * @param gc 礼品卡
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
     * 查询所有的礼品卡号
     * @return
     */
    List selectAllGiftcardNo();

    DepositInfo selectDepositInfoByNo(Map paramMap);
}
