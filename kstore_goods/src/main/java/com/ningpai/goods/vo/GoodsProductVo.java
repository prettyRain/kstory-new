/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */

package com.ningpai.goods.vo;

import java.math.BigDecimal;
import java.util.List;

import com.ningpai.goods.bean.GoodsProductSupp;
import com.ningpai.goods.bean.ProductWare;

/**
 * 货品信息Vo
 * 
 * @author NINGPAI-YuanKangKang
 * @since 2013年12月27日 下午5:14:20
 * @version 1.0
 */
public class GoodsProductVo {
    /*
     *主键ID
      */
    private Long goodsInfoId;
    /*
     *商品ID
      */
    private Long goodsId;
    /*
     *货号
      */
    private String goodsInfoItemNo;
    /*
     *条形码
      */
    private String goodsInfoBarcode;
    /*
     *货品名称
      */
    private String goodsInfoName;
    /*
     *货品副标题
      */
    private String goodsInfoSubtitle;
    /*
     *是否上架 默认1上架
      */
    private String goodsInfoAdded;
    /*
     *货品库存
      */
    private Long goodsInfoStock;
    /*
     *销售价
      */
    private BigDecimal goodsInfoPreferPrice;
    /*
     *成本价
      */
    private BigDecimal goodsInfoCostPrice;
    /*
     *市场价
      */
    private BigDecimal goodsInfoMarketPrice;
    /*
     *重量
      */
    private BigDecimal goodsInfoWeight;
    /*
     *货品初始图片
      */
    private String goodsInfoImgId;
    /*
     *删除标记
      */
    private String goodsInfoDelflag;
    /*
    *g关联规格
     */
    private List<GoodsSpecVo> goodsSpecVo;
    /*
     *关联的规格值的集合
      */
    private List<GoodsProductReleSpecVo> specVo;
    /*
     *分仓的数据
      */
    private List<ProductWare> productWares;
    /*
     *第三方ID
      */
    private Long thirdId;
    /*
     *第三方店铺名称
      */
    private String thirdName;
    /*
     *第三方标记 0:不是第三方商品 1:第三方商品 2:B2B商品
      */
    private String isThird;
    /*
     *是否显示到列表页
      */
    private String showList;
    /*
     *是否显示到手机版
      */
    private String showMobile;
    /*是否参加会员折扣*/
    private String isCustomerDiscount;

    /*
    *是否包邮 1 包邮 0不包邮
     */
    private String isMailBay;
   
    /*
     *服务支持列表
      */

    
    private String auditStatus;
    
    private String refuseReason;
    

    /*
     *服务支持列表
      */

    private List<GoodsProductSupp> suppList;
    /*
    *订单开始时间，查询使用
     */
    private String startTime;
    /*
    *订单结束时间，查询使用
     */
    private String endTime;
    /*
     *每个货品的销售量
      */
    private Long goodsCount;

    /**
     * 判断是否是赠品  0普通商品  1赠品
     */
    private String isPresent;
    /**
     * 单价 字符串类型的
     * @return
     */
    private String  unitPriceStr;
    public String getUnitPriceStr() {
        return unitPriceStr;
    }

    public void setUnitPriceStr(String unitPriceStr) {
        this.unitPriceStr = unitPriceStr;
    }


    public String getIsPresent() {
        return isPresent;
    }

