package com.ningpai.customer.dao.impl;

import com.ningpai.customer.bean.DepositInfo;
import com.ningpai.customer.bean.Giftcard;
import com.ningpai.customer.bean.GiftcardSegment;
import com.ningpai.customer.dao.GiftcardMapper;
import com.ningpai.customer.vo.GiftcardVo;
import com.ningpai.manager.base.BasicSqlSupport;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 礼品卡数据层实现
 */
@Repository("giftcardMapper")
public class GiftcardMapperImpl extends BasicSqlSupport implements GiftcardMapper {
    /**
     * 根据礼品卡密码查找信息
     * @param giftcard
     * @return
     */
    @Override
    public GiftcardVo getGiftcard(Giftcard giftcard) {
        return this.selectOne("com.ningpai.customer.dao.GiftcardMapper.getGiftcard",giftcard);
    }

    /**
     * 修改礼品卡信息
     * @param giftcard
     * @return
     */
    @Override
    public int updateGiftcard(GiftcardVo giftcard) {
        return this.update("com.ningpai.customer.dao.GiftcardMapper.updateGiftcard",giftcard);
    }

    /**
     * 查询礼品卡资金信息列表总条数，用于分页
     * @param giftcardVo
     * @return
     */
    @Override
    public Long selectTotalGiftcardInfo(GiftcardVo giftcardVo) {
        return this.selectOne("com.ningpai.customer.dao.GiftcardMapper.selectTotalGiftcardInfo",giftcardVo);
    }

    /**
     * 查询礼品卡资金信息列表
     * @param giftcardVo
     * @return
     */
    @Override
    public List<Object> selectGiftcardInfoList(GiftcardVo giftcardVo) {
        return this.selectList("com.ningpai.customer.dao.GiftcardMapper.selectGiftcardInfoList",giftcardVo);
    }

    @Override
    public Long selectTotalSegmentInfo(GiftcardSegment segment) {
        return this.selectOne("com.ningpai.customer.dao.GiftcardMapper.selectTotalSegmentInfo",segment);
    }

    @Override
    public List<Object> selectSegmentInfoList(GiftcardSegment segment) {
        return this.selectList("com.ningpai.customer.dao.GiftcardMapper.selectSegmentInfoList",segment);
    }

    /**
     * 添加卡段
     * @param segment
     * @return
     */
    @Override
    public int addSegment(GiftcardSegment segment) {
        return this.insert("com.ningpai.customer.dao.GiftcardMapper.addSegment",segment);
    }

    /**
     * 批量添加礼品卡
     * @param giftcardList
     */
    @Override
    public void addGiftcardBatch(List<Giftcard> giftcardList) {
        this.insert("com.ningpai.customer.dao.GiftcardMapper.addGiftcardBatch", giftcardList);
    }

    /**
     * 查询卡段
     * @param id
     * @return
     */
    @Override
    public GiftcardSegment selectSegment(Long id) {
        return this.selectOne("com.ningpai.customer.dao.GiftcardMapper.selectSegment", id);
    }

     /** 新增礼品卡信息
     * @param gc 礼品卡
     */
    @Override
    public void insertGiftCard(Giftcard gc) {
        this.insert("com.ningpai.customer.dao.GiftcardMapper.insertGiftCard", gc);
    }

    /**
     * 获取最新的电子卡卡号
     * @return
     */
    @Override
    public String getECardNewNo() {
        return this.selectOne("com.ningpai.customer.dao.GiftcardMapper.getECardNewNo");
    }

    /**
     * 根据订单编号获取电子礼品卡集合
     * @param orderCode
     * @return
     */
    @Override
    public List<Giftcard> selectGiftcardByOrderCode(String orderCode) {
         return this.selectList("com.ningpai.customer.dao.GiftcardMapper.selectGiftcardByOrderCode",orderCode);
    }

    /**
     * 查询所有的礼品卡号
     *
     * @return
     */
    @Override
    public List selectAllGiftcardNo() {
        return this.selectList("com.ningpai.customer.dao.GiftcardMapper.selectAllGiftcardNo");
    }

    @Override
    public DepositInfo selectDepositInfoByNo(Map paramMap) {
        return this.selectOne("com.ningpai.customer.dao.GiftcardMapper.selectDepositInfoByNo", paramMap);
    }
}
