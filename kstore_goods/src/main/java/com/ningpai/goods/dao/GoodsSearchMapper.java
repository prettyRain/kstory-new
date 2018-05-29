package com.ningpai.goods.dao;

import com.ningpai.goods.bean.GoodsSearch;
import com.ningpai.goods.util.SelectBean;
import com.ningpai.goods.vo.GoodsSearchVo;

import java.util.List;
import java.util.Map;

/**
 * 商品搜索Dao
 */
public interface GoodsSearchMapper {
    /**
     * 分页查询总行数
     * @param selectBean
     * @return
     */
    int searchTotalCount(SelectBean selectBean);

    /**
     * 分页查询信息
     * @param map
     * @return
     */
    List<Object> searchAllSearch(Map<String, Object> map);

    /**
     * 查询关键字是否重复
     * @param searchKeyword
     * @return
     */
    int selectByKeyword(String searchKeyword);

    /**
     * 添加关键字
     * @param goodsSearch
     * @return
     */
    int insertGoodsSearch(GoodsSearch goodsSearch);

    /**
     * ajax获取关键字对应的分类和品牌
     * @param searchKeyword
     * @return
     */
    GoodsSearchVo findAllByKeywordAjax(String searchKeyword);

    /**
     * 删除关键字
     * @param map
     */
    void deleteGoodsSearch(Map map);

    /**
     * 根据ID查询关键字
     * @param keywordId
     * @return
     */
    GoodsSearchVo queryKeywordById(Long keywordId);

    /**
     * 修改关键字搜索
     * @param goodsSearch
     */
    void updateGoodsSearch(GoodsSearch goodsSearch);

    /**
     * 查看关键字是否被占用
     * @param titleVal
     * @return
     */
    Integer checkedTitleVal(String titleVal);
}
