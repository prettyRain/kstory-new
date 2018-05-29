package com.ningpai.dst.goods.bean;

/**
 * 电商通组合商品明细信息
 */
public class DstComboGoodsDetail {
    //商品id
    private int goodsId;
    //数量
    private String num;

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }
}
