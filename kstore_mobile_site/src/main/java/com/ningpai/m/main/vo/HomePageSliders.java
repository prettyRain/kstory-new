package com.ningpai.m.main.vo;

import java.io.Serializable;

/**
 * dll
 */
public class HomePageSliders implements Serializable{

    private String img;

    private String action;

    private String actionParam;

    public HomePageSliders(String img, String action, String actionParam) {
        this.img = img;
        this.action = action;
        this.actionParam = actionParam;
    }

    public HomePageSliders() {
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getActionParam() {
        return actionParam;
    }

    public void setActionParam(String actionParam) {
        this.actionParam = actionParam;
    }
}
