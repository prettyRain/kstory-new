package com.ningpai.dst.order.bean;

/**
 * 电商通售后订单商品
 */
public class DstRefundOrderGoods {
    //售后单号
    private String refundCode;
    //商品id
    private String goodsId;
    //商品编号
    private String goodsNum;
    //商品名称
    private String title;
    //颜色
    private String color;
    //尺码
    private String Size;
    //sku编码
    private String skuCode;
    //sku名称
    private String skuName;
    //条码
    private String barCode;
    //商品数量（正品数量+次品数量）
    private String num;
    //正品数量
    private String genuineNum;
    //次品数量
    private String defectiveNum;
    //单价
    private String price;
    //总金额（商品数量*单价）
    private String totalFee;
    //分组的名称
    private String groupName;

    public String getRefundCode() {
        return refundCode;
    }

    public void setRefundCode(String refundCode) {
        this.refundCode = refundCode;
    }

    public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(String goodsNum) {
        this.goodsNum = goodsNum;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return Size;
    }

    public void setSize(String size) {
        Size = size;
    }

    public String getSkuCode() {
        return skuCode;
    }

    public void setSkuCode(String skuCode) {
        this.skuCode = skuCode;
    }

    public String getSkuName() {
        return skuName;
    }

    public void setSkuName(String skuName) {
        this.skuName = skuName;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getGenuineNum() {
        return genuineNum;
    }

    public void setGenuineNum(String genuineNum) {
        this.genuineNum = genuineNum;
    }

    public String getDefectiveNum() {
        return defectiveNum;
    }

    public void setDefectiveNum(String defectiveNum) {
        this.defectiveNum = defectiveNum;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(String totalFee) {
        this.totalFee = totalFee;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }
}
