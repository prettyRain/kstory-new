/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */

package com.ningpai.goods.dao.impl;

import java.util.List;
import java.util.Map;

import com.ningpai.goods.bean.WareHouse;
import org.springframework.stereotype.Repository;

import com.ningpai.goods.bean.ProductWare;
import com.ningpai.goods.dao.ProductWareMapper;
import com.ningpai.manager.base.BasicSqlSupport;

/**
 * 仓库分仓DAO实现
 *
 * @author NINGPAI-YuanKangKang
 * @since 2014年4月28日 下午7:44:08
 * @version 1.0
 */
@Repository("ProductWareMapper")
public class ProductWareMapperImpl extends BasicSqlSupport implements
        ProductWareMapper {
    /**
     *
     * 查询分仓信息
     * */
    @Override
    public WareHouse findWare(Long identifyId) {
        return this.selectOne(
                "com.ningpai.goods.dao.ProductWareMapper.findWare", identifyId);
    }

    /**
     * 插入记录
     *
     * @param record
     * @return 插入的行数
     */
    public int insertSelective(ProductWare record) {
        return this.insert(
                "com.ningpai.goods.dao.ProductWareMapper.insertSelective",
                record);
    }

    /**
     * 更新记录
     *
     * @param record
     *            待更新的实体
     * @return 更新的行数
     */
    public int updateByPrimaryKeySelective(ProductWare record) {
        return this
                .update("com.ningpai.goods.dao.ProductWareMapper.updateByPrimaryKeySelective",
                        record);
    }

    /**
     * 根据货品ID查询所有的记录
     *
     * @param productId
     *            货品ID
     * @return 查询到的集合
     */
    public List<ProductWare> queryAllByProductId(Long productId) {
        return this.selectList(
                "com.ningpai.goods.dao.ProductWareMapper.queryAllByProductId",
                productId);
    }

    /**
     * 根据货品ID查询所有的记录
     *
     * @param productId
     *            货品ID
     * @return 查询到的集合
     */
    public List<ProductWare> queryAllInfoByProductId(Long productId) {
        return this.selectList(
                "com.ningpai.goods.dao.ProductWareMapper.queryAllInfoByProductId",
                productId);
    }


    /**
     * 根据货品ID和仓库ID查询是否已经存在记录
     *
     * @param map
     *            封装参数的MAP
     * @return 查询到的行数
     */
    public int queryCountByProductIdAndWareId(Map<String, Object> map) {
        return this
                .selectOne(
                        "com.ningpai.goods.dao.ProductWareMapper.queryCountByProductIdAndWareId",
                        map);
    }

    /**
     * 根据参数查询主键ID
     *
     * @param map
     *            参数
     * @return 查询到的ID
     */
    public Long queryIdByProductIdAndWareId(Map<String, Object> map) {
        return this
                .selectOne(
                        "com.ningpai.goods.dao.ProductWareMapper.queryIdByProductIdAndWareId",
                        map);
    }

    /**
     * 根据货品ID和城市ID查询关联记录
     *
     * @param map
     *            参数
     * @return 查询到的实体
     */
    public ProductWare queryProductWareByProductIdAndDistinctId(
            Map<String, Long> map) {
        return this
                .selectOne(
                        "com.ningpai.goods.dao.ProductWareMapper.queryProductWareByProductIdAndDistinctId",
                        map);
    }

    /**
     *
     */
    public List<ProductWare> queryGoodsStock(Map map){
          return this.selectList("com.ningpai.goods.dao.ProductWareMapper.queryGoodsStock",map);
    }
    /**
     * 根据仓库id删除记录
     *
     * @param wareId
     * @return
     * @author NINGPAI-LIH
     */
    @Override
    public int deleteWareCity(Long wareId) {
        return this.update(
                "com.ningpai.goods.dao.ProductWareMapper.deleteWareCity",
                wareId);
    }


    /**
     * 根据区县查询没有删除的仓库ID
     * @param district
     * @return
     */
    @Override
    public Long queryWareByDistrict(Long district) {
        return this.selectOne("com.ningpai.goods.dao.ProductWareMapper.queryWareByDistrict",district);
    }
    /**
     * 根据仓库 商品id 查询有没有货
     * @param map
     * @return
     */
    @Override
    public List<Map<String,Long>> queryNumByOrderId(Map map) {
        return this.selectList("com.ningpai.goods.dao.ProductWareMapper.queryNumByOrderId",map);
    }

    /**
     * 查看修改前 订单对应的仓库
     * @param orderId
     * @return
     */
    @Override
    public Long queryOrderWareByOrderId(Long orderId) {
        return this.selectOne("com.ningpai.goods.dao.ProductWareMapper.queryOrderWareByOrderId",orderId);
    }

    /**
     * 查询订单里面商品对应的数量
     * @param orderId
     * @return
     */
    @Override
    public List<Map<String, Long>> queryGoodinfoNumByOrderId(Long orderId) {
        return this.selectList("com.ningpai.goods.dao.ProductWareMapper.queryGoodinfoNumByOrderId",orderId);
    }

    /**
     * 增加旧仓库的商品库存
     * @param oldMap
     */
    @Override
    public void updateOldWareStockByWareAndpro(Map oldMap) {
        this.update("com.ningpai.goods.dao.ProductWareMapper.updateOldWareStockByWareAndpro",oldMap);
    }
    /**
     * 减少新仓库的商品库存
     * @param newMap
     */
    @Override
    public void updateNewWareStockByWareAndpro(Map newMap) {
        this.update("com.ningpai.goods.dao.ProductWareMapper.updateNewWareStockByWareAndpro",newMap);
    }

    /**
     * 根据货品ID和仓库ID查询库存信息
     * @return
     */
    @Override
    public ProductWare queryAllInfoByProductIdAndWareId(Map map) {
        return this.selectOne("com.ningpai.goods.dao.ProductWareMapper.queryAllInfoByProductIdAndWareId",map);
    }

    /**
     * 根据货品ID和仓库ID更新记录
     * @return
     */
    @Override
    public int updateByProductIdAndWareId(Map map) {
        return this
                .update(
                        "com.ningpai.goods.dao.ProductWareMapper.updateByProductIdAndWareId",
                        map);
    }

}
