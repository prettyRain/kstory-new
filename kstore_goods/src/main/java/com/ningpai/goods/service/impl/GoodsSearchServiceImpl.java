package com.ningpai.goods.service.impl;

import com.ningpai.goods.bean.EsGoodsInfo;
import com.ningpai.goods.bean.GoodsBrand;
import com.ningpai.goods.bean.GoodsSearch;
import com.ningpai.goods.dao.GoodsBrandMapper;
import com.ningpai.goods.dao.GoodsCateMapper;
import com.ningpai.goods.dao.GoodsSearchMapper;
import com.ningpai.goods.service.GoodsElasticSearchService;
import com.ningpai.goods.service.GoodsSearchService;
import com.ningpai.goods.util.GoodsIndexConstant;
import com.ningpai.goods.util.SearchPageBean;
import com.ningpai.goods.util.SelectBean;
import com.ningpai.goods.util.ValueUtil;
import com.ningpai.goods.vo.GoodsCateVo;
import com.ningpai.goods.vo.GoodsSearchVo;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PageBean;
import org.elasticsearch.common.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * 商品搜索service实现类
 */
@Service("GoodsSearchService")
public class GoodsSearchServiceImpl implements GoodsSearchService {
    // 注入GoodsBrandMapper
    @Resource
    private GoodsSearchMapper goodsSearchMapper;

    @Resource
    private GoodsCateMapper goodsCateMapper;

    @Resource(name="GoodsBrandMapper")
    private GoodsBrandMapper goodsBrandMapper;