    public void setIsPresent(String isPresent) {
        this.isPresent = isPresent;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public Long getGoodsCount() {
        return goodsCount;
    }

    public void setGoodsCount(Long goodsCount) {
        this.goodsCount = goodsCount;
    }
    
    
    public String getIsCustomerDiscount() {
        return isCustomerDiscount;
    }

    public void setIsCustomerDiscount(String isCustomerDiscount) {
        this.isCustomerDiscount = isCustomerDiscount;
    }

    public Long getThirdId() {
        return thirdId;
    }

    public void setThirdId(Long thirdId) {
        this.thirdId = thirdId;
    }

    public String getThirdName() {
        return thirdName;
    }

    public void setThirdName(String thirdName) {
        this.thirdName = thirdName;
    }

    public String getIsThird() {
        return isThird;
    }

    public void setIsThird(String isThird) {
        this.isThird = isThird;
    }

    public Long getGoodsInfoId() {
        return goodsInfoId;
    }

    public void setGoodsInfoId(Long goodsInfoId) {
        this.goodsInfoId = goodsInfoId;
    }

    public Long getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Long goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsInfoItemNo() {
        return goodsInfoItemNo;
    }

    public void setGoodsInfoItemNo(String goodsInfoItemNo) {
        this.goodsInfoItemNo = goodsInfoItemNo;
    }
    public String getIsMailBay() {
        return isMailBay;
    }

    public void setIsMailBay(String isMailBay) {
        this.isMailBay = isMailBay;
    }

    public String getGoodsInfoAdded() {
        return goodsInfoAdded;
    }

    public void setGoodsInfoAdded(String goodsInfoAdded) {
        this.goodsInfoAdded = goodsInfoAdded;
    }

    public Long getGoodsInfoStock() {
        return goodsInfoStock;
    }

    public void setGoodsInfoStock(Long goodsInfoStock) {
        this.goodsInfoStock = goodsInfoStock;
    }

    public BigDecimal getGoodsInfoPreferPrice() {
        return goodsInfoPreferPrice;
    }

    public void setGoodsInfoPreferPrice(BigDecimal goodsInfoPreferPrice) {
        this.goodsInfoPreferPrice = goodsInfoPreferPrice;
    }

    public BigDecimal getGoodsInfoCostPrice() {
        return goodsInfoCostPrice;
    }

    public void setGoodsInfoCostPrice(BigDecimal goodsInfoCostPrice) {
        this.goodsInfoCostPrice = goodsInfoCostPrice;
    }

    public BigDecimal getGoodsInfoMarketPrice() {
        return goodsInfoMarketPrice;
    }

    public void setGoodsInfoMarketPrice(BigDecimal goodsInfoMarketPrice) {
        this.goodsInfoMarketPrice = goodsInfoMarketPrice;
    }

    public BigDecimal getGoodsInfoWeight() {
        return goodsInfoWeight;
    }

    public void setGoodsInfoWeight(BigDecimal goodsInfoWeight) {
        this.goodsInfoWeight = goodsInfoWeight;
    }

    public String getGoodsInfoImgId() {
        return goodsInfoImgId;
    }

    public void setGoodsInfoImgId(String goodsInfoImgId) {
        this.goodsInfoImgId = goodsInfoImgId;
    }

    public String getGoodsInfoDelflag() {
        return goodsInfoDelflag;
    }

    public void setGoodsInfoDelflag(String goodsInfoDelflag) {
        this.goodsInfoDelflag = goodsInfoDelflag;
    }

    public List<GoodsProductReleSpecVo> getSpecVo() {
        return specVo;
    }

    public void setGoodsSpecVo(List<GoodsSpecVo> goodsSpecVo) {
        this.goodsSpecVo = goodsSpecVo;
    }

    public List<GoodsSpecVo> getGoodsSpecVo() {
        return goodsSpecVo;
    }

    public void setSpecVo(List<GoodsProductReleSpecVo> specVo) {
        this.specVo = specVo;
    }
    public String getGoodsInfoName() {
        return goodsInfoName;
    }

    public void setGoodsInfoName(String goodsInfoName) {
        this.goodsInfoName = goodsInfoName;
    }

    public String getGoodsInfoSubtitle() {
        return goodsInfoSubtitle;
    }

    public void setGoodsInfoSubtitle(String goodsInfoSubtitle) {
        this.goodsInfoSubtitle = goodsInfoSubtitle;
    }

    public List<ProductWare> getProductWares() {
        return productWares;
    }

    public void setProductWares(List<ProductWare> productWares) {
        this.productWares = productWares;
    }

    public String getShowList() {
        return showList;
    }

    public void setShowList(String showList) {
        this.showList = showList;
    }

    public List<GoodsProductSupp> getSuppList() {
        return suppList;
    }

    public void setSuppList(List<GoodsProductSupp> suppList) {
        this.suppList = suppList;
    }

    public String getShowMobile() {
        return showMobile;
    }

    public void setShowMobile(String showMobile) {
        this.showMobile = showMobile;
    }

    public String getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus) {
        this.auditStatus = auditStatus;
    }

    public String getRefuseReason() {
        return refuseReason;
    }

    public void setRefuseReason(String refuseReason) {
        this.refuseReason = refuseReason;
    }

    public String getGoodsInfoBarcode() {
        return goodsInfoBarcode;
    }

    public void setGoodsInfoBarcode(String goodsInfoBarcode) {
        this.goodsInfoBarcode = goodsInfoBarcode;
    }
}
