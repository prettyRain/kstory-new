package com.ningpai.goods.service;

import com.ningpai.goods.bean.GoodsSearch;
import com.ningpai.goods.util.SelectBean;
import com.ningpai.goods.vo.GoodsSearchVo;
import com.ningpai.util.PageBean;

import java.util.Map;

/**
 * 商品搜索service层接口
 */
public interface GoodsSearchService {
    /**
     * 参数查询分页bean
     * @param pb
     * @param selectBean
     * @return
     */
    PageBean searchAllByPageBean(PageBean pb, SelectBean selectBean);

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
     * 根据ID查询关键字类
     * @param keywordId
     * @return
     */
    GoodsSearchVo queryKeywordById(Long keywordId);

    /**
     * 修改关键字搜索
     * @param goodsSearch
     */
    void updateKeywordsform(GoodsSearch goodsSearch);

    /**
     *  查看关键字是否被占用
     * @param titleVal
     * @return
     */
    Integer checkedTitleVal(String titleVal);
}