    /**
     * es搜索处理service
     **/
    @Resource(name = "GoodsElasticSearchService")
    private GoodsElasticSearchService goodsElasticSearchServivice;
    /**
     * 记录日志对象
     */
    private static final MyLogger LOGGER = new MyLogger(
            GoodsSearchServiceImpl.class);
    @Override
    public PageBean searchAllByPageBean(PageBean pageBean, SelectBean selectBean) {
        // 判断查询文本是否为空 若为空 将条件也设置为空
        if ("".equals(selectBean.getSearchText())) {
            selectBean.setCondition("");
        }
        // 设置PageBean的总行数
        pageBean.setRows(this.goodsSearchMapper.searchTotalCount(selectBean));
        // 定义一个HashMap集合
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            // 设置开始行数
            map.put(ValueUtil.STARTROWNUM, pageBean.getStartRowNum());
            // 设置结束行数
            map.put(ValueUtil.ENDROWNUM, pageBean.getEndRowNum());
            map.put(ValueUtil.CONDITION, selectBean.getCondition());
            map.put(ValueUtil.SEARCHTEXT, selectBean.getSearchText());
            map.put(ValueUtil.SELECTBEAN, selectBean);
            // 分页查询数据
            List<Object> searchList = this.goodsSearchMapper.searchAllSearch(map);
            for (Object o : searchList) {
                GoodsSearchVo gs = (GoodsSearchVo)o;
                String[] catIds=new String[]{};
                if(StringUtils.isNotBlank(gs.getCatId())){
                    catIds=gs.getCatId().split(",");
                }
                String[] brandIds = new String[]{};
                if(StringUtils.isNotBlank(gs.getBrandId())){
                    brandIds = gs.getBrandId().split(",");
                }
                List<GoodsCateVo> catelist = new ArrayList();
                List<GoodsBrand> brandlist = new ArrayList();
                if(catIds!=null && catIds.length>0){
                    for (int i = 0;i<catIds.length;i++) {
                        GoodsCateVo goodsCateVo = this.goodsCateMapper.selectByPrimaryKey(Long.parseLong(catIds[i].split("-")[0]));
                        goodsCateVo.setCatSort(Integer.parseInt(catIds[i].split("-")[1]));
                        catelist.add(goodsCateVo);
                    }
                }
                if(brandIds!=null && brandIds.length>0){
                    for (int i = 0;i<brandIds.length;i++) {
                        GoodsBrand goodsBrand = this.goodsBrandMapper.selectByPrimaryKey(Long.parseLong(brandIds[i].split("-")[0]));
                        goodsBrand.setBrandSort(Integer.parseInt(brandIds[i].split("-")[1]));
                        brandlist.add(goodsBrand);
                    }
                }

                if(catelist.size()>0 && catelist!=null){
                    ((GoodsSearchVo) o).setCates(catelist);
                }
                if(brandlist.size()>0 && brandlist!=null){
                    ((GoodsSearchVo) o).setBrands(brandlist);
                }

            }
            pageBean.setList(searchList);
        } finally {
            map = null;
        }
        // 返回结果
        return pageBean;
    }

    /**
     * 查询关键字是否重复
     * @param searchKeyword
     * @return
     */
    @Override
    public int selectByKeyword(String searchKeyword) {
        return this.goodsSearchMapper.selectByKeyword(searchKeyword);
    }

    /**
     * 添加关键字
     * @param goodsSearch
     * @return
     */
    @Override
    public int insertGoodsSearch(GoodsSearch goodsSearch) {
        return this.goodsSearchMapper.insertGoodsSearch(goodsSearch);
    }

    /**
     * ajax获取关键字对应的分类和品牌
     *
     * @param searchKeyword
     * @return
     */
    @Override
    public GoodsSearchVo findAllByKeywordAjax(String searchKeyword) {
        GoodsSearchVo goodsSearchVo = this.goodsSearchMapper.findAllByKeywordAjax(searchKeyword);
        //获取商品分类对象和品牌对象
        if(goodsSearchVo!=null){
            if(goodsSearchVo.getCatId()!=null && !"".equals(goodsSearchVo.getCatId())){
                String[] catIds = goodsSearchVo.getCatId().split(",");
                List<GoodsCateVo> catelist = new ArrayList();
                for (int i = 0;i<catIds.length;i++) {
                    GoodsCateVo goodsCateVo = this.goodsCateMapper.selectByPrimaryKey(Long.parseLong(catIds[i].split("-")[0]));
                    int count = 0;
                    Map<String, Object> paramMap = new HashMap<String, Object>();
                    paramMap.put("cateId", goodsCateVo.getCatId());
                    paramMap.put("cateName", "");
                    // 根据父分类ID 查询子分类列表 计算该分类下商品总数
                    List<GoodsCateVo> goodsCateVos = this.goodsCateMapper.querySonCatVoByParm(paramMap);
                    for (GoodsCateVo cateVo : goodsCateVos) {
                        count += cateVo.getGoodsCount();
                    }
                    goodsCateVo.setGoodsCount(count);
                    goodsCateVo.setCatSort(Integer.parseInt(catIds[i].split("-")[1]));
                    catelist.add(goodsCateVo);
                }
                //对集合排序
                Collections.sort(catelist, new Comparator<GoodsCateVo>() {
                    @Override
                    public int compare(GoodsCateVo o1, GoodsCateVo o2) {
                        int i = o1.getCatSort() - o2.getCatSort();
                        return i;
                    }
                });
                goodsSearchVo.setCates(catelist);
            }
            if(goodsSearchVo.getBrandId()!=null && !"".equals(goodsSearchVo.getBrandId())) {
                String[] brandIds = goodsSearchVo.getBrandId().split(",");
                List<GoodsBrand> brandlist = new ArrayList();
                for (int i = 0; i < brandIds.length; i++) {
                    GoodsBrand goodsBrand = this.goodsBrandMapper.selectByPrimaryKey(Long.parseLong(brandIds[i].split("-")[0]));
                    String[] brands = new String[]{goodsBrand.getBrandName()};
                    //查询该品牌下商品的二级分类及一级分类
                    SearchPageBean<EsGoodsInfo> pageBean = new SearchPageBean<EsGoodsInfo>();
                    pageBean.setPageSize(1);
                    // 索引
                    String[] indices = new String[]{GoodsIndexConstant.PRODUCT_INDEX_NAME()};
                    // 类型
                    String[] types = new String[]{GoodsIndexConstant.PRODUCT_TYPE};
                    Map<String, Object> resultMap = goodsElasticSearchServivice.searchGoods(pageBean, null, indices, types, null, brands, null, null, null,
                            null, null, null, null, null, null, null, null);
                    if(resultMap!=null) {
                        SearchPageBean<EsGoodsInfo> pb = (SearchPageBean<EsGoodsInfo>) resultMap.get("pb");
                        if(pb!=null && pb.getData().size()>0) {
                            //List<EsGoodsCategory> cateList = pb.getData().get(0).getCateList();
                            if (goodsBrand.getBrandUrl() == null || "".equals(goodsBrand.getBrandUrl())) {
                                goodsBrand.setBrandUrl("/goods/searchProduct2.html?title=&brands=" + goodsBrand.getBrandName());
                            }
                            goodsBrand.setBrandSort(Integer.parseInt(brandIds[i].split("-")[1]));
                        }
                    }
                    brandlist.add(goodsBrand);
                }
                //对集合排序
                Collections.sort(brandlist, new Comparator<GoodsBrand>() {
                    @Override
                    public int compare(GoodsBrand o1, GoodsBrand o2) {
                        int i = o1.getBrandSort() - o2.getBrandSort();
                        return i;
                    }
                });
                goodsSearchVo.setBrands(brandlist);
            }
        }
        return goodsSearchVo;
    }

    /**
     * 删除关键字
     * @param map
     */
    @Override
    public void deleteGoodsSearch(Map map) {
        this.goodsSearchMapper.deleteGoodsSearch(map);
    }

    /**
     * 根据ID查询关键字类
     * @param keywordId
     * @return
     */
    @Override
    public GoodsSearchVo queryKeywordById(Long keywordId) {
        GoodsSearchVo goodsSearchVo=this.goodsSearchMapper.queryKeywordById(keywordId);
        if(goodsSearchVo!=null){
            if(goodsSearchVo.getCatId()!=null && !"".equals(goodsSearchVo.getCatId())){
                String[] catIds = goodsSearchVo.getCatId().split(",");
                List<GoodsCateVo> catelist = new ArrayList();
                for (int i = 0;i<catIds.length;i++) {
                    GoodsCateVo goodsCateVo = this.goodsCateMapper.selectByPrimaryKey(Long.parseLong(catIds[i].split("-")[0]));
                    goodsCateVo.setCatSort(Integer.parseInt(catIds[i].split("-")[1]));
                    catelist.add(goodsCateVo);
                }
                goodsSearchVo.setCates(catelist);
            }
            if(goodsSearchVo.getBrandId()!=null && !"".equals(goodsSearchVo.getBrandId())) {
                String[] brandIds = goodsSearchVo.getBrandId().split(",");
                List<GoodsBrand> brandlist = new ArrayList();
                for (int i = 0; i < brandIds.length; i++) {
                    GoodsBrand goodsBrand = this.goodsBrandMapper.selectByPrimaryKey(Long.parseLong(brandIds[i].split("-")[0]));
                    goodsBrand.setBrandSort(Integer.parseInt(brandIds[i].split("-")[1]));
                    brandlist.add(goodsBrand);
                }
                goodsSearchVo.setBrands(brandlist);
            }
        }
        return goodsSearchVo;
    }

    /**
     * 修改关键字搜索
     * @param goodsSearch
     */
    @Override
    public void updateKeywordsform(GoodsSearch goodsSearch) {
       this.goodsSearchMapper.updateGoodsSearch(goodsSearch);
    }

    /**
     * 查看关键字是否被占用
     * @param titleVal
     * @return
     */
    @Override
    public Integer checkedTitleVal(String titleVal) {
        return this.goodsSearchMapper.checkedTitleVal(titleVal);
    }
}
