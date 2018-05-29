package com.ningpai.goods.vo;

import com.ningpai.goods.bean.GoodsBrand;

import java.util.List;

/**
 * 商品搜索类
 */
public class GoodsSearchVo {
    /**
     * 搜索ID
     */
    private Long searchId;
    /**
     * 搜索关键字
     */
    private String searchKeyword;
    /**
     * 商品二级分类ID
     */
    private String catId;
    /**
     * 分类排序
     */
    private String catSort;
    /**
     * 关键字的商品分类
     */
    private List<GoodsCateVo> cates;
    /**
     * 商品品牌ID
     */
    private String brandId;
    /**
     * 品牌排序
     */
    private String brandSort;
    /**
     * 关键字的品牌分类
     */
    private List<GoodsBrand> brands;
    /**
     * 备用字段1
     */
    private String temp1;
    /**
     * 备用字段2
     */
    private String temp2;
    /**
     * 备用字段3
     */
    private String temp3;
    /**
     * 备用字段4
     */
    private String temp4;
    /**
     * 备用字段5
     */
    private String temp5;

    public Long getSearchId() {
        return searchId;
    }

    public void setSearchId(Long searchId) {
        this.searchId = searchId;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getCatId() {
        return catId;
    }

    public void setCatId(String catId) {
        this.catId = catId;
    }

    public String getCatSort() {
        return catSort;
    }

    public void setCatSort(String catSort) {
        this.catSort = catSort;
    }

    public String getBrandId() {
        return brandId;
    }

    public void setBrandId(String brandId) {
        this.brandId = brandId;
    }

    public String getBrandSort() {
        return brandSort;
    }

    public void setBrandSort(String brandSort) {
        this.brandSort = brandSort;
    }

    public String getTemp1() {
        return temp1;
    }

    public void setTemp1(String temp1) {
        this.temp1 = temp1;
    }

    public String getTemp2() {
        return temp2;
    }

    public void setTemp2(String temp2) {
        this.temp2 = temp2;
    }

    public String getTemp3() {
        return temp3;
    }

    public void setTemp3(String temp3) {
        this.temp3 = temp3;
    }

    public String getTemp4() {
        return temp4;
    }

    public void setTemp4(String temp4) {
        this.temp4 = temp4;
    }

    public String getTemp5() {
        return temp5;
    }

    public void setTemp5(String temp5) {
        this.temp5 = temp5;
    }

    public List<GoodsCateVo> getCates() {
        return cates;
    }

    public void setCates(List<GoodsCateVo> cates) {
        this.cates = cates;
    }

    public List<GoodsBrand> getBrands() {
        return brands;
    }

    public void setBrands(List<GoodsBrand> brands) {
        this.brands = brands;
    }
}
