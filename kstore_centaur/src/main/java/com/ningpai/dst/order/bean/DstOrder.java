package com.ningpai.dst.order.bean;

import com.ningpai.dst.order.bean.DstOrderGoods;

import java.util.List;

/**
 * 电商通创建订单对象
 */
public class DstOrder {
    //订单编号
    private String orderCode;
    //买家ID或昵称
    private String buyerNick;
    //订单状态(waiting_buyer_to_pay:等待买家付款 buyers_have_paid:买家已付款 sellers_have_been_shipped:卖家已发货 trade_finished:交易成功 trade_closed:交易关闭)
    private String orderStatus;
    //拍下时间
    private String created;
    //支付时间
    private String payTime;
    //应收运费
    private String postCharge;
    //应付金额
    private String totalCharge;
    //买家留言
    private String buyerMessage;
    //卖家备注
    private String sellerMemo;
    //收货人姓名
    private String receiverName;
    //收货人电话
    private String receiverPhone;
    //收货人手机
    private String receiverMobile;
    //收货人省
    private String receiverState;
    //收货人市
    private String receiverCity;
    //收货人区
    private String receiverDistrict;
    //收货人详细地址
    private String receiverAddress;
    //店铺ID
    private String shopId;
    //商品名称
    private String title;
    //商家外部编码(可以唯一标识商品)
    private String outerId;
    //订购数量
    private String number;
    //销售单价
    private String salePrice;
    //商品列表
    private List<DstOrderGoods> goodsList;

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getBuyerNick() {
        return buyerNick;
    }

    public void setBuyerNick(String buyerNick) {
        this.buyerNick = buyerNick;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    public String getPostCharge() {
        return postCharge;
    }

    public void setPostCharge(String postCharge) {
        this.postCharge = postCharge;
    }

    public String getTotalCharge() {
        return totalCharge;
    }

    public void setTotalCharge(String totalCharge) {
        this.totalCharge = totalCharge;
    }

    public String getBuyerMessage() {
        return buyerMessage;
    }

    public void setBuyerMessage(String buyerMessage) {
        this.buyerMessage = buyerMessage;
    }

    public String getSellerMemo() {
        return sellerMemo;
    }

    public void setSellerMemo(String sellerMemo) {
        this.sellerMemo = sellerMemo;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverMobile() {
        return receiverMobile;
    }

    public void setReceiverMobile(String receiverMobile) {
        this.receiverMobile = receiverMobile;
    }

    public String getReceiverState() {
        return receiverState;
    }

    public void setReceiverState(String receiverState) {
        this.receiverState = receiverState;
    }

    public String getReceiverCity() {
        return receiverCity;
    }

    public void setReceiverCity(String receiverCity) {
        this.receiverCity = receiverCity;
    }

    public String getReceiverDistrict() {
        return receiverDistrict;
    }

    public void setReceiverDistrict(String receiverDistrict) {
        this.receiverDistrict = receiverDistrict;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getShopId() {
        return shopId;
    }

    public void setShopId(String shopId) {
        this.shopId = shopId;
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

    public List<DstOrderGoods> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<DstOrderGoods> goodsList) {
        this.goodsList = goodsList;
    }
}
