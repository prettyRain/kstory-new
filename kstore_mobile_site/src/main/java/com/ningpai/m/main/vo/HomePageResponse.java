package com.ningpai.m.main.vo;

import java.io.Serializable;
import java.util.List;

/**
 * dll
 */
public class HomePageResponse implements Serializable{

    private List<HomePageSliders> sliders;

    private List<HomePageGoods> goodsInfoList;

    private Long sorting;

    public HomePageResponse(List<HomePageSliders> sliders, List<HomePageGoods> goodsInfoList,Long sorting) {
        this.sliders = sliders;
        this.goodsInfoList = goodsInfoList;
        this.sorting = sorting;
    }

    public HomePageResponse() {
    }

    public HomePageResponse(List<HomePageSliders> sliderss, List<HomePageGoods> goodsInfos) {
        this.sliders = sliderss;
        this.goodsInfoList = goodsInfos;
    }

    public List<HomePageSliders> getSliders() {
        return sliders;
    }

    public void setSliders(List<HomePageSliders> sliders) {
        this.sliders = sliders;
    }

    public List<HomePageGoods> getGoodsInfoList() {
        return goodsInfoList;
    }

    public void setGoodsInfoList(List<HomePageGoods> goodsInfoList) {
        this.goodsInfoList = goodsInfoList;
    }

    public Long getSorting() {
        return sorting;
    }

    public void setSorting(Long sorting) {
        this.sorting = sorting;
    }
}
