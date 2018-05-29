package com.ningpai.goods.dao.impl;

import com.ningpai.goods.bean.GoodsSearch;
import com.ningpai.goods.dao.GoodsSearchMapper;
import com.ningpai.goods.util.SelectBean;
import com.ningpai.goods.vo.GoodsSearchVo;
import com.ningpai.manager.base.BasicSqlSupport;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/22 0022.
 */
@Repository("GoodsSearchMapper")
public class GoodsSearchMapperImpl extends BasicSqlSupport implements GoodsSearchMapper {
    /**
     * 分页查询总行数
     * @param selectBean
     * @return
     */
    @Override
    public int searchTotalCount(SelectBean selectBean) {
        return this.selectOne("com.ningpai.goods.dao.GoodsSearchMapper.searchTotalCount",selectBean);
    }

    /**
     * 分页查询信息
     * @param map
     * @return
     */
    @Override
    public List<Object> searchAllSearch(Map<String, Object> map) {
        return this.selectList("com.ningpai.goods.dao.GoodsSearchMapper.searchAllSearch", map);
    }

    /**
     * 查询关键字是否重复
     *
     * @param searchKeyword
     * @return
     */
    @Override
    public int selectByKeyword(String searchKeyword) {
        return this.selectOne("com.ningpai.goods.dao.GoodsSearchMapper.selectByKeyword", searchKeyword);
    }

    /**
     * 添加关键字
     *
     * @param goodsSearch
     * @return
     */
    @Override
    public int insertGoodsSearch(GoodsSearch goodsSearch) {
        return this.insert("com.ningpai.goods.dao.GoodsSearchMapper.insertGoodsSearch", goodsSearch);
    }

    /**
     * ajax获取关键字对应的分类和品牌
     *
     * @param searchKeyword
     * @return
     */
    @Override
    public GoodsSearchVo findAllByKeywordAjax(String searchKeyword) {
        return this.selectOne("com.ningpai.goods.dao.GoodsSearchMapper.findAllByKeywordAjax",searchKeyword);
    }

    /**
     * 删除关键字
     * @param map
     */
    @Override
    public void deleteGoodsSearch(Map map) {
        this.delete("com.ningpai.goods.dao.GoodsSearchMapper.deleteGoodsSearch",map);
    }

    /**
     * 根据ID查询关键字
     * @param keywordId
     * @return
     */
    @Override
    public GoodsSearchVo queryKeywordById(Long keywordId) {
        return this.selectOne("com.ningpai.goods.dao.GoodsSearchMapper.queryKeywordById",keywordId);
    }

    /**
     * 修改关键字搜索
     * @param goodsSearch
     */
    @Override
    public void updateGoodsSearch(GoodsSearch goodsSearch) {
        this.update("com.ningpai.goods.dao.GoodsSearchMapper.updateGoodsSearch",goodsSearch);
    }

    /**
     * 查看关键字是否被占用
     * @param titleVal
     * @return
     */
    @Override
    public Integer checkedTitleVal(String titleVal) {
        return this.selectOne("com.ningpai.goods.dao.GoodsSearchMapper.checkedTitleVal",titleVal);
    }
}
