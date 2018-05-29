package com.ningpai.dst.order.bean;

import com.ningpai.dst.order.bean.DstOrderGoodsChild;

import java.util.List;

/**
 * 电商通获取订单对象
 */
public class DstOrderVo {
    //订单id
    private String id;
    //仓库id
    private String warehouseId;
    //仓库名称
    private String warehouseName;
    //订单编号
    private String orderCode;
    //原单编号
    private String platOderCde;
    //店铺ID
    private String shopId;
    //店铺名称
    private String shopNme;
    //当前状态
    private String orderStatus;
    //交易状态
    private String sysTradeStatus;
    //买家ID
    private String buyer;
    //收货人姓名
    private String receiverName;
    //收货人电话
    private String receiverPhone;
    //收货人手机
    private String receiverMobile;
    //省编码
    private String receiverState;
    //市编码
    private String receiverCity;
    //区编码
    private String receiverDistrict;
    //省
    private String receiverStateName;
    //市
    private String receiverCityNmae;
    //区
    private String receiverDistrictName;
    //收货人详细地址
    private String receiverAddress;
    //邮编
    private String receiverZip;
    //订单总金额
    private String buyerPayment;
    //买家应付货款
    private String buyerNeedPay;
    //运费
    private String buyerPostFee;
    //优惠金额
    private String discountFee;
    //是否货到付款
    private String buyerPayType;
    //快递公司编号
    private String expressId;
    //快递代码
    private String expressCode;
    //快递公司名称
    private String expressName;
    //快递单号
    private String outSid;
    //买家留言
    private String buyerMessage;
    //卖家留言
    private String sellerMessage;
    //内部便签
    private String innerMemo;
    //分组名称
    private String groupId;
    //库存状态
    private String lackStock;
    //拍下时间
    private String platCreateTime;
    //付款时间
    private String platPayTime;
    //生成订单时间
    private String createTime;
    //审核时间
    private String confirmTime;
    //发货时间
    private String sendTime;
    //银行账户
    private String bankAccount;
    //开户银行
    private String depositBank;
    //注册地址
    private String registeredAddress;
    //注册电话
    private String registeredPhone;
    //纳税人识别号
    private String taxpayerIdent;
    //发票种类（ 1 电子发票 2 纸质发票 ）
    private String invoiceKind;
    //发票抬头
    private String invoiceName;
    //商品列表
    private List<DstOrderGoodsChild> goodsList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getPlatOderCde() {
        return platOderCde;
    }

    public void setPlatOderCde(String platOderCde) {
        this.platOderCde = platOderCde;
    }

    public String getShopId() {
        return shopId;
    }

    public void setShopId(String shopId) {
        this.shopId = shopId;
    }

    public String getShopNme() {
        return shopNme;
    }

    public void setShopNme(String shopNme) {
        this.shopNme = shopNme;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getSysTradeStatus() {
        return sysTradeStatus;
    }

    public void setSysTradeStatus(String sysTradeStatus) {
        this.sysTradeStatus = sysTradeStatus;
    }

    public String getBuyer() {
        return buyer;
    }

    public void setBuyer(String buyer) {
        this.buyer = buyer;
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

    public String getReceiverStateName() {
        return receiverStateName;
    }

    public void setReceiverStateName(String receiverStateName) {
        this.receiverStateName = receiverStateName;
    }

    public String getReceiverCityNmae() {
        return receiverCityNmae;
    }

    public void setReceiverCityNmae(String receiverCityNmae) {
        this.receiverCityNmae = receiverCityNmae;
    }

    public String getReceiverDistrictName() {
        return receiverDistrictName;
    }

    public void setReceiverDistrictName(String receiverDistrictName) {
        this.receiverDistrictName = receiverDistrictName;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverZip() {
        return receiverZip;
    }

    public void setReceiverZip(String receiverZip) {
        this.receiverZip = receiverZip;
    }

    public String getBuyerPayment() {
        return buyerPayment;
    }

    public void setBuyerPayment(String buyerPayment) {
        this.buyerPayment = buyerPayment;
    }

    public String getBuyerNeedPay() {
        return buyerNeedPay;
    }

    public void setBuyerNeedPay(String buyerNeedPay) {
        this.buyerNeedPay = buyerNeedPay;
    }

    public String getBuyerPostFee() {
        return buyerPostFee;
    }

    public void setBuyerPostFee(String buyerPostFee) {
        this.buyerPostFee = buyerPostFee;
    }

    public String getDiscountFee() {
        return discountFee;
    }

    public void setDiscountFee(String discountFee) {
        this.discountFee = discountFee;
    }

    public String getBuyerPayType() {
        return buyerPayType;
    }

    public void setBuyerPayType(String buyerPayType) {
        this.buyerPayType = buyerPayType;
    }

    public String getExpressId() {
        return expressId;
    }

    public void setExpressId(String expressId) {
        this.expressId = expressId;
    }

    public String getExpressCode() {
        return expressCode;
    }

    public void setExpressCode(String expressCode) {
        this.expressCode = expressCode;
    }

    public String getExpressName() {
        return expressName;
    }

    public void setExpressName(String expressName) {
        this.expressName = expressName;
    }

    public String getOutSid() {
        return outSid;
    }

    public void setOutSid(String outSid) {
        this.outSid = outSid;
    }

    public String getBuyerMessage() {
        return buyerMessage;
    }

    public void setBuyerMessage(String buyerMessage) {
        this.buyerMessage = buyerMessage;
    }

    public String getSellerMessage() {
        return sellerMessage;
    }

    public void setSellerMessage(String sellerMessage) {
        this.sellerMessage = sellerMessage;
    }

    public String getInnerMemo() {
        return innerMemo;
    }

    public void setInnerMemo(String innerMemo) {
        this.innerMemo = innerMemo;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getLackStock() {
        return lackStock;
    }

    public void setLackStock(String lackStock) {
        this.lackStock = lackStock;
    }

    public String getPlatCreateTime() {
        return platCreateTime;
    }

    public void setPlatCreateTime(String platCreateTime) {
        this.platCreateTime = platCreateTime;
    }

    public String getPlatPayTime() {
        return platPayTime;
    }

    public void setPlatPayTime(String platPayTime) {
        this.platPayTime = platPayTime;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getConfirmTime() {
        return confirmTime;
    }

    public void setConfirmTime(String confirmTime) {
        this.confirmTime = confirmTime;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public String getDepositBank() {
        return depositBank;
    }

    public void setDepositBank(String depositBank) {
        this.depositBank = depositBank;
    }

    public String getRegisteredAddress() {
        return registeredAddress;
    }

    public void setRegisteredAddress(String registeredAddress) {
        this.registeredAddress = registeredAddress;
    }

    public String getRegisteredPhone() {
        return registeredPhone;
    }

    public void setRegisteredPhone(String registeredPhone) {
        this.registeredPhone = registeredPhone;
    }

    public String getTaxpayerIdent() {
        return taxpayerIdent;
    }

    public void setTaxpayerIdent(String taxpayerIdent) {
        this.taxpayerIdent = taxpayerIdent;
    }

    public String getInvoiceKind() {
        return invoiceKind;
    }

    public void setInvoiceKind(String invoiceKind) {
        this.invoiceKind = invoiceKind;
    }

    public String getInvoiceName() {
        return invoiceName;
    }

    public void setInvoiceName(String invoiceName) {
        this.invoiceName = invoiceName;
    }

    public List<DstOrderGoodsChild> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<DstOrderGoodsChild> goodsList) {
        this.goodsList = goodsList;
    }
}
