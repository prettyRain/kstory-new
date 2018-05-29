package com.ningpai.app.setting.index;

import com.ningpai.app.setting.Document;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Setter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 楼层
 * Created by aqlu on 15/12/6.
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class Floor extends Document {

    public Floor() {
    }

    public Floor(String text, String action, String template, Integer ordering, String themeCode, String backgroundColor, String secondColor) {
        this.text = text;
        this.action = action;
        this.ordering = ordering;
        this.template = template;
        this.themeCode = themeCode;
        this.backgroundColor = backgroundColor;
        this.secondColor = secondColor;
    }

    /**
     * 文本
     */
    private String text;

    /**
     * 横幅图片
     */
    private List<Advert> banners = new ArrayList<>(0);

    /**
     * 楼层模板
     */
    private String template;

    /**
     * 动作
     */
    private String action;

    /**
     * 主题编码 默认为首页配置
     */
    private String themeCode = "home";

    /**
     * 背景色
     */
    private String backgroundColor;

    /**
     * 第二背景色
     */
    private String secondColor;

    /**
     * 动作参数
     */
    @SuppressWarnings("MismatchedQueryAndUpdateOfCollection")
    @Setter(AccessLevel.PROTECTED)
    private Map<String, Object> actionParam = new HashMap<>(0);

    /**
     * 排序值，值越小越靠前
     */
    private Integer ordering;

    /**
     * 广告列表
     */
//    @Field( type = FieldType.Nested)
    private List<Advert> adverts = new ArrayList<>(0);

    public Map<String, Object> putActionParam(String key, Object value) {
        this.actionParam.put(key, value);
        return actionParam;
    }

    public Map<String, Object> removeActionParam(String key) {
        this.actionParam.remove(key);
        return actionParam;
    }

    public List<Advert> addAdvert(Advert advert) {
        adverts.add(advert);
        return adverts;
    }

    public List<Advert> removeAdvert(Advert advert) {
        adverts.remove(advert);
        return adverts;
    }

    public List<Advert> removeAdvert(int index) {
        adverts.remove(index);
        return adverts;
    }

    public List<Advert> addBanner(Advert advert) {
        banners.add(advert);
        return banners;
    }

    public List<Advert> removeBanner(Advert advert) {
        banners.remove(advert);
        return banners;
    }

    public List<Advert> removeBanner(int index) {
        banners.remove(index);
        return banners;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public List<Advert> getBanners() {
        return banners;
    }

    public void setBanners(List<Advert> banners) {
        this.banners = banners;
    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getThemeCode() {
        return themeCode;
    }

    public void setThemeCode(String themeCode) {
        this.themeCode = themeCode;
    }

    public String getBackgroundColor() {
        return backgroundColor;
    }

    public void setBackgroundColor(String backgroundColor) {
        this.backgroundColor = backgroundColor;
    }

    public String getSecondColor() {
        return secondColor;
    }

    public void setSecondColor(String secondColor) {
        this.secondColor = secondColor;
    }

    public Map<String, Object> getActionParam() {
        return actionParam;
    }

    public void setActionParam(Map<String, Object> actionParam) {
        this.actionParam = actionParam;
    }

    public Integer getOrdering() {
        return ordering;
    }

    public void setOrdering(Integer ordering) {
        this.ordering = ordering;
    }

    public List<Advert> getAdverts() {
        return adverts;
    }

    public void setAdverts(List<Advert> adverts) {
        this.adverts = adverts;
    }
}
