package com.ningpai.goods.dao;

import com.ningpai.goods.bean.GoodsSpecDetail;

import java.util.List;
import java.util.Map;

/**
 * 商品规格值DAO
 *
 * @author NINGPAI-YuanKangKang
 * @since 2013年12月18日 下午3:56:11
 * @version 1.0
 */
public interface GoodsSpecDetailMapper {
    /**
     * 根据规格值主键删除
     *
     * @param map
     *            封装的删除的参数包括 待删除的ID，删除人名称 {@link java.util.Map}
     * @return {@link java.lang.Integer}
     */
    int deleteByPrimaryKey(Map<String, String> map);

    /**
     * 插入一条规格值(全属性 不推荐)
     *
     * @param record
     *            {@link com.ningpai.goods.bean.GoodsSpecDetail}
     * @return {@link java.lang.Integer}
     */
    int insert(GoodsSpecDetail record);

    /**
     * 插入一条规格值(可选属性 推荐)
     *
     * @param record
     *            {@link com.ningpai.goods.bean.GoodsSpecDetail}
     * @return {@link java.lang.Integer}
     */
    int insertSelective(GoodsSpecDetail record);

    /**
     * 根据主键查询规格值
     *
     * @param specDetailId
     *            {@link java.lang.Long}
     * @return {@link com.ningpai.goods.bean.GoodsSpecDetail}
     */
    GoodsSpecDetail selectByPrimaryKey(Long specDetailId);

    /**
     * 更新规格值(可选属性 推荐)
     *
     * @param record
     *            {@link com.ningpai.goods.bean.GoodsSpecDetail}
     * @return {@link java.lang.Integer}
     */
    int updateByPrimaryKeySelective(GoodsSpecDetail record);

    /**
     * 更新规格值(全属性 不推荐)
     *
     * @param record
     *            {@link com.ningpai.goods.bean.GoodsSpecDetail}
     * @return {@link java.lang.Integer}
     */
    int updateByPrimaryKey(GoodsSpecDetail record);

    /**
     * 根据规格ID查询规格值列表
     *
     * @param specId
     *            {@link java.lang.Long}
     * @return {@link java.util.List}
     */
    List<Object> querySpecDeetailBySpecId(Long specId);

    /**
     * 根据规格ID查询规格值列表
     *
     * @param specId
     *            {@link java.lang.Long}
     * @return {@link java.util.List}
     * @author NINGPAI-LIH
     */
    List<GoodsSpecDetail> selectSpecDeetailBySpecId(Long specId);

    /**
     * 更新‘货品信息与规格值关联表’中对应id的规格值信息
     * @param goodsSpecDetail
     */
    int updateGoodsInfoReleSpecDetailBySpecDetailId(GoodsSpecDetail goodsSpecDetail);

    /**
     * 更新‘商品开启规格值表’中对应id的规格值信息
     * @param goodsSpecDetail
     * @return
     */
    int updateGoodsOpenspecvalue(GoodsSpecDetail goodsSpecDetail);

    /**
     * 标记商品开启规格值表中对应数据为删除
     * @param specDetailId
     * @return
     */
    int delGoodsOpenspecvalue(Long specDetailId);
}
