package com.ningpai.dst.order.bean;

/**
 * 电商通创建订单商品
 */
public class DstOrderGoods {
    //订单商品id
    private String id;
    //商品名称
    private String title;
    //商家外部编码(可以唯一标识商品)
    private String outerId;
    //订购数量
    private String number;
    //销售单价
    private String salePrice;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getOuterId() {
        return outerId;
    }

    public void setOuterId(String outerId) {
        this.outerId = outerId;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(String salePrice) {
        this.salePrice = salePrice;
    }
}
