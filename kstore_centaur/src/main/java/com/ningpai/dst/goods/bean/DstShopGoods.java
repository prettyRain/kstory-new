package com.ningpai.dst.goods.bean;

/**
 * 电商通创建店铺商品
 */
public class DstShopGoods {
    //商家外部编码
    private String outerId;
    //商品名称
    private String title;
    //颜色
    private String color;
    //尺码
    private String size;
    //图片URL
    private String picUrl;
    //店铺Id
    private String shopId;

    public String getOuterId() {
        return outerId;
    }

    public void setOuterId(String outerId) {
        this.outerId = outerId;
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
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    public String getShopId() {
        return shopId;
    }

    public void setShopId(String shopId) {
        this.shopId = shopId;
    }
}
