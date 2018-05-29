package com.ningpai.dst.goods.bean;

import java.util.List;

/**
 * 电商通查询商品
 */
public class DstGoodsVo {
    //商品id
    private String goodsId;
    //商品类型
    private String goodsType;
    //Sku编码
    private String skuCode;
    //商品名称
    private String goodsName;
    //商品编码(可以唯一标识商品)
    private String goodsNum;
    //创建时间
    private String createTime;
    //颜色
    private String colorName;
    //规格
    private String spec;
    //净重
    private String suttle;
    //净重单位
    private String suttleUnitName;
    //零售价
    private String salesPrice;
    //长
    private String packetLong;
    //宽
    private String packetWide;
    //高
    private String packetHigh;
    //品牌编号
    private String brandId;
    //品牌名称
    private String brandName;
    //分类编号
    private String classifyId;
    //分类名称
    private String classifyName;
    //商品描述
    private String goodsDescribe;
    //组合商品明细信息
    private List<DstComboGoodsDetail> comboGoodsDetails;

    public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsType() {
        return goodsType;
    }

    public void setGoodsType(String goodsType) {
        this.goodsType = goodsType;
    }

    public String getSkuCode() {
        return skuCode;
    }

    public void setSkuCode(String skuCode) {
        this.skuCode = skuCode;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(String goodsNum) {
        this.goodsNum = goodsNum;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getSpec() {
        return spec;
    }

    public void setSpec(String spec) {
        this.spec = spec;
    }

    public String getSuttle() {
        return suttle;
    }

    public void setSuttle(String suttle) {
        this.suttle = suttle;
    }

    public String getSuttleUnitName() {
        return suttleUnitName;
    }

    public void setSuttleUnitName(String suttleUnitName) {
        this.suttleUnitName = suttleUnitName;
    }

    public String getSalesPrice() {
        return salesPrice;
    }

    public void setSalesPrice(String salesPrice) {
        this.salesPrice = salesPrice;
    }

    public String getPacketLong() {
        return packetLong;
    }

    public void setPacketLong(String packetLong) {
        this.packetLong = packetLong;
    }

    public String getPacketWide() {
        return packetWide;
    }

    public void setPacketWide(String packetWide) {
        this.packetWide = packetWide;
    }

    public String getPacketHigh() {
        return packetHigh;
    }

    public void setPacketHigh(String packetHigh) {
        this.packetHigh = packetHigh;
    }

    public String getBrandId() {
        return brandId;
    }

    public void setBrandId(String brandId) {
        this.brandId = brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getClassifyId() {
        return classifyId;
    }

    public void setClassifyId(String classifyId) {
        this.classifyId = classifyId;
    }

    public String getClassifyName() {
        return classifyName;
    }

    public void setClassifyName(String classifyName) {
        this.classifyName = classifyName;
    }

    public String getGoodsDescribe() {
        return goodsDescribe;
    }

    public void setGoodsDescribe(String goodsDescribe) {
        this.goodsDescribe = goodsDescribe;
    }

    public List<DstComboGoodsDetail> getComboGoodsDetails() {
        return comboGoodsDetails;
    }

    public void setComboGoodsDetails(List<DstComboGoodsDetail> comboGoodsDetails) {
        this.comboGoodsDetails = comboGoodsDetails;
    }
}
