package com.ningpai.goods.dao;

import java.util.List;
import java.util.Map;

import com.ningpai.goods.bean.ProductWare;
import com.ningpai.goods.bean.WareHouse;

/**
 * 货品分仓DAO
 *
 * @author NINGPAI-YuanKangKang
 * @since 2014年4月28日 下午7:35:37
 * @version 1.0
 */
public interface ProductWareMapper {
    /**
     *
     * 查询分仓信息
     * */
    WareHouse findWare(Long did);

    /**
     * 插入记录
     *
     * @param
     * @return 插入的行数
     */
    int insertSelective(ProductWare record);

    /**
     * 更新记录
     *
     * @param record
     *            待更新的实体
     * @return 更新的行数
     */
    int updateByPrimaryKeySelective(ProductWare record);

    /**
     * 根据货品ID查询所有的记录
     *
     * @param productId
     *            货品ID
     * @return 查询到的集合
     */
    List<ProductWare> queryAllByProductId(Long productId);

    /**
     * 根据货品ID查询所有的记录
     *
     * @param productId
     *            货品ID
     * @return 查询到的集合
     */
    List<ProductWare> queryAllInfoByProductId(Long productId);

    /**
     * 根据货品ID和仓库ID查询是否已经存在记录
     *
     * @param map
     *            封装参数的MAP
     * @return 查询到的行数
     */
    int queryCountByProductIdAndWareId(Map<String, Object> map);

    /**
     * 根据参数查询主键ID
     *
     * @param map
     *            参数
     * @return 查询到的ID
     */
    Long queryIdByProductIdAndWareId(Map<String, Object> map);

    /**
     * 根据货品ID和城市ID查询关联记录
     *
     * @param map
     *            参数
     * @return 查询到的实体
     */
    ProductWare queryProductWareByProductIdAndDistinctId(Map<String, Long> map);
    /**
     * 根据商品id查库存
     */
    List<ProductWare> queryGoodsStock(Map map);
    /**
     * 根据仓库id删除记录
     *
     * @param wareId仓库id
     * @return
     * @author NINGPAI-LIH
     */
    int deleteWareCity(Long wareId);

    /**
     * 查询没有被删除的仓库ID
     * @param district
     * @return
     */
    Long queryWareByDistrict(Long district);

    /**
     * 根据仓库 商品id 查询有没有货
     * @param map
     * @return
     */
    List<Map<String,Long>> queryNumByOrderId(Map map);
    /**
     * 查看修改前 订单对应的仓库
     * @param orderId
     * @return
     */
    Long queryOrderWareByOrderId(Long orderId);


    /**
     * 查询订单里面商品对应的数量
     * @param orderId
     * @return
     */
    List<Map<String,Long>> queryGoodinfoNumByOrderId(Long orderId);

    /**
     * 增加旧仓库的商品库存
     * @param oldMap
     */
    void updateOldWareStockByWareAndpro(Map oldMap);

    /**
     * 减少新仓库的商品库存
     * @param newMap
     */
    void updateNewWareStockByWareAndpro(Map newMap);

    /**
     * 根据货品ID和仓库ID查询库存信息
     * @return
     */
    ProductWare queryAllInfoByProductIdAndWareId(Map map);

    /**
     * 根据货品ID和仓库ID查询记录
     * @return
     */
    int updateByProductIdAndWareId(Map map);
}
