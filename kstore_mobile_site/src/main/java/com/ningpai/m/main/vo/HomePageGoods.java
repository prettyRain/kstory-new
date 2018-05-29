package com.ningpai.m.main.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * dll
 */
public class HomePageGoods implements Serializable{

    private Long id;

    private String name;

    private String image;

    private BigDecimal preferPrice;

    private double finalPrice;

    public HomePageGoods(Long id, String name, String image, BigDecimal preferPrice,double finalPrice) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.preferPrice = preferPrice;
        this.finalPrice = finalPrice;
    }

    public HomePageGoods() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public BigDecimal getPreferPrice() {
        return preferPrice;
    }

    public void setPreferPrice(BigDecimal preferPrice) {
        this.preferPrice = preferPrice;
    }

    public double getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
    }
}
