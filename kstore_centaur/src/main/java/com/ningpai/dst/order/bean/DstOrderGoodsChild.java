package com.ningpai.dst.order.bean;

import java.math.BigDecimal;

/**
 * 电商通获取订单商品
 */
public class DstOrderGoodsChild {
    //商品id
    private int goodsId;
    //订单编号
    private String goodsOrderCode;
    //商品名称
    private String goodsName;
    //sku编码
    private String skuCode;
    //规格
    private String spec;
    //颜色
    private String color;
    //商品编码
    private String goodsNum;
    //订购数量
    private int amount;
    //原价
    private BigDecimal price;
    //优惠金额
    private BigDecimal goodsDiscountFee;
    //成交金额
    private BigDecimal saleFee;
    //操作标记
    private String isGift;
    //商品行状态
    private String status;
    //订单商品行ID
    private String orderGoodsId;
    //商品库位
    private String goodsLocation;

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsOrderCode() {
        return goodsOrderCode;
    }

    public void setGoodsOrderCode(String goodsOrderCode) {
        this.goodsOrderCode = goodsOrderCode;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getSkuCode() {
        return skuCode;
    }

    public void setSkuCode(String skuCode) {
        this.skuCode = skuCode;
    }

    public String getSpec() {
        return spec;
    }

    public void setSpec(String spec) {
        this.spec = spec;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(String goodsNum) {
        this.goodsNum = goodsNum;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getGoodsDiscountFee() {
        return goodsDiscountFee;
    }

    public void setGoodsDiscountFee(BigDecimal goodsDiscountFee) {
        this.goodsDiscountFee = goodsDiscountFee;
    }

    public BigDecimal getSaleFee() {
        return saleFee;
    }

    public void setSaleFee(BigDecimal saleFee) {
        this.saleFee = saleFee;
    }

    public String getIsGift() {
        return isGift;
    }

    public void setIsGift(String isGift) {
        this.isGift = isGift;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrderGoodsId() {
        return orderGoodsId;
    }

    public void setOrderGoodsId(String orderGoodsId) {
        this.orderGoodsId = orderGoodsId;
    }

    public String getGoodsLocation() {
        return goodsLocation;
    }

    public void setGoodsLocation(String goodsLocation) {
        this.goodsLocation = goodsLocation;
    }
}
