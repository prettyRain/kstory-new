package com.ningpai.order.bean;

/**
 * Created by Administrator on 2017/5/10.
 * xcy
 */
public class OrderDistribution {
    private Long  distributionId;//id
    private Long orderId;//订单id
    private String salesman;//业务员
    private String cart;//车辆
    private String motorman;//司机
    private String logistics;//物流公司
    private String logisticsMobile;//物流联系方式

    public Long getDistributionId() {
        return distributionId;
    }

    public void setDistributionId(Long distributionId) {
        this.distributionId = distributionId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getSalesman() {
        return salesman;
    }

    public void setSalesman(String salesman) {
        this.salesman = salesman;
    }

    public String getCart() {
        return cart;
    }

    public void setCart(String cart) {
        this.cart = cart;
    }

    public String getMotorman() {
        return motorman;
    }

    public void setMotorman(String motorman) {
        this.motorman = motorman;
    }

    public String getLogistics() {
        return logistics;
    }

    public void setLogistics(String logistics) {
        this.logistics = logistics;
    }

    public String getLogisticsMobile() {
        return logisticsMobile;
    }

    public void setLogisticsMobile(String logisticsMobile) {
        this.logisticsMobile = logisticsMobile;
    }
}
