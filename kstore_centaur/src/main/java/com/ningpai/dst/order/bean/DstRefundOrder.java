package com.ningpai.dst.order.bean;

import java.util.List;

/**
 * 电商通查询售后单对象
 */
public class DstRefundOrder {
    //售后单号
    private String refundCode;
    //原交易编号
    private String tid;
    //发货单号
    private String sendCode;
    //仓库编号
    private String warehouseId;
    //仓库名称
    private String warehouseName;
    //买家Id
    private String buyerNick;
    //联系人
    private String contactName;
    //联系电话
    private String contactPhone;
    //联系手机
    private String contactMobile;
    //省编码
    private String state;
    //市编码
    private String city;
    //区编码
    private String district;
    //省
    private String stateName;
    //市
    private String cityName;
    //区
    private String districtName;
    //联系人地址
    private String contactAddress;
    //店铺编号
    private String shopId;
    //店铺名称
    private String shopName;
    //售后新建时间
    private String createTime;
    //审核时间
    private String auditTime;
    //标记发货时间
    private String sendTime;
    //寄回快递公司
    private String companyName;
    //快递单号
    private String expressCode;
    //备注
    private String remarks;
    //售后总金额
    private String money;
    //售后商品列表
    private List<DstRefundOrderGoods> refundOrderGoodsList;

    public String getRefundCode() {
        return refundCode;
    }

    public void setRefundCode(String refundCode) {
        this.refundCode = refundCode;
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public String getSendCode() {
        return sendCode;
    }

    public void setSendCode(String sendCode) {
        this.sendCode = sendCode;
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

    public String getBuyerNick() {
        return buyerNick;
    }

    public void setBuyerNick(String buyerNick) {
        this.buyerNick = buyerNick;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getContactMobile() {
        return contactMobile;
    }

    public void setContactMobile(String contactMobile) {
        this.contactMobile = contactMobile;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getStateName() {
        return stateName;
    }

    public void setStateName(String stateName) {
        this.stateName = stateName;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public String getContactAddress() {
        return contactAddress;
    }

    public void setContactAddress(String contactAddress) {
        this.contactAddress = contactAddress;
    }

    public String getShopId() {
        return shopId;
    }

    public void setShopId(String shopId) {
        this.shopId = shopId;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(String auditTime) {
        this.auditTime = auditTime;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getExpressCode() {
        return expressCode;
    }

    public void setExpressCode(String expressCode) {
        this.expressCode = expressCode;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public List<DstRefundOrderGoods> getRefundOrderGoodsList() {
        return refundOrderGoodsList;
    }

    public void setRefundOrderGoodsList(List<DstRefundOrderGoods> refundOrderGoodsList) {
        this.refundOrderGoodsList = refundOrderGoodsList;
    }
}
