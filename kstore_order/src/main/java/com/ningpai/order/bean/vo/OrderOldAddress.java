package com.ningpai.order.bean.vo;

/**
 * 订单旧地址
 * Created by Administrator on 2017/4/20.
 */
public class OrderOldAddress {
    //id
    private Long oldAddressId;
    //订单id
    private Long orderId;
    //订单编号
    private String  orderCode;
    //省
    private String  province;
    //市
    private String  city;
    //区县
    private String  county;
    //地址
    private String  address;
    //收货人
    private String  person;
    //固定电话
    private String  phone;
    //手机号
    private String  mobile;
    //邮编
    private String  postCode;
    //0 送货上门   1 自提
    private String  expressType;
    //社区店id
    private Long communityId;

    public Long getOldAddressId() {
        return oldAddressId;
    }

    public void setOldAddressId(Long oldAddressId) {
        this.oldAddressId = oldAddressId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getExpressType() {
        return expressType;
    }

    public void setExpressType(String expressType) {
        this.expressType = expressType;
    }

    public Long getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Long communityId) {
        this.communityId = communityId;
    }
}
